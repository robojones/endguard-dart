import 'package:endguard/src/protos/protocol.pb.dart';

export 'package:endguard/src/protos/protocol.pb.dart' show State;

enum Operation {
  ExportState,
  CreateConnectionOffer,
  ApplyConnectionOffer,
  ApplyConnectionConfirmation,
  EncryptMessage,
  DecryptMessage,
}

String _operationDescription(Operation op) {
  switch (op) {
    case Operation.ExportState:
      return 'export the connection state';
    case Operation.CreateConnectionOffer:
      return 'create a new ConnectionOffer';
    case Operation.ApplyConnectionOffer:
      return 'apply a ConnectionOffer';
    case Operation.ApplyConnectionConfirmation:
      return 'apply a ConnectionConfirmation package';
    case Operation.EncryptMessage:
      return 'encrypt a message';
    case Operation.DecryptMessage:
      return 'decrypt a message';
    default:
      throw 'an unknown operation';
  }
}

String _stateDescription(State s) {
  switch (s) {
    case State.NOT_INITIALIZED:
      return 'connection is not initialized';
    case State.HANDSHAKE:
      return 'handshake is not complete yet';
    case State.ESTABLISHED:
      return 'connection is established';
    default:
      return 'connection is in an unknown state';
  }
}

class InvalidOperationException implements Exception {
  final State state;
  final Operation operation;
  final String message;

  InvalidOperationException(this.state, this.operation)
      : message =
            'can not ${_operationDescription(operation)} while the ${_stateDescription(state)} (${operation.toString()} in ${state.toString()})';
}
