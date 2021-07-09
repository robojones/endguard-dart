import 'dart:convert';

import 'package:endguard/endguard.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/state/state_accessor.dart';
import 'package:test/test.dart';

void main() {
  group('connection', () {
    group('end-to-end: two instances', () {
      test(
          'should agree on secrets for the incoming and outgoing Diffie-Hellman ratchet',
          () async {
        final a = Connection();
        final b = Connection();

        // handshake
        final welcomePackage = await a.createConnectionRequest();
        final connectionConfirmation = await b.applyConnectionOffer(welcomePackage.exportPackage(),
            remoteKey: welcomePackage.exportKey());
        await a.applyConnectionConfirmation(connectionConfirmation.exportPackage(),
            remoteKey: connectionConfirmation.exportKey());

        final aState =
            StateAccessor.withState(ConnectionState.fromBuffer(a.getState()));
        final bState =
            StateAccessor.withState(ConnectionState.fromBuffer(b.getState()));
        expect(aState.incomingDiffieHellmanRatchet,
            equals(bState.outgoingDiffieHellmanRatchet));
        expect(aState.outgoingDiffieHellmanRatchet,
            equals(bState.incomingDiffieHellmanRatchet));
      });

      test(
          'both instances should agree on initial values for the SHA-256 hash ratchet',
          () async {
        final a = Connection();
        final b = Connection();

        // handshake
        final welcomePackage = await a.createConnectionRequest();
        final connectionConfirmation = await b.applyConnectionOffer(welcomePackage.exportPackage(),
            remoteKey: welcomePackage.exportKey());
        await a.applyConnectionConfirmation(connectionConfirmation.exportPackage(),
            remoteKey: connectionConfirmation.exportKey());

        final aState =
            StateAccessor.withState(ConnectionState.fromBuffer(a.getState()));
        final bState =
            StateAccessor.withState(ConnectionState.fromBuffer(b.getState()));
        expect(aState.incomingSHA256Ratchet,
            equals(bState.outgoingSHA256Ratchet));
        expect(aState.outgoingSHA256Ratchet,
            equals(bState.incomingSHA256Ratchet));
      });

      test(
          'messages should be able to be encrypted by one instance and encrypted by the other',
          () async {
        final a = Connection();
        final b = Connection();

        // handshake
        final welcomePackage = await a.createConnectionRequest();
        final connectionConfirmation = await b.applyConnectionOffer(welcomePackage.exportPackage(),
            remoteKey: welcomePackage.exportKey());
        await a.applyConnectionConfirmation(connectionConfirmation.exportPackage(),
            remoteKey: connectionConfirmation.exportKey());

        Future<void> testSendMessage({
          Connection sender,
          Connection recipient,
          String message,
        }) async {
          final m = utf8.encode(message);
          final encrypted = await sender.encrypt(m);
          final result = await recipient.decrypt(encrypted);

          expect(result.length, equals(m.length));
          expect(result, equals(m));
        }

        await testSendMessage(sender: a, recipient: b, message: 'message from a to b');
        await testSendMessage(sender: b, recipient: a, message: 'message from b to a');
        await testSendMessage(sender: b, recipient: a, message: 'message from b to a');
        await testSendMessage(sender: a, recipient: b, message: 'message from a to b');
      });
    });
  });
}
