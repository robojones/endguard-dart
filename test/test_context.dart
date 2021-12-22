import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:endguard/endguard.dart';
import 'package:test/test.dart';

/// The TestContext provides connections in all possible states and all types of messages.
class TestContext {
  late final Connection _uninitializedConnection;
  late final Future<Connection> _handshakeConnection;
  late final Future<Connection> _establishedConnection;

  late final Uint8List _uninitializedState;
  late final Future<Uint8List> _handshakeState;
  late final Future<Uint8List> _establishedState;

  late final Future<HandshakeMessage> _connectionRequest;
  late final Future<HandshakeMessage> _connectionConfirmation;
  late final Future<Uint8List> _message;

  TestContext() {
    _createConnectionRequest();
    _applyConnectionRequest();
    _encryptMessage();
    _initializeConnectionsForAssertion();
  }

  _createConnectionRequest() {
    final connectionA = Connection();
    _uninitializedState = connectionA.getState();
    _connectionRequest = connectionA.createConnectionRequest();
    _handshakeState = () async {
      await _connectionRequest;
      return connectionA.getState();
    }();
  }

  _applyConnectionRequest() {
    final connectionB = Connection.fromState(_uninitializedState);
    _connectionConfirmation = () async {
      final cr = await connectionRequest;
      return connectionB.applyConnectionRequest(cr.exportPackage(),
          remoteKey: cr.exportKey());
    }();
    _establishedState = () async {
      await _connectionConfirmation;
      return connectionB.getState();
    }();
  }

  _encryptMessage() {
    _message = () async {
      final connectionA = Connection.fromState(await _handshakeState);
      final cc = await _connectionConfirmation;
      await connectionA.applyConnectionConfirmation(cc.exportPackage(),
          remoteKey: cc.exportKey());
      return connectionA.encrypt(testPlaintext, aad: testAad);
    }();
  }

  _initializeConnectionsForAssertion() {
    _uninitializedConnection = Connection.fromState(_uninitializedState);
    _handshakeConnection = () async {
      return Connection.fromState(await _handshakeState);
    }();
    _establishedConnection = () async {
      return Connection.fromState(await _establishedState);
    }();
  }

  Connection get uninitializedConnection {
    return _uninitializedConnection;
  }

  Future<Connection> get handshakeStateConnection async {
    return _handshakeConnection;
  }

  Future<Connection> get establishedConnection async {
    return _establishedConnection;
  }

  Future<HandshakeMessage> get connectionRequest {
    return _connectionRequest;
  }

  Future<HandshakeMessage> get connectionConfirmation {
    return _connectionConfirmation;
  }

  String get testPlaintextString {
    return 'this is a test message';
  }

  Uint8List get testPlaintext {
    return Uint8List.fromList(utf8.encode(testPlaintextString));
  }

  Future<Uint8List> get testMessage async {
    return _message;
  }

  Uint8List get testAad {
    return Uint8List.fromList(
        utf8.encode('some additionally authenticated data'));
  }

  Uint8List get invalidFormatCiphertext {
    // Does not need to be a valid ciphertext as the test should fail
    // before trying to decrypt the ciphertext.
    return Uint8List.fromList(utf8.encode('test ciphertext'));
  }

  SecretKey get invalidKey {
    // Does not need to be a valid ciphertext as the test should fail
    // before trying to decrypt the ciphertext.
    return SecretKey(utf8.encode('test key'));
  }

  Uint8List get invalidAad {
    // Does not need to be a valid ciphertext as the test should fail
    // before trying to decrypt the ciphertext.
    return Uint8List.fromList(utf8.encode('this is a wrong aad'));
  }

  Future<void> assertStateIsRolledBack() async {
    final uninitialized = uninitializedConnection;
    expect(uninitialized.getState(), equals(_uninitializedState),
        reason:
            'state of uninitialized connection was modified and not rolled back');
    final handshake = await handshakeStateConnection;
    expect(handshake.getState(), equals(await _handshakeState),
        reason:
            'state of connection with active handshake was modified and not rolled back');
    final established = await establishedConnection;
    expect(established.getState(), equals(await _establishedState),
        reason:
            'state of established connection was modified and not rolled back');
  }
}
