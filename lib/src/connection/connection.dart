import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/connection/encryption.dart';
import 'package:endguard/src/connection/handshake.dart';
import 'package:endguard/src/crypto/handshake.dart';
import 'package:endguard/src/state/initialization_state.dart';
import 'package:endguard/src/exception/operation_exception.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/ratchets/diffie_hellman.dart';
import 'package:endguard/src/ratchets/sha_256.dart';
import 'package:endguard/src/state/state_accessor.dart';

/// A secure connection, encrypted with the Endguard encryption scheme.
class Connection {
  StateAccessor _stateAccessor;
  Handshake _handshake;
  Encryption _encryption;
  InitialisationStateManager _connectionState;

  /// Creates a new connection.
  /// The handshake needs to be complete before using [encrypt] or [decrypt]
  Connection() {
    final s = StateAccessor();
    _init(s);
  }

  /// Creates a connection from an existing connection state.
  /// To persist the connection state, use the [getState] and save the result.
  Connection.fromState(Uint8List state) {
    final s = StateAccessor.withState(state);
    _init(s);
  }

  void _init(StateAccessor s) {
    _stateAccessor = s;
    final diffieHellmanRatchet = DiffieHellmanRatchet(s);
    final sha256Ratchet = SHA256Ratchet(s);

    _connectionState = InitialisationStateManager(s);
    _handshake = Handshake(diffieHellmanRatchet, sha256Ratchet);
    _encryption = Encryption(diffieHellmanRatchet, sha256Ratchet);
  }

  /// Returns the current state of the connection.
  /// The state should be persisted after every method call as all of them
  /// modify the state.
  Uint8List getState() {
    _connectionState.beginOperation(Operation.ExportState);
    // Operation can be completed directly, as is it does not modify the state.
    // Therefore, no rollback is needed, even if there is an error.
    _connectionState.completeOperation();
    return _stateAccessor.exportState();
  }

  void setOutgoingEncryptionAlgorithm(Algorithm algorithm) {
    _connectionState.beginOperation(Operation.UpdateConnectionSettings);
    try {
      _stateAccessor.outgoingEncryptionAlgorithm = algorithm;
      _connectionState.completeOperation();
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  /// Creates a new connection request.
  /// This is the first step of the handshake.
  Future<HandshakeMessage> createConnectionRequest() async {
    _connectionState.beginOperation(Operation.CreateConnectionOffer);
    try {
      final p = await _handshake.createConnectionRequest(
          algorithm: _stateAccessor.outgoingEncryptionAlgorithm);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  /// Applies a connection request from another device.
  /// Returns the connection confirmation for the other device.
  /// This completes the handshake on this device.
  /// The device is then ready to encrypt and decrypt messages.
  Future<HandshakeMessage> applyConnectionRequest(Uint8List welcomeMessage,
      {SecretKey remoteKey}) async {
    _connectionState.beginOperation(Operation.ApplyConnectionOffer);
    try {
      final p = await _handshake.applyConnectionRequest(welcomeMessage,
          remoteKey: remoteKey,
          algorithm: _stateAccessor.outgoingEncryptionAlgorithm);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  /// Applies the connection confirmation from the other device.
  /// This completes the handshake for this device.
  /// The device is then ready to encrypt and decrypt messages.
  Future<void> applyConnectionConfirmation(Uint8List connectionConfirmation,
      {SecretKey remoteKey}) async {
    _connectionState.beginOperation(Operation.ApplyConnectionConfirmation);
    try {
      final p = await _handshake.applyConnectionConfirmation(
          connectionConfirmation,
          remoteKey: remoteKey);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  /// Decrypts an incoming message.
  Future<Uint8List> decrypt(Uint8List message) async {
    _connectionState.beginOperation(Operation.DecryptMessage);
    try {
      final p = await _encryption.decrypt(message);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  /// Encrypts an outgoing message.
  Future<Uint8List> encrypt(Uint8List plaintext) async {
    _connectionState.beginOperation(Operation.EncryptMessage);
    try {
      final p = await _encryption.encrypt(plaintext,
          algorithm: _stateAccessor.outgoingEncryptionAlgorithm);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }
}
