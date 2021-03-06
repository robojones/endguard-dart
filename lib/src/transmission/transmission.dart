import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/crypto/message_encryption.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/crypto/diffie_hellman_ratchet.dart';
import 'package:endguard/src/crypto/sha256_ratchet.dart';

class Transmission {
  final DiffieHellmanRatchet _diffieHellmanRatchet;
  final SHA256Ratchet _sha256Ratchet;

  Transmission(this._diffieHellmanRatchet, this._sha256Ratchet);

  Future<SecretKeyData> _gatherEncryptionKeyMaterial() async {
    final sha256RatchetValue = _sha256Ratchet.outgoingRatchetValue;
    final diffieHellmanRatchetValue =
        _diffieHellmanRatchet.outgoingRatchetValue;

    return SecretKeyData(
        diffieHellmanRatchetValue.bytes + sha256RatchetValue.bytes);
  }

  Future<SecretKeyData> _gatherDecryptionKeyMaterial() async {
    final sha256RatchetValue = _sha256Ratchet.incomingRatchetValue;
    final diffieHellmanRatchetValue =
        _diffieHellmanRatchet.incomingRatchetValue;

    return SecretKeyData(
        diffieHellmanRatchetValue.bytes + sha256RatchetValue.bytes);
  }

  Future<Uint8List> decrypt(Uint8List message,
      {required Uint8List? aad}) async {
    // decrypt
    final keyMaterial = await _gatherDecryptionKeyMaterial();
    final envelopeBytes =
        await MessageEncryption.decrypt(message, keyMaterial, aad: aad);
    final envelope = Envelope.fromBuffer(envelopeBytes);

    // advance ratchets
    final remotePk = SimplePublicKey(envelope.senderNewDiffieHellmanPublicKey,
        type: KeyPairType.x25519);
    _diffieHellmanRatchet.remoteDiffieHellmanKey = remotePk;
    final localPk = SimplePublicKey(envelope.recipientDiffieHellmanPublicKey,
        type: KeyPairType.x25519);
    await _diffieHellmanRatchet.advanceIncomingDiffieHellmanRatchet(localPk);
    await _sha256Ratchet.advanceIncomingRatchet(envelopeBytes);

    return Uint8List.fromList(envelope.payload);
  }

  Future<Uint8List> encrypt(Uint8List plaintext,
      {required Algorithm algorithm, required Uint8List? aad}) async {
    // create envelope
    final localKeyPair =
        await _diffieHellmanRatchet.generateAndAddLocalDiffieHellmanKeyPair();
    final localPk = await localKeyPair.extractPublicKey();
    final remotePk = _diffieHellmanRatchet.remoteDiffieHellmanKey;
    final envelope = Envelope();
    envelope.recipientDiffieHellmanPublicKey = remotePk.bytes;
    envelope.senderNewDiffieHellmanPublicKey = localPk.bytes;
    envelope.payload = plaintext;
    final envelopeBytes = envelope.writeToBuffer();

    // encrypt
    final keyMaterial = await _gatherEncryptionKeyMaterial();
    final e = await MessageEncryption.encrypt(envelopeBytes, keyMaterial,
        algorithm: algorithm, aad: aad);

    // advance ratchets
    await _diffieHellmanRatchet.advanceOutgoingDiffieHellmanRatchet();
    await _sha256Ratchet.advanceOutgoingRatchet(envelopeBytes);

    final bytes = e.writeToBuffer();

    return bytes;
  }
}
