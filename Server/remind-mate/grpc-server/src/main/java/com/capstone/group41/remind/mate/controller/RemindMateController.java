package com.capstone.group41.remind.mate.controller;

import com.capstone.group41.remind.mate.service.GetMyDataService;
import com.capstone.group41.remind.mate.service.UpdateMyDataService;
import io.grpc.stub.StreamObserver;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.devh.boot.grpc.server.service.GrpcService;
import remind.mate.grpc.*;

@GrpcService
@Slf4j
@AllArgsConstructor
public class RemindMateController extends RemindMateServiceGrpc.RemindMateServiceImplBase {

    private final GetMyDataService getMyDataService;
    private final UpdateMyDataService updateMyDataService;

    @Override
    public void getMyData(GetMyDataRequest request, StreamObserver<GetMyDataResponse> responseObserver) {
        var response = getMyDataService.getMyData(request);
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

    @Override
    public void updateMyData(UpdateMyDataRequest request, StreamObserver<UpdateMyDataResponse> responseObserver) {
        var response = updateMyDataService.updateMyData(request);
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }
}
