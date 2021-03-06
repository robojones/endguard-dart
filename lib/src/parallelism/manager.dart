import 'dart:typed_data';

import 'package:endguard/src/parallelism/exception.dart';
import 'package:endguard/src/parallelism/operations.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/state/state_accessor.dart';

final _emptyList = Uint8List(0);

class ParallelismManager {
  final StateAccessor _stateAccessor;

  Operation? _activeOperation;
  Uint8List _stateSnapshot;

  ParallelismManager(this._stateAccessor): _stateSnapshot = _emptyList;

  void _beginOperation(Operation o) {
    if (_activeOperation != null) {
      throw StateError(
          'can not start `${o.toString()}`: operation `${_activeOperation.toString()}` is not complete yet');
    }
    _activeOperation = o;
    _stateSnapshot = _stateAccessor.exportState();
  }

  void _completeOperation({bool restoreState = false}) {
    if (_activeOperation == null) {
      throw StateError('can not complete operation: no operation active');
    }
    _activeOperation = null;

    if (restoreState) {
      _stateAccessor.importState(_stateSnapshot);
    }
    _stateSnapshot = _emptyList;
  }

  /// isIdle is true while there is no active operation.
  bool get isIdle {
    return _activeOperation == null;
  }

  /// beginOperation checks if an operation can be performed in the current state of the connection.
  /// If the operation can not be performed in the current connection state, an InvalidOperationException is thrown.
  /// There MUST be no concurrent operations.
  /// An Error is thrown if beginOperation is called before the previous operation was completed with completeOperation() or abortOperation().
  void beginOperation(Operation o) {
    final currentState = _stateAccessor.initializationState;
    if (o == Operation.exportState) {
      _beginOperation(o);
    } else if (o == Operation.updateConnectionSettings) {
      _beginOperation(o);
    } else if (o == Operation.createConnectionOffer &&
        currentState == ConnectionState_State.NOT_INITIALIZED) {
      _beginOperation(o);
    } else if (o == Operation.applyConnectionOffer &&
        currentState == ConnectionState_State.NOT_INITIALIZED) {
      _beginOperation(o);
    } else if (o == Operation.applyConnectionConfirmation &&
        currentState == ConnectionState_State.HANDSHAKE) {
      _beginOperation(o);
    } else if (o == Operation.encryptMessage &&
        currentState == ConnectionState_State.ESTABLISHED) {
      _beginOperation(o);
    } else if (o == Operation.decryptMessage &&
        currentState == ConnectionState_State.ESTABLISHED) {
      _beginOperation(o);
    } else {
      throw InvalidOperationError(currentState, o);
    }
  }

  /// abortOperation marks the active operation as complete and restores the original state.
  void abortOperation() {
    _completeOperation(restoreState: true);
  }

  /// completeOperation marks the active operation as complete.
  /// If the active operation implies a state change then the state is updated.
  void completeOperation() {
    var o = _activeOperation;

    if (o == Operation.createConnectionOffer) {
      _stateAccessor.initializationState = ConnectionState_State.HANDSHAKE;
    } else if (o == Operation.applyConnectionOffer) {
      _stateAccessor.initializationState = ConnectionState_State.ESTABLISHED;
    } else if (o == Operation.applyConnectionConfirmation) {
      _stateAccessor.initializationState = ConnectionState_State.ESTABLISHED;
    }

    _completeOperation(restoreState: false);
  }
}
