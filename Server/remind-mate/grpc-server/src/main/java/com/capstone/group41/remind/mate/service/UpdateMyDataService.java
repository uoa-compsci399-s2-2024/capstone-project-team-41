package com.capstone.group41.remind.mate.service;

import org.springframework.stereotype.Service;
import remind.mate.grpc.UpdateMyDataRequest;
import remind.mate.grpc.UpdateMyDataResponse;

@Service
public class UpdateMyDataService {

    public UpdateMyDataResponse updateMyData(UpdateMyDataRequest request) {
        return UpdateMyDataResponse.newBuilder()
                .build();
    }
}
