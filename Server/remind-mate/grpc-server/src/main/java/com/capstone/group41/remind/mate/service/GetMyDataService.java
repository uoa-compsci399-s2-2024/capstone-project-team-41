package com.capstone.group41.remind.mate.service;

import com.google.protobuf.InvalidProtocolBufferException;
import org.springframework.stereotype.Service;
import remind.mate.grpc.GetMyDataRequest;
import remind.mate.grpc.GetMyDataResponse;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.GetItemRequest;
import software.amazon.awssdk.services.dynamodb.model.GetItemResponse;
import software.amazon.awssdk.core.SdkBytes;

import java.util.HashMap;
import java.util.Map;

@Service
public class GetMyDataService {


    public GetMyDataResponse getMyData(GetMyDataRequest request) {
        String userId = "1234"; // need to figure out how to get this from the token
        String accessKeyId = "AKIAWBKIEPYFPAIMBUOW";
        String secretAccessKey = "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";
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
        Region region = Region.AP_SOUTHEAST_2;

        // Create the DynamoDbClient with credentials and region
        DynamoDbClient dynamoDbClient = DynamoDbClient.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .region(region)
                .build();

        // Prepare the key to query
        Map<String, AttributeValue> key = new HashMap<>();
        key.put("key", AttributeValue.builder().s(userId).build());

        // Create the GetItemRequest to query the DynamoDB table
        String tableName = "database";
        GetItemRequest getItemRequest = GetItemRequest.builder()
                .tableName(tableName)
                .key(key)
                .build();

        // Query DynamoDB
        GetItemResponse getItemResponse = dynamoDbClient.getItem(getItemRequest);

        // Check if the item exists
        if (!getItemResponse.hasItem() || getItemResponse.item().isEmpty()) {
            return GetMyDataResponse.newBuilder().build();  // Return an empty response if no data is found
        }

        // Deserialize the FriendsList attribute into a list of Friend objects
        SdkBytes friendsListBytes = getItemResponse.item().get("FriendsList").b();
        byte[] serializedFriendsList = friendsListBytes.asByteArray();
        GetMyDataResponse response = null;
        try {
            response = GetMyDataResponse.parseFrom(serializedFriendsList);
        } catch (InvalidProtocolBufferException e) {
            throw new RuntimeException(e);
        }

        return response;
    }


}
