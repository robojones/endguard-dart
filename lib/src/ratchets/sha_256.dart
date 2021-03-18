import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/state/state_accessor.dart';

// Byte length of the hash ratchet.
// 32 bytes equals the length of a 256 bit hash.
const hashRatchetSize = 32;

final sha = Sha256();

class SHA256Ratchet {
  final StateAccessor _stateAccessor;

  SHA256Ratchet(this._stateAccessor);

  SecretKeyData initializeIncomingSHA256Ratchet() {
    final v = SecretKeyData.random(length: hashRatchetSize);
    _stateAccessor.setIncomingSHA256Ratchet(v);
    return v;
  }

  SecretKeyData initializeOutgoingSHA256Ratchet() {
    final v = SecretKeyData.random(length: hashRatchetSize);
    _stateAccessor.setOutgoingSHA256Ratchet(v);
    return v;
  }

  Future<void> advanceIncomingRatchet(Uint8List plaintext) async {
    final previousValue = getIncomingRatchetValue();
    final data = plaintext + previousValue.bytes;
    final hash = await sha.hash(data);

    final newValue = SecretKeyData(hash.bytes);
    setIncomingRatchetValue(newValue);
  }

  Future<void> advanceOutgoingRatchet(Uint8List plaintext) async {
    final previousValue = getOutgoingRatchetValue();
    final data = plaintext + previousValue.bytes;
    final hash = await sha.hash(data);

    final newValue = SecretKeyData(hash.bytes);
    setOutgoingRatchetValue(newValue);
  }

  void setIncomingRatchetValue(SecretKeyData s) {
    _stateAccessor.setIncomingSHA256Ratchet(s);
  }

  void setOutgoingRatchetValue(SecretKeyData s) {
    _stateAccessor.setOutgoingSHA256Ratchet(s);
  }

  SecretKeyData getIncomingRatchetValue() {
    return _stateAccessor.getIncomingSHA256Ratchet();
  }

  SecretKeyData getOutgoingRatchetValue() {
    return _stateAccessor.getOutgoingSHA256Ratchet();
  }
}
