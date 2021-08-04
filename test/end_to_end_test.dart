import 'dart:convert';
import 'dart:typed_data';

import 'package:endguard/endguard.dart';
import 'package:endguard/src/protos/protocol.pb.dart';
import 'package:endguard/src/state/state_accessor.dart';
import 'package:test/test.dart';

void main() {
  group('end-to-end: two instances', () {
    final encryptionAlgorithms = [
      null, // unset => default value
      Algorithm.UNKNOWN, // should also use default
      Algorithm.CHACHA20_POLY1305_HMAC,
      Algorithm.AES256_GCM_HMAC
    ];

    for (var i = 0; i < encryptionAlgorithms.length; i++) {
      for (var j = 0; j < encryptionAlgorithms.length; j++) {
        final algorithmA = encryptionAlgorithms[i];
        final algorithmB = encryptionAlgorithms[j];

        group(
            'A with algorithm=${algorithmA.toString()}, b with algorithm=${algorithmB.toString()}',
            () {
          test(
              'should agree on secrets for the incoming and outgoing Diffie-Hellman ratchet',
              () async {
            final a = Connection();
            final b = Connection();

            if (algorithmA != null) {
              a.setOutgoingEncryptionAlgorithm(algorithmA);
            }
            if (algorithmB != null) {
              b.setOutgoingEncryptionAlgorithm(algorithmB);
            }

            // handshake
            final connectionRequest = await a.createConnectionRequest();
            final connectionConfirmation = await b.applyConnectionRequest(
                connectionRequest.exportPackage(),
                remoteKey: connectionRequest.exportKey());
            await a.applyConnectionConfirmation(
                connectionConfirmation.exportPackage(),
                remoteKey: connectionConfirmation.exportKey());

            final aState = StateAccessor.withState(a.getState());
            final bState = StateAccessor.withState(b.getState());
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

            if (algorithmA != null) {
              a.setOutgoingEncryptionAlgorithm(algorithmA);
            }
            if (algorithmB != null) {
              b.setOutgoingEncryptionAlgorithm(algorithmB);
            }

            // handshake
            final connectionRequest = await a.createConnectionRequest();
            final connectionConfirmation = await b.applyConnectionRequest(
                connectionRequest.exportPackage(),
                remoteKey: connectionRequest.exportKey());
            await a.applyConnectionConfirmation(
                connectionConfirmation.exportPackage(),
                remoteKey: connectionConfirmation.exportKey());

            final aState = StateAccessor.withState(a.getState());
            final bState = StateAccessor.withState(b.getState());
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

            if (algorithmA != null) {
              a.setOutgoingEncryptionAlgorithm(algorithmA);
            }
            if (algorithmB != null) {
              b.setOutgoingEncryptionAlgorithm(algorithmB);
            }

            // handshake
            final connectionRequest = await a.createConnectionRequest();
            final connectionConfirmation = await b.applyConnectionRequest(
                connectionRequest.exportPackage(),
                remoteKey: connectionRequest.exportKey());
            await a.applyConnectionConfirmation(
                connectionConfirmation.exportPackage(),
                remoteKey: connectionConfirmation.exportKey());

            Future<void> testSendMessage({
              required Connection sender,
              required Connection recipient,
              required String message,
            }) async {
              final m = Uint8List.fromList(utf8.encode(message));
              final encrypted = await sender.encrypt(m);
              final result = await recipient.decrypt(encrypted);

              expect(result.length, equals(m.length));
              expect(result, equals(m));
            }

            await testSendMessage(
                sender: a, recipient: b, message: 'message from a to b');
            await testSendMessage(
                sender: b, recipient: a, message: 'message from b to a');
            await testSendMessage(
                sender: b, recipient: a, message: 'message from b to a');
            await testSendMessage(
                sender: a, recipient: b, message: 'message from a to b');
          });
        });
      }
    }
  });
}
