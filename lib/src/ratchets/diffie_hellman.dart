import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/state/state_accessor.dart';

final dh = Cryptography.instance.x25519();

class DiffieHellmanRatchet {
  final StateAccessor _stateAccessor;

  DiffieHellmanRatchet(this._stateAccessor);

  set remoteDiffieHellmanKey(SimplePublicKey key) {
    _stateAccessor.remoteDiffieHellmanKey = key;
  }

  SimplePublicKey get remoteDiffieHellmanKey {
    return _stateAccessor.remoteDiffieHellmanKey;
  }

  Future<void> addLocalDiffieHellmanKeyPair(SimpleKeyPair pair) async {
    return _stateAccessor.addLocalDiffieHellmanKeyPair(pair);
  }

  Future<SimpleKeyPairData> generateAndAddLocalDiffieHellmanKeyPair() async {
    final p = await dh.newKeyPair();
    await _stateAccessor.addLocalDiffieHellmanKeyPair(p);
    return p;
  }

  /// Advance the incoming ratchet with the provided remotePublicKey and localPublicKey.
  /// Expects remotePublicKey to be the latest remote public key
  /// Expects a matching key pair for localPublicKey in localDiffieHellmanKeys.
  /// Removes all key pairs which are older than the one with the localPublicKey
  Future<void> advanceIncomingDiffieHellmanRatchet(
      PublicKey localPublicKey) async {
    // Find matching private key for localPublicKey.
    final localPair = await _stateAccessor
        .findLocalDiffieHellmanKeyPairByPublicKey(localPublicKey);
    if (localPair == null) {
      throw Exception('public key not found'); // TODO
    }

    // The other party knows the localPublicKey and will use it for all future messages.
    // Older keys will no longer be used and can be removed.
    await _stateAccessor.removePreviousLocalDiffieHellmanKeyPairs(localPair);

    // compute shared secret
    final remotePk = _stateAccessor.remoteDiffieHellmanKey;
    final secret =
        await dh.sharedSecretKey(keyPair: localPair, remotePublicKey: remotePk);

    // update ratchet value
    _stateAccessor.incomingDiffieHellmanRatchet = secret;
  }

  /// Advance the outgoing ratchet with the newly generated newKeyPair.
  /// Expects remoteDiffieHellmanKey to be set.
  /// Expects localDiffieHellmanKeyPairs to contain a newly generated public key.
  Future<void> advanceOutgoingDiffieHellmanRatchet() async {
    // compute shared secret
    final localPair = _stateAccessor.latestLocalDiffieHellmanKeyPair;
    final remotePk = _stateAccessor.remoteDiffieHellmanKey;
    final secret =
        await dh.sharedSecretKey(keyPair: localPair, remotePublicKey: remotePk);

    // update ratchet value
    _stateAccessor.outgoingDiffieHellmanRatchet = secret;
  }

  SecretKeyData get incomingRatchetValue {
    return _stateAccessor.incomingDiffieHellmanRatchet;
  }

  SecretKeyData get outgoingRatchetValue {
    return _stateAccessor.outgoingDiffieHellmanRatchet;
  }
}
