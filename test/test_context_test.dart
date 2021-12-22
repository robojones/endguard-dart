import 'package:test/test.dart';

import 'test_context.dart';

void main() {
  group('connection context:', () {
    test('the connection request package can be applied to an uninitialized connection', () async {
      final context = TestContext();

      final cr = await context.connectionRequest;
      final a = context.uninitializedConnection;

      await a.applyConnectionRequest(cr.exportPackage(), remoteKey: cr.exportKey());
    });

    test('the connection confirmation package can be applied to a connection in handshake state', () async {
      final context = TestContext();

      final cc = await context.connectionConfirmation;
      final a = await context.handshakeStateConnection;

      await a.applyConnectionConfirmation(cc.exportPackage(), remoteKey: cc.exportKey());
    });

    test('the testMessage can be decrypted by the established connection', () async {
      final context = TestContext();

      final testMessage = await context.testMessage;
      final testAad = context.testAad;
      final a = await context.establishedConnection;

      await a.decrypt(testMessage, aad: testAad);
    });
  });
}