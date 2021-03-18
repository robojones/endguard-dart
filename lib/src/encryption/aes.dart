import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/protos/protocol.pb.dart';

final aes = AesGcm.with256bits();

class AES {
  static Future<Uint8List> aesCbcDecrypt(
      EncryptedMessage e, SecretKeyData k) async {
    final mac = Mac(e.mac);
    final secretBox = SecretBox(e.ciphertext, nonce: e.nonce, mac: mac);

    final plaintext = await aes.decrypt(
      secretBox,
      secretKey: k,
    );

    return Uint8List.fromList(plaintext);
  }

  static Future<EncryptedMessage> aesCbcEncrypt(
      Uint8List plaintext, SecretKeyData k) async {
    final secretBox = await aes.encrypt(
      plaintext,
      secretKey: k,
      nonce: aes.newNonce(),
    );

    final e = EncryptedMessage();
    e.nonce = secretBox.nonce;
    e.mac = secretBox.mac.bytes;
    e.ciphertext = secretBox.cipherText;
    return e;
  }
}
