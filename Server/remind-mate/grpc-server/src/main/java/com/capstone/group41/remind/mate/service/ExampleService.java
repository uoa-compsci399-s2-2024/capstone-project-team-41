package com.capstone.group41.remind.mate.service;

import org.springframework.stereotype.Service;
import remind.mate.grpc.ExampleRequest;
import remind.mate.grpc.ExampleResponse;

@Service
public class ExampleService {

    public ExampleResponse exampleResponse(ExampleRequest exampleRequest) {
        return ExampleResponse.newBuilder()
                .setResponse("Request: " + exampleRequest.getRequest())
                .build();
    }
}
