///
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class State extends $pb.ProtobufEnum {
  static const State NOT_INITIALIZED = State._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NOT_INITIALIZED');
  static const State HANDSHAKE = State._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HANDSHAKE');
  static const State ESTABLISHED = State._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ESTABLISHED');

  static const $core.List<State> values = <State> [
    NOT_INITIALIZED,
    HANDSHAKE,
    ESTABLISHED,
  ];

  static final $core.Map<$core.int, State> _byValue = $pb.ProtobufEnum.initByValue(values);
  static State valueOf($core.int value) => _byValue[value];

  const State._($core.int v, $core.String n) : super(v, n);
}

