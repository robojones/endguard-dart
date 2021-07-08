import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/exception/handshake_exception.dart';
import 'package:endguard/src/protos/protocol.pb.dart';

import 'aes.dart';

/// The SHA256 hash algorithm that is used by the InitialPackageEncryption.
final sha = Sha256();

/// An EncryptedPackage contains the ciphertext of a package
/// and the key used to encrypt it.
class EncryptedPackage {
  final Uint8List _ciphertext;
  final SecretKey _key;

  EncryptedPackage(Uint8List ciphertext, {SecretKey key})
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

/// The InitialPackageEncryption is used to encrypt the packages
/// for the handshake.
class InitialPackageEncryption {
  /// Generates the SHA256 hash of the [plaintext].
  Future<SecretKey> _hashSHA256(Uint8List plaintext) async {
    final hash = await sha.hash(plaintext);
    final key = SecretKeyData(hash.bytes);
    return key;
  }

  /// Validates the [plaintext] and the [key] match.
  /// The [key] must be the exact SHA256 hash of the [plaintext].
  Future<void> _validatePackage(Uint8List plaintext, SecretKey key) async {
    final checksum = await _hashSHA256(plaintext);
    if (checksum != key) {
      throw InvalidHandshakePackageException(
          'validation failed: wrong key/checksum');
    }
  }

  /// Encrypts a [package] using its SHA256 hash as key.
  Future<EncryptedPackage> encryptPackage(Uint8List package) async {
    final key = await _hashSHA256(package);
    final e = await AES.encryptAES256_GCM(package, key);
    final bytes = e.writeToBuffer();

    return EncryptedPackage(bytes, key: key);
  }

  /// Decrypts an encrypted [package] using the [key].
  Future<Uint8List> decryptPackage(Uint8List package, {SecretKey key}) async {
    final e = EncryptedMessage.fromBuffer(package);

    final bytes = await AES.decryptAES256_GCM(e, key);
    await _validatePackage(bytes, key);
    return bytes;
  }
}
