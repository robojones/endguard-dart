import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/exception/handshake_exception.dart';
import 'package:endguard/src/protos/protocol.pb.dart';

import 'aes.dart';

final sha = Sha256();

class EncryptedPackage {
  final Uint8List _ciphertext;
  final SecretKey _key;

  EncryptedPackage(Uint8List ciphertext, {SecretKey key})
      : _ciphertext = ciphertext,
        _key = key;

  Uint8List exportPackage() {
    return _ciphertext;
  }

  SecretKey exportKey() {
    return _key;
  }
}

class InitialPackageEncryption {
  Future<SecretKey> _generate256BitKey(Uint8List plaintext) async {
    final hash = await sha.hash(plaintext);
    final key = SecretKeyData(hash.bytes);
    return key;
  }

  Future<void> _validatePackage(Uint8List plaintext, SecretKey key) async {
    final checksum = await _generate256BitKey(plaintext);
    if (checksum != key) {
      throw InvalidHandshakePackageException(
          'validation failed: wrong key/checksum');
    }
  }

  Future<EncryptedPackage> encryptPackage(Uint8List package) async {
    final key = await _generate256BitKey(package);
    final e = await AES.aesCbcEncrypt(package, key);
    final bytes = e.writeToBuffer();

    return EncryptedPackage(bytes, key: key);
  }

  Future<Uint8List> decryptPackage(Uint8List package, {SecretKey key}) async {
    final e = EncryptedMessage.fromBuffer(package);

    final bytes = await AES.aesCbcDecrypt(e, key);
    await _validatePackage(bytes, key);
    return bytes;
  }
}
