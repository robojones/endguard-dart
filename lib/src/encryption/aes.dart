import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/protos/protocol.pb.dart';

final aes = AesGcm.with256bits();

class AES {
  /// Decrypts an AES256-GCM [encryptedMessage] using the [key]
  /// and authenticates the additional authenticated data [aad]
  static Future<Uint8List> decryptAES256_GCM(
      EncryptedMessage encryptedMessage, SecretKeyData key, { Uint8List aad }) async {
    aad ??= Uint8List(0);

    final mac = Mac(encryptedMessage.mac);
    final secretBox = SecretBox(encryptedMessage.ciphertext, nonce: encryptedMessage.nonce, mac: mac);

    final plaintext = await aes.decrypt(
      secretBox,
      secretKey: key,
      aad: aad,
    );

    return Uint8List.fromList(plaintext);
  }

  /// Encrypts a [plaintext] message using the [key]
  /// and includes the additional authenticated data [aad] in the mac.
  static Future<EncryptedMessage> encryptAES256_GCM(
      Uint8List plaintext, SecretKeyData k, { Uint8List aad }) async {
    aad ??= Uint8List(0);

    final secretBox = await aes.encrypt(
      plaintext,
      secretKey: k,
      nonce: aes.newNonce(),
      aad: aad,
    );

    final e = EncryptedMessage();
    e.nonce = secretBox.nonce;
    e.mac = secretBox.mac.bytes;
    e.ciphertext = secretBox.cipherText;
    return e;
  }
}
