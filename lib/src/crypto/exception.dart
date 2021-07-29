import 'package:endguard/src/protos/protocol.pb.dart';

class MessageAuthenticationException implements Exception {
  EncryptedMessage encryptedMessage;
  final String message;

  MessageAuthenticationException({ this.encryptedMessage })
      : message =
  'EncryptedMessage has wrong message authentication code (MAC)';
}