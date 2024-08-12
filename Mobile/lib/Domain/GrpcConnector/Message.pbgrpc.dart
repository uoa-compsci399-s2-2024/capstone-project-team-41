//
//  Generated code. Do not modify.
//  source: Message.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'Message.pb.dart' as $0;

export 'Message.pb.dart';

@$pb.GrpcServiceName('remind.mate.grpc.ExampleService')
class ExampleServiceClient extends $grpc.Client {
  static final _$example = $grpc.ClientMethod<$0.ExampleRequest, $0.ExampleResponse>(
      '/remind.mate.grpc.ExampleService/example',
      ($0.ExampleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ExampleResponse.fromBuffer(value));

  ExampleServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.ExampleResponse> example($0.ExampleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$example, request, options: options);
  }
}

@$pb.GrpcServiceName('remind.mate.grpc.ExampleService')
abstract class ExampleServiceBase extends $grpc.Service {
  $core.String get $name => 'remind.mate.grpc.ExampleService';

  ExampleServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ExampleRequest, $0.ExampleResponse>(
        'example',
        example_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExampleRequest.fromBuffer(value),
        ($0.ExampleResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ExampleResponse> example_Pre($grpc.ServiceCall call, $async.Future<$0.ExampleRequest> request) async {
    return example(call, await request);
  }

  $async.Future<$0.ExampleResponse> example($grpc.ServiceCall call, $0.ExampleRequest request);
}
