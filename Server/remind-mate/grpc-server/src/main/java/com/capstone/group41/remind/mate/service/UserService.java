package com.capstone.group41.remind.mate.service;

import com.auth0.jwt.JWT;
import io.grpc.Context;
import remind.mate.grpc.*;
import org.springframework.stereotype.Service;

import remind.mate.grpc.*;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.AttributeValueUpdate;
import software.amazon.awssdk.services.dynamodb.model.AttributeAction;
import software.amazon.awssdk.services.dynamodb.model.GetItemRequest;
import software.amazon.awssdk.services.dynamodb.model.GetItemResponse;
import software.amazon.awssdk.services.dynamodb.model.UpdateItemRequest;
import software.amazon.awssdk.services.dynamodb.model.UpdateItemResponse;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

@Service
public class UserService {

    private final Region region = Region.AP_SOUTHEAST_2;

    public AddFcmTokenResponse addFcmToken(AddFcmTokenRequest request) {

        Context.Key<String> TOKEN_KEY = Context.key("userId");
        String token = TOKEN_KEY.get();
        String userId = JWT.decode(token).getSubject();

        // dynamodb
        String accessKeyId = "AKIAWBKIEPYFPAIMBUOW";
        String secretAccessKey = "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";
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
        DynamoDbClient dynamoDbClient = DynamoDbClient.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .region(region)
                .build();

        Map<String, AttributeValue> itemValues = new HashMap<>();
        itemValues.put("key", AttributeValue.builder().s(userId).build());

        GetItemRequest getItemRequest = GetItemRequest.builder()
                .tableName("database")
                .key(itemValues)
                .build();

        GetItemResponse getItemResponse = dynamoDbClient.getItem(getItemRequest);

        if (!getItemResponse.hasItem() || getItemResponse.item().isEmpty()) {
            // User does not exist, return false
            return AddFcmTokenResponse.newBuilder()
                    .setSuccess(false)
                    .build();
        }

        // Extract the current FCM tokens (if any)
        List<String> fcmTokens = new ArrayList<>();
        if (getItemResponse.item().containsKey("fcmTokens")) {
            for (AttributeValue fcmToken : getItemResponse.item().get("fcmTokens").l()) {
                fcmTokens.add(fcmToken.s());
            }
        }

        if (!fcmTokens.contains(request.getFcmToken())) {
            fcmTokens.add(request.getFcmToken());

            // Prepare the updated FCM tokens
            List<AttributeValue> updatedFcmTokens = fcmTokens.stream()
                    .map(fcmToken -> AttributeValue.builder().s(fcmToken).build())
                    .toList();

            // Update the user record with the new FCM tokens
            Map<String, AttributeValueUpdate> updatedValues = new HashMap<>();
            updatedValues.put("fcmTokens", AttributeValueUpdate.builder()
                    .value(AttributeValue.builder().l(updatedFcmTokens).build())
                    .action(AttributeAction.PUT)  // This tells DynamoDB to replace the existing value with this one
                    .build());

            UpdateItemRequest updateItemRequest = UpdateItemRequest.builder()
                    .tableName("database")
                    .key(itemValues)
                    .attributeUpdates(updatedValues)
                    .build();

            UpdateItemResponse updateItemResponse = dynamoDbClient.updateItem(updateItemRequest);
        }

        return AddFcmTokenResponse.newBuilder()
                .setSuccess(true)
                .build();
    }
}
