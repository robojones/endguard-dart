import 'dart:convert';
import 'dart:typed_data';

import 'package:endguard/endguard.dart';
import 'package:test/test.dart';

void main() {
  group('api', () {
    test('should export all types intended for external use', () async {
      // This test should use ALL APIs intended for developers using this library.

      // Declare all variables for this test in this section.
      // All variables in this test MUST be typed and not initialized.
      Connection a, b;
      HandshakeMessage cr, cc;
      Uint8List ciphertext, plaintext, state;

      // Use the uninitialized variables from the previous section here.
      // There MUST NOT be any new variables in this section.
      a = Connection();
      b = Connection();

      a.setOutgoingEncryptionAlgorithm(Algorithm.AES256_GCM_HMAC);
      b.setOutgoingEncryptionAlgorithm(Algorithm.CHACHA20_POLY1305_HMAC);

      try {
        cr = await a.createConnectionRequest();
        cc = await b.applyConnectionRequest(cr.exportPackage(),
            remoteKey: cr.exportKey());
        await a.applyConnectionConfirmation(cc.exportPackage(),
            remoteKey: cc.exportKey());

        // state export and import
        state = a.getState();
        a = Connection.fromState(state);

        // normal encryption and decryption
        ciphertext = await a.encrypt(utf8.encode('test message'));
        plaintext = await b.decrypt(ciphertext);
        expect(utf8.decode(plaintext), equals('test message'));
      } on MessageAuthenticationException {
        // This case could happen if an attacker tampers with a message
      } on InvalidOperationError {
        // This will only happen when the library is used wrongly
      }
    });
  });
}
