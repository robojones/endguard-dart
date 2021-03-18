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
    incomingRatchetValue = v;
    return v;
  }

  SecretKeyData initializeOutgoingSHA256Ratchet() {
    final v = SecretKeyData.random(length: hashRatchetSize);
    outgoingRatchetValue = v;
    return v;
  }

  Future<void> advanceIncomingRatchet(Uint8List plaintext) async {
    final data = plaintext + incomingRatchetValue.bytes;
    final hash = await sha.hash(data);

    incomingRatchetValue = SecretKeyData(hash.bytes);
  }

  Future<void> advanceOutgoingRatchet(Uint8List plaintext) async {
    final data = plaintext + outgoingRatchetValue.bytes;
    final hash = await sha.hash(data);

    outgoingRatchetValue = SecretKeyData(hash.bytes);
  }

  set incomingRatchetValue(SecretKeyData s) {
    _stateAccessor.incomingSHA256Ratchet = s;
  }

  set outgoingRatchetValue(SecretKeyData s) {
    _stateAccessor.outgoingSHA256Ratchet = s;
  }

  SecretKeyData get incomingRatchetValue {
    return _stateAccessor.incomingSHA256Ratchet;
  }

  SecretKeyData get outgoingRatchetValue {
    return _stateAccessor.outgoingSHA256Ratchet;
  }
}
