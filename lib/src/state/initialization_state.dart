import 'dart:typed_data';

import 'package:endguard/src/exception/operation_exception.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/state/state_accessor.dart';

class InitialisationStateManager {
  final StateAccessor _stateAccessor;

  Operation _activeOperation;
  Uint8List _stateSnapshot;

  InitialisationStateManager(this._stateAccessor);

  void _beginOperation(Operation o) {
    if (_activeOperation != null) {
      throw StateError(
          'can not start `${o.toString()}`: operation `${_activeOperation.toString()}` is not complete yet');
    }
    _activeOperation = o;
    _stateSnapshot = _stateAccessor.exportState();
  }

  void _completeOperation({bool restoreState}) {
    if (_activeOperation == null) {
      throw StateError('can not complete operation: no operation active');
    }
    _activeOperation = null;

    if (restoreState) {
      _stateAccessor.importState(_stateSnapshot);
    }
    _stateSnapshot = null;
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
    if (o == Operation.ExportState) {
      _beginOperation(o);
    } else if (o == Operation.UpdateConnectionSettings) {
      _beginOperation(o);
    } else if (o == Operation.CreateConnectionOffer &&
        currentState == ConnectionState_State.NOT_INITIALIZED) {
      _beginOperation(o);
    } else if (o == Operation.ApplyConnectionOffer &&
        currentState == ConnectionState_State.NOT_INITIALIZED) {
      _beginOperation(o);
    } else if (o == Operation.ApplyConnectionConfirmation &&
        currentState == ConnectionState_State.HANDSHAKE) {
      _beginOperation(o);
    } else if (o == Operation.EncryptMessage &&
        currentState == ConnectionState_State.ESTABLISHED) {
      _beginOperation(o);
    } else if (o == Operation.DecryptMessage &&
        currentState == ConnectionState_State.ESTABLISHED) {
      _beginOperation(o);
    } else {
      throw InvalidOperationException(currentState, o);
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

    if (o == Operation.CreateConnectionOffer) {
      _stateAccessor.initializationState = ConnectionState_State.HANDSHAKE;
    } else if (o == Operation.ApplyConnectionOffer) {
      _stateAccessor.initializationState = ConnectionState_State.ESTABLISHED;
    } else if (o == Operation.ApplyConnectionConfirmation) {
      _stateAccessor.initializationState = ConnectionState_State.ESTABLISHED;
    }

    _completeOperation(restoreState: false);
  }
}
