import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/protos/protocol.pb.dart';

class StateAccessor {
  ConnectionState _state;

  StateAccessor() : _state = ConnectionState();

  StateAccessor.withState(ConnectionState s) : _state = s;

  Uint8List exportState() {
    return _state.writeToBuffer();
  }

  void importState(Uint8List state) {
    _state = ConnectionState.fromBuffer(state);
  }

  SimpleKeyPairData _convertToSimpleKeyPair(
      DiffieHellmanKeyPair p, KeyPairType t) {
    final pk = SimplePublicKey(p.diffieHellmanPublicKey, type: t);
    final d =
        SimpleKeyPairData(p.diffieHellmanPrivateKey, publicKey: pk, type: t);
    return d;
  }

  Future<DiffieHellmanKeyPair> _convertToDiffieHellmanKeyPair(
      SimpleKeyPairData d) async {
    final p = DiffieHellmanKeyPair();
    final pk = await d.extractPublicKey();
    p.diffieHellmanPublicKey = pk.bytes;
    p.diffieHellmanPrivateKey = await d.extractPrivateKeyBytes();
    return p;
  }

  set initializationState(State s) {
    _state.initializationState = s;
  }

  State get initializationState {
    return _state.initializationState;
  }

  set remoteDiffieHellmanKey(SimplePublicKey key) {
    _state.remoteDiffieHellmanKey = key.bytes;
  }

  SimplePublicKey get remoteDiffieHellmanKey {
    return SimplePublicKey(_state.remoteDiffieHellmanKey,
        type: KeyPairType.x25519);
  }

  set incomingDiffieHellmanRatchet(SecretKeyData d) {
    _state.incomingDiffieHellmanRatchet = d.bytes;
  }

  SecretKeyData get incomingDiffieHellmanRatchet {
    return SecretKeyData(_state.incomingDiffieHellmanRatchet);
  }

  set outgoingDiffieHellmanRatchet(SecretKeyData d) {
    _state.outgoingDiffieHellmanRatchet = d.bytes;
  }

  SecretKeyData get outgoingDiffieHellmanRatchet {
    return SecretKeyData(_state.outgoingDiffieHellmanRatchet);
  }

  Future<void> addLocalDiffieHellmanKeyPair(SimpleKeyPair pair) async {
    final p = await _convertToDiffieHellmanKeyPair(pair);
    _state.localDiffieHellmanKeyPairs.add(p);
  }

  SimpleKeyPairData get latestLocalDiffieHellmanKeyPair {
    if (_state.localDiffieHellmanKeyPairs.isNotEmpty) {
      return _convertToSimpleKeyPair(
          _state.localDiffieHellmanKeyPairs.last, KeyPairType.x25519);
    }
    return null;
  }

  Future<SimpleKeyPairData> findLocalDiffieHellmanKeyPairByPublicKey(
      SimplePublicKey localPublicKey) async {
    for (final pair in _state.localDiffieHellmanKeyPairs) {
      if (SimplePublicKey(pair.diffieHellmanPublicKey,
              type: KeyPairType.x25519) ==
          localPublicKey) {
        return _convertToSimpleKeyPair(pair, KeyPairType.x25519);
      }
    }
    return null;
  }

  Future<void> removePreviousLocalDiffieHellmanKeyPairs(
      SimpleKeyPairData pair) async {
    final search = await _convertToDiffieHellmanKeyPair(pair);

    // find index of key pair
    var i = 0;
    while (i < _state.localDiffieHellmanKeyPairs.length) {
      if (_state.localDiffieHellmanKeyPairs[i] == search) {
        break;
      }
      i += 1;
    }
    if (i == _state.localDiffieHellmanKeyPairs.length) {
      // key not found, do not delete keys
      return;
    }
    // remove all previous key pairs
    _state.localDiffieHellmanKeyPairs.removeRange(0, i);
  }

  set incomingSHA256Ratchet(SecretKeyData keyData) {
    _state.incomingSHA256Ratchet = keyData.bytes;
  }

  SecretKeyData get incomingSHA256Ratchet {
    return SecretKeyData(_state.incomingSHA256Ratchet);
  }

  set outgoingSHA256Ratchet(SecretKeyData keyData) {
    _state.outgoingSHA256Ratchet = keyData.bytes;
  }

  SecretKeyData get outgoingSHA256Ratchet {
    return SecretKeyData(_state.outgoingSHA256Ratchet);
  }
}
