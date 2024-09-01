//
//  Generated code. Do not modify.
//  source: RemindMate.proto
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

import 'RemindMate.pb.dart' as $0;

export 'RemindMate.pb.dart';

@$pb.GrpcServiceName('remind.mate.grpc.RemindMateService')
class RemindMateServiceClient extends $grpc.Client {
  static final _$getMyData = $grpc.ClientMethod<$0.GetMyDataRequest, $0.GetMyDataResponse>(
      '/remind.mate.grpc.RemindMateService/getMyData',
      ($0.GetMyDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetMyDataResponse.fromBuffer(value));
  static final _$updateMyData = $grpc.ClientMethod<$0.UpdateMyDataRequest, $0.UpdateMyDataResponse>(
      '/remind.mate.grpc.RemindMateService/updateMyData',
      ($0.UpdateMyDataRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateMyDataResponse.fromBuffer(value));

  RemindMateServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetMyDataResponse> getMyData($0.GetMyDataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMyData, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateMyDataResponse> updateMyData($0.UpdateMyDataRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateMyData, request, options: options);
  }
}

@$pb.GrpcServiceName('remind.mate.grpc.RemindMateService')
abstract class RemindMateServiceBase extends $grpc.Service {
  $core.String get $name => 'remind.mate.grpc.RemindMateService';

  RemindMateServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetMyDataRequest, $0.GetMyDataResponse>(
        'getMyData',
        getMyData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetMyDataRequest.fromBuffer(value),
        ($0.GetMyDataResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateMyDataRequest, $0.UpdateMyDataResponse>(
        'updateMyData',
        updateMyData_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateMyDataRequest.fromBuffer(value),
        ($0.UpdateMyDataResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetMyDataResponse> getMyData_Pre($grpc.ServiceCall call, $async.Future<$0.GetMyDataRequest> request) async {
    return getMyData(call, await request);
  }

  $async.Future<$0.UpdateMyDataResponse> updateMyData_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateMyDataRequest> request) async {
    return updateMyData(call, await request);
  }

  $async.Future<$0.GetMyDataResponse> getMyData($grpc.ServiceCall call, $0.GetMyDataRequest request);
  $async.Future<$0.UpdateMyDataResponse> updateMyData($grpc.ServiceCall call, $0.UpdateMyDataRequest request);
}
