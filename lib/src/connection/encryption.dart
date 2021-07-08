import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/encryption/aes.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/ratchets/diffie_hellman.dart';
import 'package:endguard/src/ratchets/sha_256.dart';

class Encryption {
  final DiffieHellmanRatchet _diffieHellmanRatchet;
  final SHA256Ratchet _sha256Ratchet;

  Encryption(this._diffieHellmanRatchet, this._sha256Ratchet);

  Future<SecretKeyData> _deriveEncryptionKey() async {
    final sha256RatchetValue = _sha256Ratchet.outgoingRatchetValue;
    final diffieHellmanRatchetValue =
        _diffieHellmanRatchet.outgoingRatchetValue;

    final keyMaterial =
        diffieHellmanRatchetValue.bytes + sha256RatchetValue.bytes;

    final hash = await sha.hash(keyMaterial);

    return SecretKeyData(hash.bytes);
  }

  Future<SecretKeyData> _deriveDecryptionKey() async {
    final sha256RatchetValue = _sha256Ratchet.incomingRatchetValue;
    final diffieHellmanRatchetValue =
        _diffieHellmanRatchet.incomingRatchetValue;

    final keyMaterial =
        diffieHellmanRatchetValue.bytes + sha256RatchetValue.bytes;

    final hash = await sha.hash(keyMaterial);

    return SecretKeyData(hash.bytes);
  }

  Future<Uint8List> decrypt(Uint8List package) async {
    final e = EncryptedMessage.fromBuffer(package);

    // derive incoming key
    final key = await _deriveDecryptionKey();

    final envelopeBytes = await AES.decryptAES256_GCM(e, key);
    final envelope = Envelope.fromBuffer(envelopeBytes);

    // advance Diffie-Hellman ratchet
    final remotePk = SimplePublicKey(envelope.senderNewDiffieHellmanPublicKey,
        type: KeyPairType.x25519);
    _diffieHellmanRatchet.remoteDiffieHellmanKey = remotePk;
    final localPk = SimplePublicKey(envelope.recipientDiffieHellmanPublicKey,
        type: KeyPairType.x25519);
    await _diffieHellmanRatchet.advanceIncomingDiffieHellmanRatchet(localPk);

    // advance SHA-256 ratchet
    await _sha256Ratchet.advanceIncomingRatchet(envelopeBytes);

    return envelope.payload;
  }

  Future<Uint8List> encrypt(Uint8List plaintext) async {
    // derive outgoing key
    final key = await _deriveEncryptionKey();

    // generate new local key
    final localKeyPair =
        await _diffieHellmanRatchet.generateAndAddLocalDiffieHellmanKeyPair();

    // prepare envelope
    final remotePk = _diffieHellmanRatchet.remoteDiffieHellmanKey;
    final localPk = await localKeyPair.extractPublicKey();
    final envelope = Envelope();
    envelope.recipientDiffieHellmanPublicKey = remotePk.bytes;
    envelope.senderNewDiffieHellmanPublicKey = localPk.bytes;
    envelope.payload = plaintext;
    final envelopeBytes = envelope.writeToBuffer();

    // encrypt
    final e = await AES.encryptAES256_GCM(envelopeBytes, key);

    // advance Diffie-Hellman ratchet
    await _diffieHellmanRatchet.advanceOutgoingDiffieHellmanRatchet();

    // advance SHA-256 ratchet
    await _sha256Ratchet.advanceOutgoingRatchet(envelopeBytes);

    final bytes = e.writeToBuffer();

    return bytes;
  }
}
