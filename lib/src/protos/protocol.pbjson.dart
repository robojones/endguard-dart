///
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use algorithmDescriptor instead')
const Algorithm$json = const {
  '1': 'Algorithm',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'AES256_GCM_HMAC', '2': 1},
    const {'1': 'CHACHA20_POLY1305_HMAC', '2': 2},
  ],
};

/// Descriptor for `Algorithm`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List algorithmDescriptor = $convert.base64Decode('CglBbGdvcml0aG0SCwoHVU5LTk9XThAAEhMKD0FFUzI1Nl9HQ01fSE1BQxABEhoKFkNIQUNIQTIwX1BPTFkxMzA1X0hNQUMQAg==');
@$core.Deprecated('Use encryptedMessageDescriptor instead')
const EncryptedMessage$json = const {
  '1': 'EncryptedMessage',
  '2': const [
    const {'1': 'algorithm', '3': 1, '4': 1, '5': 14, '6': '.endguard.Algorithm', '10': 'algorithm'},
    const {'1': 'nonce', '3': 2, '4': 1, '5': 12, '10': 'nonce'},
    const {'1': 'mac', '3': 3, '4': 1, '5': 12, '10': 'mac'},
    const {'1': 'secondaryMacNonce', '3': 4, '4': 1, '5': 12, '10': 'secondaryMacNonce'},
    const {'1': 'secondaryMac', '3': 5, '4': 1, '5': 12, '10': 'secondaryMac'},
    const {'1': 'ciphertext', '3': 10, '4': 1, '5': 12, '10': 'ciphertext'},
  ],
};

/// Descriptor for `EncryptedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List encryptedMessageDescriptor = $convert.base64Decode('ChBFbmNyeXB0ZWRNZXNzYWdlEjEKCWFsZ29yaXRobRgBIAEoDjITLmVuZGd1YXJkLkFsZ29yaXRobVIJYWxnb3JpdGhtEhQKBW5vbmNlGAIgASgMUgVub25jZRIQCgNtYWMYAyABKAxSA21hYxIsChFzZWNvbmRhcnlNYWNOb25jZRgEIAEoDFIRc2Vjb25kYXJ5TWFjTm9uY2USIgoMc2Vjb25kYXJ5TWFjGAUgASgMUgxzZWNvbmRhcnlNYWMSHgoKY2lwaGVydGV4dBgKIAEoDFIKY2lwaGVydGV4dA==');
@$core.Deprecated('Use connectionOfferDescriptor instead')
const ConnectionOffer$json = const {
  '1': 'ConnectionOffer',
  '2': const [
    const {'1': 'newDiffieHellmanPublicKey', '3': 1, '4': 1, '5': 12, '10': 'newDiffieHellmanPublicKey'},
  ],
};

/// Descriptor for `ConnectionOffer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionOfferDescriptor = $convert.base64Decode('Cg9Db25uZWN0aW9uT2ZmZXISPAoZbmV3RGlmZmllSGVsbG1hblB1YmxpY0tleRgBIAEoDFIZbmV3RGlmZmllSGVsbG1hblB1YmxpY0tleQ==');
@$core.Deprecated('Use connectionConfirmationDescriptor instead')
const ConnectionConfirmation$json = const {
  '1': 'ConnectionConfirmation',
  '2': const [
    const {'1': 'connectionOfferDiffieHellmanPublicKey', '3': 1, '4': 1, '5': 12, '10': 'connectionOfferDiffieHellmanPublicKey'},
    const {'1': 'outgoingSHA256RatchetInitValue', '3': 2, '4': 1, '5': 12, '10': 'outgoingSHA256RatchetInitValue'},
    const {'1': 'incomingSHA256RatchetInitValue', '3': 3, '4': 1, '5': 12, '10': 'incomingSHA256RatchetInitValue'},
    const {'1': 'outgoingNewDiffieHellmanPublicKey', '3': 4, '4': 1, '5': 12, '10': 'outgoingNewDiffieHellmanPublicKey'},
    const {'1': 'incomingNewDiffieHellmanPublicKey', '3': 5, '4': 1, '5': 12, '10': 'incomingNewDiffieHellmanPublicKey'},
  ],
};

/// Descriptor for `ConnectionConfirmation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionConfirmationDescriptor = $convert.base64Decode('ChZDb25uZWN0aW9uQ29uZmlybWF0aW9uElQKJWNvbm5lY3Rpb25PZmZlckRpZmZpZUhlbGxtYW5QdWJsaWNLZXkYASABKAxSJWNvbm5lY3Rpb25PZmZlckRpZmZpZUhlbGxtYW5QdWJsaWNLZXkSRgoeb3V0Z29pbmdTSEEyNTZSYXRjaGV0SW5pdFZhbHVlGAIgASgMUh5vdXRnb2luZ1NIQTI1NlJhdGNoZXRJbml0VmFsdWUSRgoeaW5jb21pbmdTSEEyNTZSYXRjaGV0SW5pdFZhbHVlGAMgASgMUh5pbmNvbWluZ1NIQTI1NlJhdGNoZXRJbml0VmFsdWUSTAohb3V0Z29pbmdOZXdEaWZmaWVIZWxsbWFuUHVibGljS2V5GAQgASgMUiFvdXRnb2luZ05ld0RpZmZpZUhlbGxtYW5QdWJsaWNLZXkSTAohaW5jb21pbmdOZXdEaWZmaWVIZWxsbWFuUHVibGljS2V5GAUgASgMUiFpbmNvbWluZ05ld0RpZmZpZUhlbGxtYW5QdWJsaWNLZXk=');
@$core.Deprecated('Use envelopeDescriptor instead')
const Envelope$json = const {
  '1': 'Envelope',
  '2': const [
    const {'1': 'recipientDiffieHellmanPublicKey', '3': 1, '4': 1, '5': 12, '10': 'recipientDiffieHellmanPublicKey'},
    const {'1': 'senderNewDiffieHellmanPublicKey', '3': 2, '4': 1, '5': 12, '10': 'senderNewDiffieHellmanPublicKey'},
    const {'1': 'payload', '3': 10, '4': 1, '5': 12, '10': 'payload'},
  ],
};

/// Descriptor for `Envelope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List envelopeDescriptor = $convert.base64Decode('CghFbnZlbG9wZRJICh9yZWNpcGllbnREaWZmaWVIZWxsbWFuUHVibGljS2V5GAEgASgMUh9yZWNpcGllbnREaWZmaWVIZWxsbWFuUHVibGljS2V5EkgKH3NlbmRlck5ld0RpZmZpZUhlbGxtYW5QdWJsaWNLZXkYAiABKAxSH3NlbmRlck5ld0RpZmZpZUhlbGxtYW5QdWJsaWNLZXkSGAoHcGF5bG9hZBgKIAEoDFIHcGF5bG9hZA==');
@$core.Deprecated('Use diffieHellmanKeyPairDescriptor instead')
const DiffieHellmanKeyPair$json = const {
  '1': 'DiffieHellmanKeyPair',
  '2': const [
    const {'1': 'diffieHellmanPublicKey', '3': 1, '4': 1, '5': 12, '10': 'diffieHellmanPublicKey'},
    const {'1': 'diffieHellmanPrivateKey', '3': 2, '4': 1, '5': 12, '10': 'diffieHellmanPrivateKey'},
  ],
};

/// Descriptor for `DiffieHellmanKeyPair`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List diffieHellmanKeyPairDescriptor = $convert.base64Decode('ChREaWZmaWVIZWxsbWFuS2V5UGFpchI2ChZkaWZmaWVIZWxsbWFuUHVibGljS2V5GAEgASgMUhZkaWZmaWVIZWxsbWFuUHVibGljS2V5EjgKF2RpZmZpZUhlbGxtYW5Qcml2YXRlS2V5GAIgASgMUhdkaWZmaWVIZWxsbWFuUHJpdmF0ZUtleQ==');
@$core.Deprecated('Use connectionStateDescriptor instead')
const ConnectionState$json = const {
  '1': 'ConnectionState',
  '2': const [
    const {'1': 'initializationState', '3': 1, '4': 1, '5': 14, '6': '.endguard.ConnectionState.State', '10': 'initializationState'},
    const {'1': 'outgoingEncryptionAlgorithm', '3': 2, '4': 1, '5': 14, '6': '.endguard.Algorithm', '10': 'outgoingEncryptionAlgorithm'},
    const {'1': 'remoteDiffieHellmanKey', '3': 8, '4': 1, '5': 12, '10': 'remoteDiffieHellmanKey'},
    const {'1': 'localDiffieHellmanKeyPairs', '3': 9, '4': 3, '5': 11, '6': '.endguard.DiffieHellmanKeyPair', '10': 'localDiffieHellmanKeyPairs'},
    const {'1': 'incomingSHA256Ratchet', '3': 12, '4': 1, '5': 12, '10': 'incomingSHA256Ratchet'},
    const {'1': 'outgoingSHA256Ratchet', '3': 13, '4': 1, '5': 12, '10': 'outgoingSHA256Ratchet'},
    const {'1': 'incomingDiffieHellmanRatchet', '3': 14, '4': 1, '5': 12, '10': 'incomingDiffieHellmanRatchet'},
    const {'1': 'outgoingDiffieHellmanRatchet', '3': 15, '4': 1, '5': 12, '10': 'outgoingDiffieHellmanRatchet'},
  ],
  '4': const [ConnectionState_State$json],
};

@$core.Deprecated('Use connectionStateDescriptor instead')
const ConnectionState_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'NOT_INITIALIZED', '2': 0},
    const {'1': 'HANDSHAKE', '2': 1},
    const {'1': 'ESTABLISHED', '2': 2},
  ],
};

/// Descriptor for `ConnectionState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectionStateDescriptor = $convert.base64Decode('Cg9Db25uZWN0aW9uU3RhdGUSUQoTaW5pdGlhbGl6YXRpb25TdGF0ZRgBIAEoDjIfLmVuZGd1YXJkLkNvbm5lY3Rpb25TdGF0ZS5TdGF0ZVITaW5pdGlhbGl6YXRpb25TdGF0ZRJVChtvdXRnb2luZ0VuY3J5cHRpb25BbGdvcml0aG0YAiABKA4yEy5lbmRndWFyZC5BbGdvcml0aG1SG291dGdvaW5nRW5jcnlwdGlvbkFsZ29yaXRobRI2ChZyZW1vdGVEaWZmaWVIZWxsbWFuS2V5GAggASgMUhZyZW1vdGVEaWZmaWVIZWxsbWFuS2V5El4KGmxvY2FsRGlmZmllSGVsbG1hbktleVBhaXJzGAkgAygLMh4uZW5kZ3VhcmQuRGlmZmllSGVsbG1hbktleVBhaXJSGmxvY2FsRGlmZmllSGVsbG1hbktleVBhaXJzEjQKFWluY29taW5nU0hBMjU2UmF0Y2hldBgMIAEoDFIVaW5jb21pbmdTSEEyNTZSYXRjaGV0EjQKFW91dGdvaW5nU0hBMjU2UmF0Y2hldBgNIAEoDFIVb3V0Z29pbmdTSEEyNTZSYXRjaGV0EkIKHGluY29taW5nRGlmZmllSGVsbG1hblJhdGNoZXQYDiABKAxSHGluY29taW5nRGlmZmllSGVsbG1hblJhdGNoZXQSQgocb3V0Z29pbmdEaWZmaWVIZWxsbWFuUmF0Y2hldBgPIAEoDFIcb3V0Z29pbmdEaWZmaWVIZWxsbWFuUmF0Y2hldCI8CgVTdGF0ZRITCg9OT1RfSU5JVElBTElaRUQQABINCglIQU5EU0hBS0UQARIPCgtFU1RBQkxJU0hFRBAC');
