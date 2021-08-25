import 'dart:typed_data';

class MessageAuthenticationException implements Exception {
  /// Message that failed authentication
  Uint8List encryptedMessage;

  /// Exception error message
  final String message = 'EncryptedMessage has failed the authentication check';

  MessageAuthenticationException({required this.encryptedMessage});
}
