package com.capstone.group41.remind.mate.controller;

import com.capstone.group41.remind.mate.service.ExampleService;
import io.grpc.Context;
import io.grpc.stub.StreamObserver;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.devh.boot.grpc.server.service.GrpcService;
import remind.mate.grpc.ExampleRequest;
import remind.mate.grpc.ExampleResponse;
import remind.mate.grpc.ExampleServiceGrpc;

import static com.capstone.group41.remind.mate.config.GrpcInterceptor.AUTHORIZATION;


@GrpcService
@Slf4j
@AllArgsConstructor
public class ExampleController extends ExampleServiceGrpc.ExampleServiceImplBase {

    private final ExampleService exampleService;

    @Override
    public void example(ExampleRequest request, StreamObserver<ExampleResponse> responseObserver) {

        ExampleResponse response = exampleService.exampleResponse(request);
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

}
