import 'package:endguard/src/parallelism/operations.dart';
import 'package:endguard/src/protos/protocol.pb.dart';

export 'package:endguard/src/parallelism/operations.dart' show Operation;
export 'package:endguard/src/protos/protocol.pb.dart'
    show ConnectionState_State;

String _operationDescription(Operation op) {
  switch (op) {
    case Operation.exportState:
      return 'export the connection state';
    case Operation.updateConnectionSettings:
      return 'update the settings for the connection';
    case Operation.createConnectionOffer:
      return 'create a new ConnectionOffer';
    case Operation.applyConnectionOffer:
      return 'apply a ConnectionOffer';
    case Operation.applyConnectionConfirmation:
      return 'apply a ConnectionConfirmation';
    case Operation.encryptMessage:
      return 'encrypt a message';
    case Operation.decryptMessage:
      return 'decrypt a message';
    default:
      return '<unknown operation>';
  }
}

String _stateDescription(ConnectionState_State s) {
  switch (s) {
    case ConnectionState_State.NOT_INITIALIZED:
      return 'connection is not initialized';
    case ConnectionState_State.HANDSHAKE:
      return 'handshake is not complete yet';
    case ConnectionState_State.ESTABLISHED:
      return 'connection is established';
    default:
      return 'connection is in an unknown state';
  }
}

class InvalidOperationError extends StateError {
  final ConnectionState_State state;
  final Operation operation;

  InvalidOperationError(this.state, this.operation)
      : super(
            'can not ${_operationDescription(operation)} when the ${_stateDescription(state)} (${operation.toString()} in ${state.toString()} state)');
}
