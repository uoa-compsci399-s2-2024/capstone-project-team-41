package com.capstone.group41.remind.mate.service;

import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.protobuf.InvalidProtocolBufferException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.FirebaseMessaging;
import remind.mate.grpc.GetMyDataResponse;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;
import remind.mate.grpc.*;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FcmService {

    @Scheduled(fixedRate = 60000)
    public void sendReminderNotification(String message, List<String> fcmTokens) {

        String accessKeyId = "AKIAWBKIEPYFPAIMBUOW";
        String secretAccessKey = "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";
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
        Region region = Region.AP_SOUTHEAST_2;

        DynamoDbClient dynamoDbClient = DynamoDbClient.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .region(region)
                .build();

        long currentEpochTime = Instant.now().getEpochSecond();

        Map<String, String> expressionAttributesNames = new HashMap<>();
        expressionAttributesNames.put("#endDateTime", "endDateTime");

        Map<String, AttributeValue> expressionAttributeValues = new HashMap<>();
        expressionAttributeValues.put(":currentEpoch", AttributeValue.builder().n(Long.toString(currentEpochTime)).build());

        QueryRequest queryRequest = QueryRequest.builder()
                .tableName("pending-notifications")
                .keyConditionExpression("#endDateTime < :currentEpoch")
                .expressionAttributeNames(expressionAttributesNames)
                .expressionAttributeValues(expressionAttributeValues)
                .build();

        QueryResponse queryResponse = dynamoDbClient.query(queryRequest);

        List<Map<String, AttributeValue>> items = queryResponse.items();

        for (Map<String, AttributeValue> item : items) {
            String reminderId = item.get("reminderId").s();
            String name = item.get("name").s();
            String messageBody = item.get("message").s();
            List<String> fcmDevices = item.get("fcmDevices").ss();
            long startDateTime = Long.parseLong(item.get("startDateTime").n());
            long endDateTime = Long.parseLong(item.get("endDateTime").n());
            boolean recurringReminder = item.get("recurringReminder").bool();
            int interval = Integer.parseInt(item.get("interval").n());
            String intervalUnit = item.get("intervalUnit").s();
            String userId = item.get("userId").s();

            for (String fcmtoken : fcmDevices) {
                Message notification = Message.builder()
                        .setToken(fcmtoken)
                        .putData("title", name)
                        .putData("body", messageBody)
                        .build();

                try {
                    String response = FirebaseMessaging.getInstance().send(notification);
                } catch (FirebaseMessagingException e) {
                }
            }

            if (recurringReminder) {
                // Calculate new startDateTime and endDateTime based on the intervalUnit
                LocalDateTime startLocalDateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(startDateTime), ZoneOffset.UTC);
                LocalDateTime endLocalDateTime = LocalDateTime.ofInstant(Instant.ofEpochSecond(endDateTime), ZoneOffset.UTC);

                switch (intervalUnit.toLowerCase()) {
                    case "days":
                        startLocalDateTime = startLocalDateTime.plusDays(interval);
                        endLocalDateTime = endLocalDateTime.plusDays(interval);
                        break;
                    case "weeks":
                        startLocalDateTime = startLocalDateTime.plusWeeks(interval);
                        endLocalDateTime = endLocalDateTime.plusWeeks(interval);
                        break;
                    case "months":
                        startLocalDateTime = startLocalDateTime.plusMonths(interval);
                        endLocalDateTime = endLocalDateTime.plusMonths(interval);
                        break;
                    default:
                        throw new IllegalArgumentException("Unsupported interval unit: " + intervalUnit + ". Use 'days', 'weeks' or 'months'.");
                }

                long newStartDateTime = startLocalDateTime.toEpochSecond(ZoneOffset.UTC);
                long newEndDateTime = endLocalDateTime.toEpochSecond(ZoneOffset.UTC);


                // Update the reminder in pending-notifications with new times
                Map<String, AttributeValue> key = new HashMap<>();
                key.put("reminderId", AttributeValue.builder().s(reminderId).build());

                Map<String, AttributeValueUpdate> updatedDateTimes = new HashMap<>();
                updatedDateTimes.put("startDateTime", AttributeValueUpdate.builder()
                        .value(AttributeValue.builder().n(Long.toString(newStartDateTime)).build())
                        .action(AttributeAction.PUT)
                        .build());
                updatedDateTimes.put("endDateTime", AttributeValueUpdate.builder()
                        .value(AttributeValue.builder().n(Long.toString(newEndDateTime)).build())
                        .action(AttributeAction.PUT)
                        .build());

                UpdateItemRequest notificationUpdateRequest = UpdateItemRequest.builder()
                        .tableName("pending-notifications")
                        .key(key)
                        .attributeUpdates(updatedDateTimes)
                        .build();
                dynamoDbClient.updateItem(notificationUpdateRequest);

                // update MyData user data
                Map<String, AttributeValue> databaseKey = new HashMap<>();
                databaseKey.put("key", AttributeValue.builder().s(userId).build());

                String tableName = "database";
                GetItemRequest getItemRequest = GetItemRequest.builder()
                        .tableName(tableName)
                        .key(databaseKey)
                        .build();

                GetItemResponse getItemResponse = dynamoDbClient.getItem(getItemRequest);

                if (getItemResponse.hasItem()) {
                    SdkBytes friendsListBytes = getItemResponse.item().get("FriendsList").b();
                    byte[] serializedFriendsList = friendsListBytes.asByteArray();
                    GetMyDataResponse friendData = null; // shouldn't matter if type's Get-Response or Update-Request
                    try {
                        friendData = GetMyDataResponse.parseFrom(serializedFriendsList);
                    } catch (InvalidProtocolBufferException e) {
                        throw new RuntimeException(e);
                    }

                    for (Friend friend : friendData.getFriendsList()) {
                        for (FriendReminders reminder : friend.getRemindersList()) {
                            if (reminder.getReminderId().equals(reminderId)) {
                                reminder = reminder.toBuilder()
                                        .setStartDateTime(Long.toString(newStartDateTime))
                                        .setEndDateTime(Long.toString(newEndDateTime))
                                        .build();
                            }
                        }
                    }
                    SdkBytes updatedSdkBytes = SdkBytes.fromByteArray(friendData.toByteArray());

                    Map<String, AttributeValue> updatedItemValues = new HashMap<>();
                    updatedItemValues.put("key", AttributeValue.builder().s(userId).build());
                    updatedItemValues.put("FriendsList", AttributeValue.builder().b(updatedSdkBytes).build());

                    PutItemRequest putItemRequest = PutItemRequest.builder()
                            .tableName("database")
                            .item(updatedItemValues)
                            .build();

                    dynamoDbClient.putItem(putItemRequest);
                }

            } else {
                // delete reminder from the DynamoDB table
                DeleteItemRequest deleteRequest = DeleteItemRequest.builder()
                        .tableName("pending-notifications")
                        .key(Map.of("reminderId", AttributeValue.builder().s(reminderId).build()))
                        .build();

                dynamoDbClient.deleteItem(deleteRequest);
            }
        }
    }
}
