///
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Algorithm extends $pb.ProtobufEnum {
  static const Algorithm UNKNOWN = Algorithm._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const Algorithm AES256_GCM_HMAC = Algorithm._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AES256_GCM_HMAC');
  static const Algorithm CHACHA20_POLY1305_HMAC = Algorithm._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CHACHA20_POLY1305_HMAC');

  static const $core.List<Algorithm> values = <Algorithm> [
    UNKNOWN,
    AES256_GCM_HMAC,
    CHACHA20_POLY1305_HMAC,
  ];

  static final $core.Map<$core.int, Algorithm> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Algorithm valueOf($core.int value) => _byValue[value];

  const Algorithm._($core.int v, $core.String n) : super(v, n);
}

class ConnectionState_State extends $pb.ProtobufEnum {
  static const ConnectionState_State NOT_INITIALIZED = ConnectionState_State._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_INITIALIZED');
  static const ConnectionState_State HANDSHAKE = ConnectionState_State._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HANDSHAKE');
  static const ConnectionState_State ESTABLISHED = ConnectionState_State._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ESTABLISHED');

  static const $core.List<ConnectionState_State> values = <ConnectionState_State> [
    NOT_INITIALIZED,
    HANDSHAKE,
    ESTABLISHED,
  ];

  static final $core.Map<$core.int, ConnectionState_State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ConnectionState_State valueOf($core.int value) => _byValue[value];

  const ConnectionState_State._($core.int v, $core.String n) : super(v, n);
}

