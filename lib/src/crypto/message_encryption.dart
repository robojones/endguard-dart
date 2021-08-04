import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/crypto/exception.dart';
import 'package:endguard/src/protos/protocol.pb.dart';

/// The AES256-GCM block cipher algorithm.
final aes = AesGcm.with256bits();

/// The ChaCha20-Poly1305 stream cipher algorithm.
final chaCha = Chacha20.poly1305Aead();

/// The HMAC MAC algorithm.
final hmac = Hmac.sha256();

/// The HKDF key derivation algorithm with 256 bit key length.
final hkdf = Hkdf(hmac: hmac, outputLength: 32);

/// A simplified API for the AES256-GCM block cipher encryption.
class MessageEncryption {
  static Cipher _getCipherAlgorithm(Algorithm algorithm) {
    switch (algorithm) {
      case Algorithm.CHACHA20_POLY1305_HMAC:
        return chaCha;
      case Algorithm.AES256_GCM_HMAC:
        return aes;
      default:
        throw UnimplementedError(
            'Cipher ${algorithm.toString()} not supported');
    }
  }

  static KdfAlgorithm _getKeyDerivationAlgorithm(Algorithm algorithm) {
    switch (algorithm) {
      case Algorithm.CHACHA20_POLY1305_HMAC:
      case Algorithm.AES256_GCM_HMAC:
        return hkdf;
      default:
        throw UnimplementedError(
            'Cipher ${algorithm.toString()} not supported');
    }
  }

  static MacAlgorithm _getMacAlgorithm(Algorithm algorithm) {
    switch (algorithm) {
      case Algorithm.CHACHA20_POLY1305_HMAC:
      case Algorithm.AES256_GCM_HMAC:
        return hmac;
      default:
        throw UnimplementedError(
            'Cipher ${algorithm.toString()} not supported');
    }
  }

  /// Decrypts an AES256-GCM [encryptedMessage] using the [key]
  /// and authenticates the additional authenticated data [aad]
  static Future<Uint8List> decrypt(
      EncryptedMessage encryptedMessage, SecretKey key,
      {Uint8List? aad}) async {
    aad ??= Uint8List(0);

    // select algorithms
    final algorithm = encryptedMessage.algorithm;
    final cipher = _getCipherAlgorithm(algorithm);
    final keyDerivation = _getKeyDerivationAlgorithm(algorithm);
    final macAlgorithm = _getMacAlgorithm(algorithm);

    // create secret box
    final mac = Mac(encryptedMessage.mac);
    final secondaryMac = Mac(encryptedMessage.secondaryMac);
    final secretBox = SecretBox(encryptedMessage.ciphertext,
        nonce: encryptedMessage.nonce, mac: mac);

    // validate secondary mac
    final secondaryMacKey = await keyDerivation.deriveKey(
        secretKey: key, nonce: encryptedMessage.secondaryMacNonce);
    final wantSecondaryMac = await macAlgorithm.calculateMac(
        encryptedMessage.ciphertext + aad,
        secretKey: secondaryMacKey);
    if (secondaryMac != wantSecondaryMac) {
      throw MessageAuthenticationException(encryptedMessage: encryptedMessage);
    }

    // decryption
    final encryptionKey = await keyDerivation.deriveKey(
        secretKey: key, nonce: encryptedMessage.nonce);

    List<int> plaintext;
    try {
      plaintext = await cipher.decrypt(
        secretBox,
        secretKey: encryptionKey,
        aad: aad,
      );
    } on SecretBoxAuthenticationError {
      throw MessageAuthenticationException(encryptedMessage: encryptedMessage);
    }

    return Uint8List.fromList(plaintext);
  }

  /// Encrypts a [plaintext] message using the [key]
  /// and includes the additional authenticated data [aad] in the mac.
  static Future<EncryptedMessage> encrypt(
      Uint8List plaintext, SecretKey key,
      {Uint8List? aad, required Algorithm algorithm}) async {
    aad ??= Uint8List(0);

    // select algorithms
    final cipher = _getCipherAlgorithm(algorithm);
    final keyDerivation = _getKeyDerivationAlgorithm(algorithm);
    final macAlgorithm = _getMacAlgorithm(algorithm);

    // encryption
    final nonce = cipher.newNonce();
    final encryptionKey =
        await keyDerivation.deriveKey(secretKey: key, nonce: nonce);
    final secretBox = await cipher.encrypt(
      plaintext,
      secretKey: encryptionKey,
      nonce: nonce,
      aad: aad,
    );

    // calculate secondary mac
    final secondaryMacNone = cipher.newNonce();
    final secondaryMacKey = await keyDerivation.deriveKey(
        secretKey: key, nonce: secondaryMacNone);
    final secondaryMac = await macAlgorithm
        .calculateMac(secretBox.cipherText + aad, secretKey: secondaryMacKey);

    final e = EncryptedMessage();
    e.algorithm = algorithm;
    e.nonce = nonce;
    e.mac = secretBox.mac.bytes;
    e.ciphertext = secretBox.cipherText;
    e.secondaryMacNonce = secondaryMacNone;
    e.secondaryMac = secondaryMac.bytes;
    return e;
  }
}
