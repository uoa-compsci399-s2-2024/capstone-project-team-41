package com.capstone.group41.remind.mate.service;

import com.auth0.jwt.JWT;
import io.grpc.Context;
import org.springframework.stereotype.Service;
import org.w3c.dom.Attr;
import remind.mate.grpc.Friend;
import remind.mate.grpc.FriendReminders;
import remind.mate.grpc.UpdateMyDataRequest;
import remind.mate.grpc.UpdateMyDataResponse;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.GetItemRequest;
import software.amazon.awssdk.services.dynamodb.model.GetItemResponse;
import software.amazon.awssdk.services.dynamodb.model.PutItemRequest;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;

import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UpdateMyDataService {
    private final Region region = Region.AP_SOUTHEAST_2;
    public UpdateMyDataResponse updateMyData(UpdateMyDataRequest request) {

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

        // serialize to byte arr
        byte[] serializedUserList = request.toByteArray();
        SdkBytes sdkBytes = SdkBytes.fromByteArray(serializedUserList);
        itemValues.put("FriendsList", AttributeValue.builder().b(sdkBytes).build());

        PutItemRequest putItemRequest = PutItemRequest.builder()
                .tableName("database")
                .item(itemValues)
                .build();

        dynamoDbClient.putItem(putItemRequest);
        Map<String, AttributeValue> newKey = new HashMap<>();
        newKey.put("userId", AttributeValue.builder().s(userId).build());
        GetItemRequest getRequest = GetItemRequest.builder()
                .tableName("pending-notifications")
                .key(newKey)
                .projectionExpression("fcmTokens") // Fetch only the 'title' field
                .build();
        GetItemResponse result = dynamoDbClient.getItem(getRequest);
        List<String> fcmTokens = result.item().get("fcmTokens").ss();
        syncDatabases(request, fcmTokens);

        return UpdateMyDataResponse.newBuilder().build();
    }

    private void syncDatabases(UpdateMyDataRequest request, List<String> fcmTokens) {
        String accessKeyId = "AKIAWBKIEPYFPAIMBUOW";
        String secretAccessKey = "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";
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
        DynamoDbClient dynamoDbClient = DynamoDbClient.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .region(region)
                .build();


        String pendingNotificationsTable = "pending-notifications";


        for (Friend friend : request.getFriendsList()) {
            for (FriendReminders reminder : friend.getRemindersList()) {
                String reminderId = reminder.getReminderId();

                // Check if the reminderId exists in pending-notifications table
                Map<String, AttributeValue> key = new HashMap<>();
                key.put("reminderId", AttributeValue.builder().s(reminderId).build());

                GetItemRequest getItemRequest = GetItemRequest.builder()
                        .tableName(pendingNotificationsTable)
                        .key(key)
                        .build();

                try {
                    GetItemResponse getItemResponse = dynamoDbClient.getItem(getItemRequest);

                    // If reminderId does not exist, add it
                    if (getItemResponse.item().isEmpty()) {
                        Map<String, AttributeValue> newItem = new HashMap<>();
                        newItem.put("reminderId", AttributeValue.builder().s(reminderId).build());
                        newItem.put("title", AttributeValue.builder().s(reminder.getTitle()).build());
                        newItem.put("startDateTime", AttributeValue.builder().n(Long.toString(reminder.getStartDateTime())).build());
                        newItem.put("endDateTime", AttributeValue.builder().n(Long.toString(reminder.getEndDateTime())).build());
                        newItem.put("showTime", AttributeValue.builder().bool(reminder.getShowTime()).build());
                        newItem.put("reminderType", AttributeValue.builder().s(reminder.getReminderType().toString()).build());
                        newItem.put("fcmTokens", AttributeValue.builder().ss(fcmTokens).build());

                        PutItemRequest putItemRequest = PutItemRequest.builder()
                                .tableName(pendingNotificationsTable)
                                .item(newItem)
                                .build();

                        dynamoDbClient.putItem(putItemRequest);
                    }
                } catch (Exception e) {

                }
            }
        }
    }

}
