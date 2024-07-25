package com.capstone.group41.remind.mate.service;


import io.grpc.stub.StreamObserver;
import net.devh.boot.grpc.server.service.GrpcService;
import remind.mate.grpc.GiveMeTrueRequest;
import remind.mate.grpc.GiveMeTrueResponse;
import remind.mate.grpc.Message;
import remind.mate.grpc.MessageServiceGrpc;

@GrpcService
public class MessageService extends MessageServiceGrpc.MessageServiceImplBase {

    @Override
    public void send(Message request, StreamObserver<Message> responseObserver) {
        // create response
        Message message = Message.newBuilder()
                .setMessage("gRPC server received your message: " + request.getMessage())
                .build();

        // add to stream observer
        responseObserver.onNext(message);

        // complete
        responseObserver.onCompleted();
    }

    @Override
    public void giveMeTrue(GiveMeTrueRequest request, StreamObserver<GiveMeTrueResponse> responseObserver) {
        responseObserver.onNext(GiveMeTrueResponse.newBuilder().setTrue(true).build());
        responseObserver.onCompleted();
    }
}
