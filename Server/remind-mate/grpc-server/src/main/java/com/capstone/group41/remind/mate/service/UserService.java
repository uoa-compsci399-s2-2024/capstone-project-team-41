package com.capstone.group41.remind.mate.service;

import com.auth0.jwt.JWT;
import com.capstone.group41.remind.mate.config.GrpcInterceptor;
import io.grpc.Context;
import remind.mate.grpc.*;
import org.springframework.stereotype.Service;

import remind.mate.grpc.*;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

@Service
public class UserService {

    private final Region region = Region.AP_SOUTHEAST_2;

    public AddFcmTokenResponse addFcmToken(AddFcmTokenRequest request) {
        String token = GrpcInterceptor.AUTHORIZATION.get().toString();
        String userId = JWT.decode(token).getSubject();

        // dynamodb
        String accessKeyId = "AKIAWBKIEPYFPAIMBUOW";
        String secretAccessKey = "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";
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
        DynamoDbClient dynamoDbClient = DynamoDbClient.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .region(region)
                .build();

        String fcmToken = request.getFcmToken();
        Map<String, AttributeValue> key = new HashMap<>();
        key.put("userId", AttributeValue.builder().s(userId).build());

        Map<String, AttributeValue> expressionValues = new HashMap<>();
        expressionValues.put(":fcmToken", AttributeValue.builder().s(fcmToken).build());

        UpdateItemRequest updateRequest = UpdateItemRequest.builder()
                .tableName("database")
                .key(key)
                .updateExpression("SET fcmToken = :fcmToken")
                .expressionAttributeValues(expressionValues)
                .build();


        // Update the DynamoDB entry
        try {
            dynamoDbClient.updateItem(updateRequest);
        } catch (Exception e) {
            return AddFcmTokenResponse.newBuilder()
                    .setSuccess(false)
                    .build();
        }

        return AddFcmTokenResponse.newBuilder()
                .setSuccess(true)
                .build();
    }
}
