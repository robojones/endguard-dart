import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/connection/encryption.dart';
import 'package:endguard/src/connection/handshake.dart';
import 'package:endguard/src/encryption/handshake.dart';
import 'package:endguard/src/state/initialization_state.dart';
import 'package:endguard/src/exception/operation_exception.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/ratchets/diffie_hellman.dart';
import 'package:endguard/src/ratchets/sha_256.dart';
import 'package:endguard/src/state/state_accessor.dart';

class Connection {
  StateAccessor _stateAccessor;
  Handshake _initialization;
  Encryption _encryption;
  InitialisationStateManager _connectionState;

  Connection() {
    final s = StateAccessor();
    _init(s);
  }

  Connection.fromState(ConnectionState state) {
    final s = StateAccessor.withState(state);
    _init(s);
  }

  void _init(StateAccessor s) {
    _stateAccessor = s;
    final diffieHellmanRatchet = DiffieHellmanRatchet(s);
    final sha256Ratchet = SHA256Ratchet(s);

    _connectionState = InitialisationStateManager(s);
    _initialization = Handshake(
        diffieHellmanRatchet, sha256Ratchet);
    _encryption = Encryption(diffieHellmanRatchet, sha256Ratchet);
  }

  Uint8List getState() {
    return _stateAccessor.exportState();
  }

  Future<HandshakePackage> createConnectionOffer() async {
    _connectionState.beginOperation(Operation.CreateConnectionOffer);
    try {
      final p = await _initialization.createConnectionOffer();
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  Future<HandshakePackage> applyConnectionOffer(Uint8List welcomePackage,
      {SecretKey remoteKey}) async {
    _connectionState.beginOperation(Operation.ApplyConnectionOffer);
    try {
      final p = await _initialization.applyConnectionOffer(welcomePackage,
          remoteKey: remoteKey);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  Future<void> applyConnectionConfirmation(Uint8List connectionConfirmation,
      {SecretKey remoteKey}) async {
    _connectionState.beginOperation(Operation.ApplyConnectionConfirmation);
    try {
      final p = await _initialization.applyConnectionConfirmation(connectionConfirmation,
          remoteKey: remoteKey);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  Future<Uint8List> decrypt(Uint8List package) async {
    _connectionState.beginOperation(Operation.DecryptMessage);
    try {
      final p = await _encryption.decrypt(package);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  Future<Uint8List> encrypt(Uint8List plaintext) async {
    _connectionState.beginOperation(Operation.EncryptMessage);
    try {
      final p = await _encryption.encrypt(plaintext);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }
}
