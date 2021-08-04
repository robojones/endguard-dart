import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// A ciphertext of a handshake package and the key used to encrypt it.
class HandshakeMessage {
  final Uint8List _ciphertext;
  final SecretKey _key;

  HandshakeMessage(Uint8List ciphertext, {required SecretKey key})
      : _ciphertext = ciphertext,
        _key = key;

  /// Returns the ciphertext of the package.
  Uint8List exportPackage() {
    return _ciphertext;
  }

  /// Returns the key that was used to encrypt the package.
  SecretKey exportKey() {
    return _key;
  }
}
