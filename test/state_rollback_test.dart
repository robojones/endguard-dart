import 'package:endguard/endguard.dart';
import 'package:test/test.dart';

import 'test_context.dart';

void main() {
  group('connection state:', () {
    void testExpectInvalidOperationError(
        String description, Function(TestContext) t) {
      test('should throw an InvalidOperationException when $description',
          () async {
        final context = TestContext();
        try {
          await t(context);
          throw TestFailure(
              'Operation successful but expected an InvalidOperationException');
        } on InvalidOperationError {
          // This is the expected behavior.
          // Make sure that the state is not changed.
          await context.assertStateIsRolledBack();
        }
      });
    }

    void testExpectMessageAuthenticationException(
        String description, Function(TestContext) t) {
      test('should throw an InvalidProtocolBufferException when $description',
          () async {
        final context = TestContext();
        try {
          await t(context);
          throw TestFailure(
              'Operation successful but expected an InvalidProtocolBufferException');
        } on MessageAuthenticationException {
          // This is the expected behavior.
          // Make sure that the state is not changed.
          await context.assertStateIsRolledBack();
        }
      });
    }

    group('with uninitialized connection', () {
      testExpectInvalidOperationError('applying a ConnectionConfirmation',
          (TestContext context) async {
        final confirmation = await context.connectionConfirmation;
        await context.uninitializedConnection.applyConnectionConfirmation(
          confirmation.exportPackage(),
          remoteKey: confirmation.exportKey());
      });

      testExpectInvalidOperationError('encrypting a message',
          (TestContext context) async {
        await context.uninitializedConnection.encrypt(context.testPlaintext);
      });

      testExpectInvalidOperationError('decrypting a message',
          (TestContext context) async {
        final testMessage = await context.testMessage;
        await context.uninitializedConnection
            .decrypt(testMessage, aad: context.testAad);
      });

      testExpectMessageAuthenticationException(
          'applying a ConnectionRequest with wrong format',
          (TestContext context) async {
        await context.uninitializedConnection.applyConnectionRequest(
          context.invalidFormatCiphertext,
          remoteKey: context.invalidKey);
      });

      testExpectMessageAuthenticationException(
          'applying a ConnectionRequest with wrong aad',
          (TestContext context) async {
          final cr = await context.connectionRequest;
        await context.uninitializedConnection.applyConnectionRequest(
          cr.exportPackage(),
          remoteKey: cr.exportKey(),
          requestAad: context.invalidAad);
      });
    });

    group('with handshake in progress', () {
      testExpectInvalidOperationError('creating a ConnectionRequest',
          (TestContext context) async {
        final connection = await context.handshakeStateConnection;
        await connection.createConnectionRequest();
      });

      testExpectInvalidOperationError('applying a ConnectionRequest',
          (TestContext context) async {
        final request = await context.connectionRequest;
        final connection = await context.handshakeStateConnection;
        await connection.applyConnectionRequest(
          request.exportPackage(),
          remoteKey: request.exportKey(),
        );
      });

      testExpectInvalidOperationError('encrypting a message',
          (TestContext context) async {
        final connection = await context.handshakeStateConnection;
        await connection.encrypt(context.testPlaintext);
      });

      testExpectInvalidOperationError('decrypting a message',
          (TestContext context) async {
        final connection = await context.handshakeStateConnection;
        final message = await context.testMessage;
        await connection.decrypt(message);
      });

      testExpectMessageAuthenticationException(
          'applying a ConnectionConfirmation with wrong format',
          (TestContext context) async {
        final connection = await context.handshakeStateConnection;
        await connection.applyConnectionConfirmation(
          context.invalidFormatCiphertext,
          remoteKey: context.invalidKey,
        );
      });
      testExpectMessageAuthenticationException(
          'applying a ConnectionConfirmation with wrong aad',
          (TestContext context) async {
        final connection = await context.handshakeStateConnection;
        final cc = await context.connectionConfirmation;
        await connection.applyConnectionConfirmation(
          cc.exportPackage(),
          remoteKey: cc.exportKey(),
          aad: context.invalidAad,
        );
      });
    });

    group('with established connection', () {
      testExpectInvalidOperationError('creating a ConnectionRequest',
          (TestContext context) async {
        final connection = await context.establishedConnection;
        await connection.createConnectionRequest();
      });

      testExpectInvalidOperationError('applying a ConnectionRequest',
          (TestContext context) async {
        final cr = await context.connectionRequest;
        final connection = await context.establishedConnection;
        await connection.applyConnectionRequest(cr.exportPackage(),
            remoteKey: cr.exportKey());
      });

      testExpectInvalidOperationError('applying a ConnectionConfirmation',
          (TestContext context) async {
        final cc = await context.connectionConfirmation;
        final connection = await context.establishedConnection;
        await connection.applyConnectionConfirmation(cc.exportPackage(),
            remoteKey: cc.exportKey());
      });

      testExpectMessageAuthenticationException(
          'decrypting a message with wrong format',
          (TestContext context) async {
        final connection = await context.establishedConnection;
        await connection.decrypt(context.invalidFormatCiphertext);
      });

      testExpectMessageAuthenticationException(
          'decrypting a valid message with wrong aad',
          (TestContext context) async {
        final connection = await context.establishedConnection;
        final message = await context.testMessage;
        await connection.decrypt(message, aad: context.invalidAad);
      });
    });
  });
}
