package com.capstone.group41.remind.mate.service;

import com.auth0.jwt.JWT;
import com.google.protobuf.InvalidProtocolBufferException;
import io.grpc.Context;
import org.springframework.stereotype.Service;
import remind.mate.grpc.Friend;
import remind.mate.grpc.FriendReminders;
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

import java.time.Instant;
import java.util.*;

@Service
public class GetMyDataService {


    public GetMyDataResponse getMyData(GetMyDataRequest request) {
        Context.Key<String> TOKEN_KEY = Context.key("userId");
        String token = TOKEN_KEY.get();
        String userId = JWT.decode(token).getSubject();
        String accessKeyId = "AKIAWBKIEPYFPAIMBUOW";
        String secretAccessKey = "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";
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
        Region region = Region.AP_SOUTHEAST_2;

        // create dynamodb
        DynamoDbClient dynamoDbClient = DynamoDbClient.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .region(region)
                .build();

        Map<String, AttributeValue> key = new HashMap<>();
        key.put("key", AttributeValue.builder().s(userId).build());

        String tableName = "database";
        GetItemRequest getItemRequest = GetItemRequest.builder()
                .tableName(tableName)
                .key(key)
                .build();


        GetItemResponse getItemResponse = dynamoDbClient.getItem(getItemRequest);

        if (!getItemResponse.hasItem() || getItemResponse.item().isEmpty()) {
            return GetMyDataResponse.newBuilder().build();  // returns empty if it doesn't exist
        }

        // deserialize the binary string into our response
        SdkBytes friendsListBytes = getItemResponse.item().get("FriendsList").b();
        byte[] serializedFriendsList = friendsListBytes.asByteArray();
        GetMyDataResponse response = null;
        try {
            response = GetMyDataResponse.parseFrom(serializedFriendsList);
        } catch (InvalidProtocolBufferException e) {
            throw new RuntimeException(e);
        }
        return cleanReminders(response);
    }

    public static GetMyDataResponse cleanReminders(GetMyDataResponse response) {
        long currentEpochSeconds = Instant.now().getEpochSecond();
        for (Friend friend : response.getFriendsList()) {
            List<FriendReminders> modifiableReminders = new ArrayList<>(friend.getRemindersList());
            modifiableReminders.removeIf(reminder -> currentEpochSeconds > reminder.getEndDateTime());
            friend = friend.toBuilder().clearReminders().addAllReminders(modifiableReminders).build();
        }
        return response;
    }


}
