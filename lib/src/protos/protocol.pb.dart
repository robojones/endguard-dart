///
//  Generated code. Do not modify.
//  source: protocol.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'protocol.pbenum.dart';

export 'protocol.pbenum.dart';

class EncryptedMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EncryptedMessage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'endguard'), createEmptyInstance: create)
    ..e<Algorithm>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'algorithm', $pb.PbFieldType.OE, defaultOrMaker: Algorithm.UNKNOWN, valueOf: Algorithm.valueOf, enumValues: Algorithm.values)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nonce', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mac', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secondaryMacNonce', $pb.PbFieldType.OY, protoName: 'secondaryMacNonce')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'secondaryMac', $pb.PbFieldType.OY, protoName: 'secondaryMac')
    ..a<$core.List<$core.int>>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ciphertext', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  EncryptedMessage._() : super();
  factory EncryptedMessage({
    Algorithm? algorithm,
    $core.List<$core.int>? nonce,
    $core.List<$core.int>? mac,
    $core.List<$core.int>? secondaryMacNonce,
    $core.List<$core.int>? secondaryMac,
    $core.List<$core.int>? ciphertext,
  }) {
    final _result = create();
    if (algorithm != null) {
      _result.algorithm = algorithm;
    }
    if (nonce != null) {
      _result.nonce = nonce;
    }
    if (mac != null) {
      _result.mac = mac;
    }
    if (secondaryMacNonce != null) {
      _result.secondaryMacNonce = secondaryMacNonce;
    }
    if (secondaryMac != null) {
      _result.secondaryMac = secondaryMac;
    }
    if (ciphertext != null) {
      _result.ciphertext = ciphertext;
    }
    return _result;
  }
  factory EncryptedMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EncryptedMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EncryptedMessage clone() => EncryptedMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EncryptedMessage copyWith(void Function(EncryptedMessage) updates) => super.copyWith((message) => updates(message as EncryptedMessage)) as EncryptedMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EncryptedMessage create() => EncryptedMessage._();
  EncryptedMessage createEmptyInstance() => create();
  static $pb.PbList<EncryptedMessage> createRepeated() => $pb.PbList<EncryptedMessage>();
  @$core.pragma('dart2js:noInline')
  static EncryptedMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EncryptedMessage>(create);
  static EncryptedMessage? _defaultInstance;

  @$pb.TagNumber(1)
  Algorithm get algorithm => $_getN(0);
  @$pb.TagNumber(1)
  set algorithm(Algorithm v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAlgorithm() => $_has(0);
  @$pb.TagNumber(1)
  void clearAlgorithm() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get nonce => $_getN(1);
  @$pb.TagNumber(2)
  set nonce($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNonce() => $_has(1);
  @$pb.TagNumber(2)
  void clearNonce() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get mac => $_getN(2);
  @$pb.TagNumber(3)
  set mac($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMac() => $_has(2);
  @$pb.TagNumber(3)
  void clearMac() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get secondaryMacNonce => $_getN(3);
  @$pb.TagNumber(4)
  set secondaryMacNonce($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSecondaryMacNonce() => $_has(3);
  @$pb.TagNumber(4)
  void clearSecondaryMacNonce() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get secondaryMac => $_getN(4);
  @$pb.TagNumber(5)
  set secondaryMac($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSecondaryMac() => $_has(4);
  @$pb.TagNumber(5)
  void clearSecondaryMac() => clearField(5);

  @$pb.TagNumber(10)
  $core.List<$core.int> get ciphertext => $_getN(5);
  @$pb.TagNumber(10)
  set ciphertext($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(10)
  $core.bool hasCiphertext() => $_has(5);
  @$pb.TagNumber(10)
  void clearCiphertext() => clearField(10);
}

class ConnectionOffer extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectionOffer', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'endguard'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newDiffieHellmanPublicKey', $pb.PbFieldType.OY, protoName: 'newDiffieHellmanPublicKey')
    ..hasRequiredFields = false
  ;

  ConnectionOffer._() : super();
  factory ConnectionOffer({
    $core.List<$core.int>? newDiffieHellmanPublicKey,
  }) {
    final _result = create();
    if (newDiffieHellmanPublicKey != null) {
      _result.newDiffieHellmanPublicKey = newDiffieHellmanPublicKey;
    }
    return _result;
  }
  factory ConnectionOffer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectionOffer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectionOffer clone() => ConnectionOffer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectionOffer copyWith(void Function(ConnectionOffer) updates) => super.copyWith((message) => updates(message as ConnectionOffer)) as ConnectionOffer; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectionOffer create() => ConnectionOffer._();
  ConnectionOffer createEmptyInstance() => create();
  static $pb.PbList<ConnectionOffer> createRepeated() => $pb.PbList<ConnectionOffer>();
  @$core.pragma('dart2js:noInline')
  static ConnectionOffer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectionOffer>(create);
  static ConnectionOffer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get newDiffieHellmanPublicKey => $_getN(0);
  @$pb.TagNumber(1)
  set newDiffieHellmanPublicKey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNewDiffieHellmanPublicKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewDiffieHellmanPublicKey() => clearField(1);
}

class ConnectionConfirmation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectionConfirmation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'endguard'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'connectionOfferDiffieHellmanPublicKey', $pb.PbFieldType.OY, protoName: 'connectionOfferDiffieHellmanPublicKey')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outgoingSHA256RatchetInitValue', $pb.PbFieldType.OY, protoName: 'outgoingSHA256RatchetInitValue')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incomingSHA256RatchetInitValue', $pb.PbFieldType.OY, protoName: 'incomingSHA256RatchetInitValue')
    ..a<$core.List<$core.int>>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outgoingNewDiffieHellmanPublicKey', $pb.PbFieldType.OY, protoName: 'outgoingNewDiffieHellmanPublicKey')
    ..a<$core.List<$core.int>>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incomingNewDiffieHellmanPublicKey', $pb.PbFieldType.OY, protoName: 'incomingNewDiffieHellmanPublicKey')
    ..hasRequiredFields = false
  ;

  ConnectionConfirmation._() : super();
  factory ConnectionConfirmation({
    $core.List<$core.int>? connectionOfferDiffieHellmanPublicKey,
    $core.List<$core.int>? outgoingSHA256RatchetInitValue,
    $core.List<$core.int>? incomingSHA256RatchetInitValue,
    $core.List<$core.int>? outgoingNewDiffieHellmanPublicKey,
    $core.List<$core.int>? incomingNewDiffieHellmanPublicKey,
  }) {
    final _result = create();
    if (connectionOfferDiffieHellmanPublicKey != null) {
      _result.connectionOfferDiffieHellmanPublicKey = connectionOfferDiffieHellmanPublicKey;
    }
    if (outgoingSHA256RatchetInitValue != null) {
      _result.outgoingSHA256RatchetInitValue = outgoingSHA256RatchetInitValue;
    }
    if (incomingSHA256RatchetInitValue != null) {
      _result.incomingSHA256RatchetInitValue = incomingSHA256RatchetInitValue;
    }
    if (outgoingNewDiffieHellmanPublicKey != null) {
      _result.outgoingNewDiffieHellmanPublicKey = outgoingNewDiffieHellmanPublicKey;
    }
    if (incomingNewDiffieHellmanPublicKey != null) {
      _result.incomingNewDiffieHellmanPublicKey = incomingNewDiffieHellmanPublicKey;
    }
    return _result;
  }
  factory ConnectionConfirmation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectionConfirmation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectionConfirmation clone() => ConnectionConfirmation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectionConfirmation copyWith(void Function(ConnectionConfirmation) updates) => super.copyWith((message) => updates(message as ConnectionConfirmation)) as ConnectionConfirmation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectionConfirmation create() => ConnectionConfirmation._();
  ConnectionConfirmation createEmptyInstance() => create();
  static $pb.PbList<ConnectionConfirmation> createRepeated() => $pb.PbList<ConnectionConfirmation>();
  @$core.pragma('dart2js:noInline')
  static ConnectionConfirmation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectionConfirmation>(create);
  static ConnectionConfirmation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get connectionOfferDiffieHellmanPublicKey => $_getN(0);
  @$pb.TagNumber(1)
  set connectionOfferDiffieHellmanPublicKey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConnectionOfferDiffieHellmanPublicKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearConnectionOfferDiffieHellmanPublicKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get outgoingSHA256RatchetInitValue => $_getN(1);
  @$pb.TagNumber(2)
  set outgoingSHA256RatchetInitValue($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOutgoingSHA256RatchetInitValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutgoingSHA256RatchetInitValue() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get incomingSHA256RatchetInitValue => $_getN(2);
  @$pb.TagNumber(3)
  set incomingSHA256RatchetInitValue($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncomingSHA256RatchetInitValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncomingSHA256RatchetInitValue() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get outgoingNewDiffieHellmanPublicKey => $_getN(3);
  @$pb.TagNumber(4)
  set outgoingNewDiffieHellmanPublicKey($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutgoingNewDiffieHellmanPublicKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutgoingNewDiffieHellmanPublicKey() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get incomingNewDiffieHellmanPublicKey => $_getN(4);
  @$pb.TagNumber(5)
  set incomingNewDiffieHellmanPublicKey($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIncomingNewDiffieHellmanPublicKey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncomingNewDiffieHellmanPublicKey() => clearField(5);
}

class Envelope extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Envelope', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'endguard'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recipientDiffieHellmanPublicKey', $pb.PbFieldType.OY, protoName: 'recipientDiffieHellmanPublicKey')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderNewDiffieHellmanPublicKey', $pb.PbFieldType.OY, protoName: 'senderNewDiffieHellmanPublicKey')
    ..a<$core.List<$core.int>>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'payload', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Envelope._() : super();
  factory Envelope({
    $core.List<$core.int>? recipientDiffieHellmanPublicKey,
    $core.List<$core.int>? senderNewDiffieHellmanPublicKey,
    $core.List<$core.int>? payload,
  }) {
    final _result = create();
    if (recipientDiffieHellmanPublicKey != null) {
      _result.recipientDiffieHellmanPublicKey = recipientDiffieHellmanPublicKey;
    }
    if (senderNewDiffieHellmanPublicKey != null) {
      _result.senderNewDiffieHellmanPublicKey = senderNewDiffieHellmanPublicKey;
    }
    if (payload != null) {
      _result.payload = payload;
    }
    return _result;
  }
  factory Envelope.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Envelope.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Envelope clone() => Envelope()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Envelope copyWith(void Function(Envelope) updates) => super.copyWith((message) => updates(message as Envelope)) as Envelope; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Envelope create() => Envelope._();
  Envelope createEmptyInstance() => create();
  static $pb.PbList<Envelope> createRepeated() => $pb.PbList<Envelope>();
  @$core.pragma('dart2js:noInline')
  static Envelope getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Envelope>(create);
  static Envelope? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get recipientDiffieHellmanPublicKey => $_getN(0);
  @$pb.TagNumber(1)
  set recipientDiffieHellmanPublicKey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecipientDiffieHellmanPublicKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecipientDiffieHellmanPublicKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get senderNewDiffieHellmanPublicKey => $_getN(1);
  @$pb.TagNumber(2)
  set senderNewDiffieHellmanPublicKey($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSenderNewDiffieHellmanPublicKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearSenderNewDiffieHellmanPublicKey() => clearField(2);

  @$pb.TagNumber(10)
  $core.List<$core.int> get payload => $_getN(2);
  @$pb.TagNumber(10)
  set payload($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(10)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(10)
  void clearPayload() => clearField(10);
}

class DiffieHellmanKeyPair extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DiffieHellmanKeyPair', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'endguard'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'diffieHellmanPublicKey', $pb.PbFieldType.OY, protoName: 'diffieHellmanPublicKey')
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'diffieHellmanPrivateKey', $pb.PbFieldType.OY, protoName: 'diffieHellmanPrivateKey')
    ..hasRequiredFields = false
  ;

  DiffieHellmanKeyPair._() : super();
  factory DiffieHellmanKeyPair({
    $core.List<$core.int>? diffieHellmanPublicKey,
    $core.List<$core.int>? diffieHellmanPrivateKey,
  }) {
    final _result = create();
    if (diffieHellmanPublicKey != null) {
      _result.diffieHellmanPublicKey = diffieHellmanPublicKey;
    }
    if (diffieHellmanPrivateKey != null) {
      _result.diffieHellmanPrivateKey = diffieHellmanPrivateKey;
    }
    return _result;
  }
  factory DiffieHellmanKeyPair.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DiffieHellmanKeyPair.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DiffieHellmanKeyPair clone() => DiffieHellmanKeyPair()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DiffieHellmanKeyPair copyWith(void Function(DiffieHellmanKeyPair) updates) => super.copyWith((message) => updates(message as DiffieHellmanKeyPair)) as DiffieHellmanKeyPair; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DiffieHellmanKeyPair create() => DiffieHellmanKeyPair._();
  DiffieHellmanKeyPair createEmptyInstance() => create();
  static $pb.PbList<DiffieHellmanKeyPair> createRepeated() => $pb.PbList<DiffieHellmanKeyPair>();
  @$core.pragma('dart2js:noInline')
  static DiffieHellmanKeyPair getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DiffieHellmanKeyPair>(create);
  static DiffieHellmanKeyPair? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get diffieHellmanPublicKey => $_getN(0);
  @$pb.TagNumber(1)
  set diffieHellmanPublicKey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDiffieHellmanPublicKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearDiffieHellmanPublicKey() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get diffieHellmanPrivateKey => $_getN(1);
  @$pb.TagNumber(2)
  set diffieHellmanPrivateKey($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDiffieHellmanPrivateKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearDiffieHellmanPrivateKey() => clearField(2);
}

class ConnectionState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ConnectionState', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'endguard'), createEmptyInstance: create)
    ..e<ConnectionState_State>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'initializationState', $pb.PbFieldType.OE, protoName: 'initializationState', defaultOrMaker: ConnectionState_State.NOT_INITIALIZED, valueOf: ConnectionState_State.valueOf, enumValues: ConnectionState_State.values)
    ..e<Algorithm>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outgoingEncryptionAlgorithm', $pb.PbFieldType.OE, protoName: 'outgoingEncryptionAlgorithm', defaultOrMaker: Algorithm.UNKNOWN, valueOf: Algorithm.valueOf, enumValues: Algorithm.values)
    ..a<$core.List<$core.int>>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remoteDiffieHellmanKey', $pb.PbFieldType.OY, protoName: 'remoteDiffieHellmanKey')
    ..pc<DiffieHellmanKeyPair>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'localDiffieHellmanKeyPairs', $pb.PbFieldType.PM, protoName: 'localDiffieHellmanKeyPairs', subBuilder: DiffieHellmanKeyPair.create)
    ..a<$core.List<$core.int>>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incomingSHA256Ratchet', $pb.PbFieldType.OY, protoName: 'incomingSHA256Ratchet')
    ..a<$core.List<$core.int>>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outgoingSHA256Ratchet', $pb.PbFieldType.OY, protoName: 'outgoingSHA256Ratchet')
    ..a<$core.List<$core.int>>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'incomingDiffieHellmanRatchet', $pb.PbFieldType.OY, protoName: 'incomingDiffieHellmanRatchet')
    ..a<$core.List<$core.int>>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outgoingDiffieHellmanRatchet', $pb.PbFieldType.OY, protoName: 'outgoingDiffieHellmanRatchet')
    ..hasRequiredFields = false
  ;

  ConnectionState._() : super();
  factory ConnectionState({
    ConnectionState_State? initializationState,
    Algorithm? outgoingEncryptionAlgorithm,
    $core.List<$core.int>? remoteDiffieHellmanKey,
    $core.Iterable<DiffieHellmanKeyPair>? localDiffieHellmanKeyPairs,
    $core.List<$core.int>? incomingSHA256Ratchet,
    $core.List<$core.int>? outgoingSHA256Ratchet,
    $core.List<$core.int>? incomingDiffieHellmanRatchet,
    $core.List<$core.int>? outgoingDiffieHellmanRatchet,
  }) {
    final _result = create();
    if (initializationState != null) {
      _result.initializationState = initializationState;
    }
    if (outgoingEncryptionAlgorithm != null) {
      _result.outgoingEncryptionAlgorithm = outgoingEncryptionAlgorithm;
    }
    if (remoteDiffieHellmanKey != null) {
      _result.remoteDiffieHellmanKey = remoteDiffieHellmanKey;
    }
    if (localDiffieHellmanKeyPairs != null) {
      _result.localDiffieHellmanKeyPairs.addAll(localDiffieHellmanKeyPairs);
    }
    if (incomingSHA256Ratchet != null) {
      _result.incomingSHA256Ratchet = incomingSHA256Ratchet;
    }
    if (outgoingSHA256Ratchet != null) {
      _result.outgoingSHA256Ratchet = outgoingSHA256Ratchet;
    }
    if (incomingDiffieHellmanRatchet != null) {
      _result.incomingDiffieHellmanRatchet = incomingDiffieHellmanRatchet;
    }
    if (outgoingDiffieHellmanRatchet != null) {
      _result.outgoingDiffieHellmanRatchet = outgoingDiffieHellmanRatchet;
    }
    return _result;
  }
  factory ConnectionState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectionState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectionState clone() => ConnectionState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectionState copyWith(void Function(ConnectionState) updates) => super.copyWith((message) => updates(message as ConnectionState)) as ConnectionState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConnectionState create() => ConnectionState._();
  ConnectionState createEmptyInstance() => create();
  static $pb.PbList<ConnectionState> createRepeated() => $pb.PbList<ConnectionState>();
  @$core.pragma('dart2js:noInline')
  static ConnectionState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectionState>(create);
  static ConnectionState? _defaultInstance;

  @$pb.TagNumber(1)
  ConnectionState_State get initializationState => $_getN(0);
  @$pb.TagNumber(1)
  set initializationState(ConnectionState_State v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInitializationState() => $_has(0);
  @$pb.TagNumber(1)
  void clearInitializationState() => clearField(1);

  @$pb.TagNumber(2)
  Algorithm get outgoingEncryptionAlgorithm => $_getN(1);
  @$pb.TagNumber(2)
  set outgoingEncryptionAlgorithm(Algorithm v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOutgoingEncryptionAlgorithm() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutgoingEncryptionAlgorithm() => clearField(2);

  @$pb.TagNumber(8)
  $core.List<$core.int> get remoteDiffieHellmanKey => $_getN(2);
  @$pb.TagNumber(8)
  set remoteDiffieHellmanKey($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(8)
  $core.bool hasRemoteDiffieHellmanKey() => $_has(2);
  @$pb.TagNumber(8)
  void clearRemoteDiffieHellmanKey() => clearField(8);

  @$pb.TagNumber(9)
  $core.List<DiffieHellmanKeyPair> get localDiffieHellmanKeyPairs => $_getList(3);

  @$pb.TagNumber(12)
  $core.List<$core.int> get incomingSHA256Ratchet => $_getN(4);
  @$pb.TagNumber(12)
  set incomingSHA256Ratchet($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(12)
  $core.bool hasIncomingSHA256Ratchet() => $_has(4);
  @$pb.TagNumber(12)
  void clearIncomingSHA256Ratchet() => clearField(12);

  @$pb.TagNumber(13)
  $core.List<$core.int> get outgoingSHA256Ratchet => $_getN(5);
  @$pb.TagNumber(13)
  set outgoingSHA256Ratchet($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(13)
  $core.bool hasOutgoingSHA256Ratchet() => $_has(5);
  @$pb.TagNumber(13)
  void clearOutgoingSHA256Ratchet() => clearField(13);

  @$pb.TagNumber(14)
  $core.List<$core.int> get incomingDiffieHellmanRatchet => $_getN(6);
  @$pb.TagNumber(14)
  set incomingDiffieHellmanRatchet($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(14)
  $core.bool hasIncomingDiffieHellmanRatchet() => $_has(6);
  @$pb.TagNumber(14)
  void clearIncomingDiffieHellmanRatchet() => clearField(14);

  @$pb.TagNumber(15)
  $core.List<$core.int> get outgoingDiffieHellmanRatchet => $_getN(7);
  @$pb.TagNumber(15)
  set outgoingDiffieHellmanRatchet($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(15)
  $core.bool hasOutgoingDiffieHellmanRatchet() => $_has(7);
  @$pb.TagNumber(15)
  void clearOutgoingDiffieHellmanRatchet() => clearField(15);
}

