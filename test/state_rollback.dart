import 'package:endguard/endguard.dart';
import 'package:protobuf/protobuf.dart';
import 'package:test/test.dart';

import 'util.dart';

void main() {
  group('connection state rollback on error', () {
    void testExpectInvalidOperationException(
        String description, Function(TestContext) t) {
      test('should throw an InvalidOperationException when ${description}',
          () async {
        final context = TestContext();
        try {
          await t(context);
          throw TestFailure(
              'Operation successful but expected an InvalidOperationException');
        } on InvalidOperationException {
          // This is the expected behavior.
          // Make sure that the state is not changed.
          await context.assertStateIsRolledBack();
        }
      });
    }

    void testExpectInvalidProtocolBufferException(
        String description, Function(TestContext) t) {
      test('should throw an InvalidProtocolBufferException when ${description}',
          () async {
        final context = TestContext();
        try {
          await t(context);
          throw TestFailure(
              'Operation successful but expected an InvalidProtocolBufferException');
        } on InvalidProtocolBufferException {
          // This is the expected behavior.
          // Make sure that the state is not changed.
          await context.assertStateIsRolledBack();
        }
      });
    }

    group('with uninitialized connection', () {
      testExpectInvalidOperationException('applying a ConnectionConfirmation',
          (TestContext context) async {
        final confirmation = await context.connectionConfirmation;
        await context.uninitializedConnection.applyConnectionConfirmation(
            confirmation.exportPackage(),
            remoteKey: confirmation.exportKey());
      });

      testExpectInvalidOperationException('encrypting a message',
          (TestContext context) async {
        await context.uninitializedConnection.encrypt(context.testPlaintext);
      });

      testExpectInvalidOperationException('decrypting a message',
          (TestContext context) async {
        await context.uninitializedConnection.decrypt(context.testPlaintext);
      });
    });

    group('with handshake in progress', () {
      testExpectInvalidOperationException('creating a ConnectionRequest',
          (TestContext context) async {
        final connection = await context.handshakeStateConnection;
        await connection.createConnectionRequest();
      });

      testExpectInvalidOperationException('applying a ConnectionRequest',
          (TestContext context) async {
        final request = await context.connectionRequest;
        final connection = await context.handshakeStateConnection;
        await connection.applyConnectionRequest(request.exportPackage(),
            remoteKey: request.exportKey());
      });

      testExpectInvalidOperationException('encrypting a message',
          (TestContext context) async {
        final connection = await context.handshakeStateConnection;
        await connection.encrypt(context.testPlaintext);
      });

      testExpectInvalidOperationException('decrypting a message',
          (TestContext context) async {
        final connection = await context.handshakeStateConnection;
        final message = await context.testMessage;
        await connection.decrypt(message);
      });
    });

    group('with established connection', () {
      testExpectInvalidOperationException('creating a ConnectionRequest',
          (TestContext context) async {
        final connection = await context.establishedConnection;
        await connection.createConnectionRequest();
      });

      testExpectInvalidOperationException('applying a ConnectionRequest',
          (TestContext context) async {
        final request = await context.connectionRequest;
        final connection = await context.establishedConnection;
        await connection.applyConnectionRequest(request.exportPackage(),
            remoteKey: request.exportKey());
      });

      testExpectInvalidOperationException('applying a ConnectionConfirmation',
          (TestContext context) async {
        final request = await context.connectionConfirmation;
        final connection = await context.establishedConnection;
        await connection.applyConnectionConfirmation(request.exportPackage(),
            remoteKey: request.exportKey());
      });

      testExpectInvalidProtocolBufferException(
          'decrypting a message with wrong format',
          (TestContext context) async {
        final connection = await context.establishedConnection;
        await connection.decrypt(context.invalidFormatCiphertext);
      });
    });
  });
}
