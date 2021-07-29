import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/crypto/encryption.dart';
import 'package:endguard/src/handshake/exception.dart';
import 'package:endguard/src/handshake/message.dart';
import 'package:endguard/src/protos/protocol.pb.dart';

/// The hash algorithm that is used by the InitialPackageEncryption.
final sha = Sha256();

/// The encryption for the packages of the handshake.
/// Handshake packages are encrypted using the SHA256 hash of their plaintext
/// as key.
class HandshakeEncryption {
  /// Generates the SHA256 hash of the [plaintext].
  static Future<SecretKey> _hashSHA256(Uint8List plaintext) async {
    final hash = await sha.hash(plaintext);
    final key = SecretKeyData(hash.bytes);
    return key;
  }

  /// Validates that the [key] actually equals the SHA256 hash of the [plaintext].
  static Future<void> _validatePackage(
      Uint8List plaintext, SecretKey key) async {
    final checksum = await _hashSHA256(plaintext);
    if (checksum != key) {
      throw InvalidHandshakePackageException(
          'validation failed: wrong key/checksum');
    }
  }

  /// Encrypts a [package] using its SHA256 hash as key.
  static Future<HandshakeMessage> encryptMessage(Uint8List package,
      {Algorithm algorithm}) async {
    final key = await _hashSHA256(package);
    final e =
        await MessageEncryption.encrypt(package, key, algorithm: algorithm);
    final bytes = e.writeToBuffer();

    return HandshakeMessage(bytes, key: key);
  }

  /// Decrypts an encrypted [package] using the [key].
  static Future<Uint8List> decryptMessage(Uint8List package,
      {SecretKey key}) async {
    final e = EncryptedMessage.fromBuffer(package);

    final bytes = await MessageEncryption.decrypt(e, key);
    await _validatePackage(bytes, key);
    return bytes;
  }
}
