import 'dart:convert';
import 'dart:typed_data';

import 'package:endguard/endguard.dart';
import 'package:test/test.dart';

/// The TestContext provides connections in all possible states and all types of messages.
class TestContext {
  late final Connection _uninitializedConnection;
  late final Future<Connection> _handshakeStateConnection;
  late final Future<Connection> _establishedConnection;

  late final Uint8List _uninitializedState;
  late final Uint8List _handshakeState;
  late final Uint8List _establishedState;

  late final Future<HandshakeMessage> _connectionRequest;
  late final Future<HandshakeMessage> _connectionConfirmation;

  TestContext() {
    _uninitializedConnection = Connection();
    _uninitializedState = _uninitializedConnection.getState();

    final b = Connection.fromState(_uninitializedState);
    _connectionRequest = b.createConnectionRequest();

    _handshakeStateConnection = () async {
      final b = Connection.fromState(_uninitializedState);
      await b.createConnectionRequest();
      _handshakeState = b.getState();
      return b;
    }();

    _connectionConfirmation = () async {
      final a = Connection.fromState(_uninitializedState);
      final cr = await connectionRequest;
      return a.applyConnectionRequest(cr.exportPackage(),
          remoteKey: cr.exportKey());
    }();

    _establishedConnection = () async {
      final a = Connection.fromState(_uninitializedState);
      final cr = await connectionRequest;
      await a.applyConnectionRequest(cr.exportPackage(),
          remoteKey: cr.exportKey());
      _establishedState = a.getState();
      return a;
    }();
  }

  Connection get uninitializedConnection {
    return _uninitializedConnection;
  }

  Future<HandshakeMessage> get connectionRequest {
    return _connectionRequest;
  }

  Future<Connection> get handshakeStateConnection {
    return _handshakeStateConnection;
  }

  Future<HandshakeMessage> get connectionConfirmation {
    return _connectionConfirmation;
  }

  Future<Connection> get establishedConnection async {
    return _establishedConnection;
  }

  String get testPlaintextString {
    return 'this is a test message';
  }

  Uint8List get testPlaintext {
    return Uint8List.fromList(utf8.encode(testPlaintextString));
  }

  Uint8List get testMessage {
    // does not need to be in the correct format
    // the operation should fail before attempting to parse this
    return Uint8List.fromList(utf8.encode('test message'));
  }

  Uint8List get invalidFormatCiphertext {
    // Does not need to be a valid ciphertext as the test should fail
    // before trying to decrypt the ciphertext.
    return Uint8List.fromList(utf8.encode('test ciphertext'));
  }

  Future<void> assertStateIsRolledBack() async {
    final uninitialized = uninitializedConnection;
    expect(uninitialized.getState(), equals(_uninitializedState),
        reason:
            'state of uninitialized connection was modified and not rolled back');
    final handshake = await handshakeStateConnection;
    expect(handshake.getState(), equals(_handshakeState),
        reason:
            'state of connection with active handshake was modified and not rolled back');
    final established = await establishedConnection;
    expect(established.getState(), equals(_establishedState),
        reason:
            'state of established connection was modified and not rolled back');
  }
}
