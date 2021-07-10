import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/crypto/handshake.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/ratchets/diffie_hellman.dart';
import 'package:endguard/src/ratchets/sha_256.dart';

class Handshake {
  final DiffieHellmanRatchet _diffieHellmanRatchet;
  final SHA256Ratchet _sha256Ratchet;

  Handshake(
      this._diffieHellmanRatchet, this._sha256Ratchet);

  Future<HandshakeMessage> createConnectionRequest({ Algorithm algorithm }) async {
    final k =
        await _diffieHellmanRatchet.generateAndAddLocalDiffieHellmanKeyPair();

    final w = ConnectionOffer();
    final pk = await k.extractPublicKey();
    w.newDiffieHellmanPublicKey = pk.bytes;
    final plaintext = w.writeToBuffer();

    return await HandshakeEncryption.encryptMessage(plaintext, algorithm: algorithm);
  }

  Future<HandshakeMessage> applyConnectionRequest(Uint8List connectionRequest,
      {SecretKey remoteKey, Algorithm algorithm}) async {
    final bytes =
        await HandshakeEncryption.decryptMessage(connectionRequest, key: remoteKey);
    final p = ConnectionOffer.fromBuffer(bytes);

    // set remote public key in Diffie-Hellman ratchet
    final remotePk =
        SimplePublicKey(p.newDiffieHellmanPublicKey, type: KeyPairType.x25519);
    _diffieHellmanRatchet.remoteDiffieHellmanKey = remotePk;

    // initialize incoming Diffie-Hellman ratchet
    final incoming =
        await _diffieHellmanRatchet.generateAndAddLocalDiffieHellmanKeyPair();
    final incomingPk = await incoming.extractPublicKey();
    await _diffieHellmanRatchet.advanceIncomingDiffieHellmanRatchet(incomingPk);

    // initialize outgoing Diffie-Hellman ratchet
    final outgoing =
        await _diffieHellmanRatchet.generateAndAddLocalDiffieHellmanKeyPair();
    final outgoingPk = await outgoing.extractPublicKey();
    await _diffieHellmanRatchet.advanceOutgoingDiffieHellmanRatchet();

    // initialize hash ratchets
    final incomingSHA256RatchetInitValue =
        _sha256Ratchet.initializeIncomingSHA256Ratchet();
    final outgoingSHA256RatchetInitValue =
        _sha256Ratchet.initializeOutgoingSHA256Ratchet();

    // create ConnectionConfirmation message
    final oc = ConnectionConfirmation();
    oc.incomingNewDiffieHellmanPublicKey = incomingPk.bytes;
    oc.outgoingNewDiffieHellmanPublicKey = outgoingPk.bytes;
    oc.connectionOfferDiffieHellmanPublicKey = remotePk.bytes;
    oc.incomingSHA256RatchetInitValue = incomingSHA256RatchetInitValue.bytes;
    oc.outgoingSHA256RatchetInitValue = outgoingSHA256RatchetInitValue.bytes;

    return await HandshakeEncryption.encryptMessage(oc.writeToBuffer(), algorithm: algorithm);
  }

  Future<void> applyConnectionConfirmation(Uint8List connectionConfirmation,
      {SecretKey remoteKey}) async {
    final bytes =
        await HandshakeEncryption.decryptMessage(connectionConfirmation, key: remoteKey);
    final oc = ConnectionConfirmation.fromBuffer(bytes);

    final localPk = SimplePublicKey(oc.connectionOfferDiffieHellmanPublicKey,
        type: KeyPairType.x25519);
    final remoteIncoming = SimplePublicKey(oc.incomingNewDiffieHellmanPublicKey,
        type: KeyPairType.x25519);
    final remoteOutgoing = SimplePublicKey(oc.outgoingNewDiffieHellmanPublicKey,
        type: KeyPairType.x25519);

    _diffieHellmanRatchet.remoteDiffieHellmanKey = remoteIncoming;
    await _diffieHellmanRatchet.advanceOutgoingDiffieHellmanRatchet();

    _diffieHellmanRatchet.remoteDiffieHellmanKey = remoteOutgoing;
    await _diffieHellmanRatchet.advanceIncomingDiffieHellmanRatchet(localPk);

    final incomingSHA256RatchetInitValue =
        SecretKeyData(oc.incomingSHA256RatchetInitValue);
    _sha256Ratchet.outgoingRatchetValue = incomingSHA256RatchetInitValue;

    final outgoingSHA256RatchetInitValue =
        SecretKeyData(oc.outgoingSHA256RatchetInitValue);
    _sha256Ratchet.incomingRatchetValue = outgoingSHA256RatchetInitValue;
  }
}
