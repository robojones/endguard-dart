///
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

const Algorithm$json = const {
  '1': 'Algorithm',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'AES256_GCM_HMAC', '2': 1},
    const {'1': 'CHACHA20_POLY1305_HMAC', '2': 2},
  ],
};

const EncryptedMessage$json = const {
  '1': 'EncryptedMessage',
  '2': const [
    const {
      '1': 'algorithm',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.endguard.Algorithm',
      '10': 'algorithm'
    },
    const {'1': 'nonce', '3': 2, '4': 1, '5': 12, '10': 'nonce'},
    const {'1': 'mac', '3': 3, '4': 1, '5': 12, '10': 'mac'},
    const {
      '1': 'secondaryMacNonce',
      '3': 4,
      '4': 1,
      '5': 12,
      '10': 'secondaryMacNonce'
    },
    const {'1': 'secondaryMac', '3': 5, '4': 1, '5': 12, '10': 'secondaryMac'},
    const {'1': 'ciphertext', '3': 10, '4': 1, '5': 12, '10': 'ciphertext'},
  ],
};

const ConnectionOffer$json = const {
  '1': 'ConnectionOffer',
  '2': const [
    const {
      '1': 'newDiffieHellmanPublicKey',
      '3': 1,
      '4': 1,
      '5': 12,
      '10': 'newDiffieHellmanPublicKey'
    },
  ],
};

const ConnectionConfirmation$json = const {
  '1': 'ConnectionConfirmation',
  '2': const [
    const {
      '1': 'connectionOfferDiffieHellmanPublicKey',
      '3': 1,
      '4': 1,
      '5': 12,
      '10': 'connectionOfferDiffieHellmanPublicKey'
    },
    const {
      '1': 'outgoingSHA256RatchetInitValue',
      '3': 2,
      '4': 1,
      '5': 12,
      '10': 'outgoingSHA256RatchetInitValue'
    },
    const {
      '1': 'incomingSHA256RatchetInitValue',
      '3': 3,
      '4': 1,
      '5': 12,
      '10': 'incomingSHA256RatchetInitValue'
    },
    const {
      '1': 'outgoingNewDiffieHellmanPublicKey',
      '3': 4,
      '4': 1,
      '5': 12,
      '10': 'outgoingNewDiffieHellmanPublicKey'
    },
    const {
      '1': 'incomingNewDiffieHellmanPublicKey',
      '3': 5,
      '4': 1,
      '5': 12,
      '10': 'incomingNewDiffieHellmanPublicKey'
    },
  ],
};

const Envelope$json = const {
  '1': 'Envelope',
  '2': const [
    const {
      '1': 'recipientDiffieHellmanPublicKey',
      '3': 1,
      '4': 1,
      '5': 12,
      '10': 'recipientDiffieHellmanPublicKey'
    },
    const {
      '1': 'senderNewDiffieHellmanPublicKey',
      '3': 2,
      '4': 1,
      '5': 12,
      '10': 'senderNewDiffieHellmanPublicKey'
    },
    const {'1': 'payload', '3': 10, '4': 1, '5': 12, '10': 'payload'},
  ],
};

const DiffieHellmanKeyPair$json = const {
  '1': 'DiffieHellmanKeyPair',
  '2': const [
    const {
      '1': 'diffieHellmanPublicKey',
      '3': 1,
      '4': 1,
      '5': 12,
      '10': 'diffieHellmanPublicKey'
    },
    const {
      '1': 'diffieHellmanPrivateKey',
      '3': 2,
      '4': 1,
      '5': 12,
      '10': 'diffieHellmanPrivateKey'
    },
  ],
};

const ConnectionState$json = const {
  '1': 'ConnectionState',
  '2': const [
    const {
      '1': 'initializationState',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.endguard.ConnectionState.State',
      '10': 'initializationState'
    },
    const {
      '1': 'outgoingEncryptionAlgorithm',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.endguard.Algorithm',
      '10': 'outgoingEncryptionAlgorithm'
    },
    const {
      '1': 'remoteDiffieHellmanKey',
      '3': 8,
      '4': 1,
      '5': 12,
      '10': 'remoteDiffieHellmanKey'
    },
    const {
      '1': 'localDiffieHellmanKeyPairs',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.endguard.DiffieHellmanKeyPair',
      '10': 'localDiffieHellmanKeyPairs'
    },
    const {
      '1': 'incomingSHA256Ratchet',
      '3': 12,
      '4': 1,
      '5': 12,
      '10': 'incomingSHA256Ratchet'
    },
    const {
      '1': 'outgoingSHA256Ratchet',
      '3': 13,
      '4': 1,
      '5': 12,
      '10': 'outgoingSHA256Ratchet'
    },
    const {
      '1': 'incomingDiffieHellmanRatchet',
      '3': 14,
      '4': 1,
      '5': 12,
      '10': 'incomingDiffieHellmanRatchet'
    },
    const {
      '1': 'outgoingDiffieHellmanRatchet',
      '3': 15,
      '4': 1,
      '5': 12,
      '10': 'outgoingDiffieHellmanRatchet'
    },
  ],
  '4': const [ConnectionState_State$json],
};

const ConnectionState_State$json = const {
  '1': 'State',
  '2': const [
    const {'1': 'NOT_INITIALIZED', '2': 0},
    const {'1': 'HANDSHAKE', '2': 1},
    const {'1': 'ESTABLISHED', '2': 2},
  ],
};
