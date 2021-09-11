import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/crypto/message_encryption.dart';
import 'package:endguard/src/crypto/exception.dart';
import 'package:endguard/src/handshake/message.dart';
import 'package:endguard/src/protos/protocol.pb.dart';

/// The hash algorithm that is used by the InitialPackageEncryption.
final sha = Sha256();

/// The encryption for the packages of the handshake.
/// Handshake packages are encrypted using the SHA256 hash of their plaintext
/// as key.
class HandshakeEncryption {
  /// Generates the SHA256 hash of the [plaintext].
  static Future<SecretKeyData> _hashSHA256(Uint8List plaintext,
      {required Uint8List? aad}) async {
    aad ??= Uint8List(0);
    final hash = await sha.hash(aad + plaintext);
    final key = SecretKeyData(hash.bytes);
    return key;
  }

  /// Validates that the [key] actually equals the SHA256 hash of the [plaintext].
  static Future<void> _validatePackage(Uint8List plaintext,
      {required SecretKey key,
      required Uint8List encryptedMessage,
      required Uint8List? aad}) async {
    final checksum = await _hashSHA256(plaintext, aad: aad);
    if (checksum != key) {
      throw MessageAuthenticationException(encryptedMessage: encryptedMessage);
    }
  }

  /// Encrypts a [message] using its SHA256 hash as key.
  static Future<HandshakeMessage> encryptMessage(Uint8List message,
      {required Algorithm algorithm, required Uint8List? aad}) async {
    final key = await _hashSHA256(message, aad: aad);
    final e = await MessageEncryption.encrypt(message, key,
        algorithm: algorithm, aad: aad);
    final bytes = e.writeToBuffer();

    return HandshakeMessage(bytes, key: key);
  }

  /// Decrypts an encrypted [message] using the [key].
  static Future<Uint8List> decryptMessage(Uint8List message,
      {required SecretKey key, required Uint8List? aad}) async {
    final bytes = await MessageEncryption.decrypt(message, key, aad: aad);
    await _validatePackage(bytes,
        key: key, encryptedMessage: message, aad: aad);
    return bytes;
  }
}
