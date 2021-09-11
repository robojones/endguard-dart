import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/src/crypto/exception.dart';
import 'package:endguard/src/parallelism/operations.dart';
import 'package:endguard/src/transmission/transmission.dart';
import 'package:endguard/src/handshake/handshake.dart';
import 'package:endguard/src/handshake/message.dart';
import 'package:endguard/src/parallelism/manager.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/crypto/diffie_hellman_ratchet.dart';
import 'package:endguard/src/crypto/sha256_ratchet.dart';
import 'package:endguard/src/state/state_accessor.dart';

export 'package:endguard/src/protos/protocol.pb.dart' show Algorithm;

/// A secure connection, encrypted with the Endguard encryption scheme.
class Connection {
  late final StateAccessor _stateAccessor;
  late final Handshake _handshake;
  late final Transmission _encryption;
  late final ParallelismManager _connectionState;

  /// Creates a new connection.
  Connection() {
    final s = StateAccessor();
    _init(s);
  }

  /// Creates a connection from an existing connection [state].
  /// To persist the connection state, use the [getState] and save the result.
  Connection.fromState(Uint8List state) {
    final s = StateAccessor.withState(state);
    _init(s);
  }

  void _init(StateAccessor s) {
    _stateAccessor = s;
    final diffieHellmanRatchet = DiffieHellmanRatchet(s);
    final sha256Ratchet = SHA256Ratchet(s);

    _connectionState = ParallelismManager(s);
    _handshake = Handshake(diffieHellmanRatchet, sha256Ratchet);
    _encryption = Transmission(diffieHellmanRatchet, sha256Ratchet);
  }

  /// Returns the current state of the connection.
  /// The state should be persisted after every method call as all of them
  /// modify the state.
  Uint8List getState() {
    _connectionState.beginOperation(Operation.exportState);
    // Operation can be completed directly, as is it does not modify the state.
    // Therefore, no rollback is needed, even if there is an error.
    _connectionState.completeOperation();
    return _stateAccessor.exportState();
  }

  /// Set the encryption [algorithm] for outgoing messages.
  /// If you do not set the algorithm explicitly, then the default encryption
  /// algorithm is used.
  void setOutgoingEncryptionAlgorithm(Algorithm algorithm) {
    _connectionState.beginOperation(Operation.updateConnectionSettings);
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
  /// Optionally, some additional authenticated content [aad] can be passed,
  /// which will be authenticated alongside the connection request.
  Future<HandshakeMessage> createConnectionRequest({Uint8List? aad}) async {
    _connectionState.beginOperation(Operation.createConnectionOffer);
    try {
      final p = await _handshake.createConnectionRequest(
          algorithm: _stateAccessor.outgoingEncryptionAlgorithm, aad: aad);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  /// Applies a [connectionRequest] from another device.
  /// Authenticates the [connectionRequest] and [requestAad] (additional
  /// authenticated content) using the [remoteKey].
  /// Returns a connection confirmation for the other device.
  /// Optionally, you can pass some additional authenticated content [aad] which
  /// will be authenticated alongside the connection confirmation.
  /// This completes the handshake on this device.
  /// The device is then ready to encrypt and decrypt messages.
  /// Throws a [MessageAuthenticationException] if the message can not be
  /// authenticated.
  Future<HandshakeMessage> applyConnectionRequest(Uint8List connectionRequest,
      {required SecretKey remoteKey,
      Uint8List? requestAad,
      Uint8List? aad}) async {
    _connectionState.beginOperation(Operation.applyConnectionOffer);
    try {
      final p = await _handshake.applyConnectionRequest(connectionRequest,
          remoteKey: remoteKey,
          algorithm: _stateAccessor.outgoingEncryptionAlgorithm,
          requestAad: requestAad,
          aad: aad);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  /// Applies the [connectionConfirmation] from the other device.
  /// Authenticates the [connectionConfirmation] and the [aad] from the other
  /// device using the [key].
  /// This completes the handshake for this device.
  /// The device is then ready to encrypt and decrypt messages.
  /// Throws a [MessageAuthenticationException] if the message can not be
  /// authenticated.
  Future<void> applyConnectionConfirmation(Uint8List connectionConfirmation,
      {required SecretKey remoteKey, Uint8List? aad}) async {
    _connectionState.beginOperation(Operation.applyConnectionConfirmation);
    try {
      final p = await _handshake.applyConnectionConfirmation(
          connectionConfirmation,
          remoteKey: remoteKey,
          aad: aad);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  /// Decrypts an incoming [message].
  /// Throws a [MessageAuthenticationException] if the [message] or [aad] can
  /// not be authenticated.
  Future<Uint8List> decrypt(Uint8List message, {Uint8List? aad}) async {
    _connectionState.beginOperation(Operation.decryptMessage);
    try {
      final p = await _encryption.decrypt(message, aad: aad);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }

  /// Encrypts the [plaintext] of a message.
  /// Optionally, some additional authenticated content [aad] can be passed,
  /// which will be authenticated alongside the message.
  Future<Uint8List> encrypt(Uint8List plaintext, {Uint8List? aad}) async {
    _connectionState.beginOperation(Operation.encryptMessage);
    try {
      final p = await _encryption.encrypt(plaintext,
          algorithm: _stateAccessor.outgoingEncryptionAlgorithm, aad: aad);
      _connectionState.completeOperation();
      return p;
    } catch (e) {
      _connectionState.abortOperation();
      rethrow;
    }
  }
}
