//
//  Generated code. Do not modify.
//  source: Message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ExampleRequest extends $pb.GeneratedMessage {
  factory ExampleRequest({
    $core.String? request,
  }) {
    final $result = create();
    if (request != null) {
      $result.request = request;
    }
    return $result;
  }
  ExampleRequest._() : super();
  factory ExampleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExampleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExampleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'request')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExampleRequest clone() => ExampleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExampleRequest copyWith(void Function(ExampleRequest) updates) => super.copyWith((message) => updates(message as ExampleRequest)) as ExampleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExampleRequest create() => ExampleRequest._();
  ExampleRequest createEmptyInstance() => create();
  static $pb.PbList<ExampleRequest> createRepeated() => $pb.PbList<ExampleRequest>();
  @$core.pragma('dart2js:noInline')
  static ExampleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExampleRequest>(create);
  static ExampleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get request => $_getSZ(0);
  @$pb.TagNumber(1)
  set request($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => clearField(1);
}

class ExampleResponse extends $pb.GeneratedMessage {
  factory ExampleResponse({
    $core.String? response,
  }) {
    final $result = create();
    if (response != null) {
      $result.response = response;
    }
    return $result;
  }
  ExampleResponse._() : super();
  factory ExampleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExampleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExampleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'remind.mate.grpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'response')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExampleResponse clone() => ExampleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExampleResponse copyWith(void Function(ExampleResponse) updates) => super.copyWith((message) => updates(message as ExampleResponse)) as ExampleResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExampleResponse create() => ExampleResponse._();
  ExampleResponse createEmptyInstance() => create();
  static $pb.PbList<ExampleResponse> createRepeated() => $pb.PbList<ExampleResponse>();
  @$core.pragma('dart2js:noInline')
  static ExampleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExampleResponse>(create);
  static ExampleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get response => $_getSZ(0);
  @$pb.TagNumber(1)
  set response($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponse() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponse() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
