package com.capstone.group41.remind.mate.service;

import org.springframework.stereotype.Service;
import remind.mate.grpc.Friend;
import remind.mate.grpc.FriendReminders;
import remind.mate.grpc.UpdateMyDataRequest;
import remind.mate.grpc.UpdateMyDataResponse;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.PutItemRequest;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;

import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UpdateMyDataService {
    private DynamoDbClient dynamoDbClient;
    private final String accessKeyId = "AKIAWBKIEPYFPAIMBUOW";
    private final String secretAccessKey = "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";
    private final Region region = Region.AP_SOUTHEAST_2;
    private final String tableName = "table";
    private final String partitionKeyName = "key";
    public UpdateMyDataResponse updateMyData(UpdateMyDataRequest request) {

        String userId = "1234"; // You should retrieve the userId from the context (e.g., JWT token)
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);

        // Create the DynamoDbClient with credentials and region
        dynamoDbClient = DynamoDbClient.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .region(region)
                .build();

        // Convert friends list to a DynamoDB attribute
        Map<String, AttributeValue> itemValues = new HashMap<>();
        itemValues.put("key", AttributeValue.builder().s(userId).build());
/*        itemValues.put("FriendsList", AttributeValue.builder().s(serializeFriends(request.getFriendsList())).build());*/
        byte[] serializedUserList = request.toByteArray();
        SdkBytes sdkBytes = SdkBytes.fromByteArray(serializedUserList);
        itemValues.put("FriendsList", AttributeValue.builder().b(sdkBytes).build());
        // Create a PutItemRequest to store data
        PutItemRequest putItemRequest = PutItemRequest.builder()
                .tableName("database")
                .item(itemValues)
                .build();

        dynamoDbClient.putItem(putItemRequest);

        return UpdateMyDataResponse.newBuilder().build();
    }
/*    // Helper function to serialize friends list into a JSON-like structure
    private String serializeFriends(List<Friend> friends) {
        StringBuilder serializedFriends = new StringBuilder("[");
        for (Friend friend : friends) {
            serializedFriends.append("{")
                    .append("\"name\":\"").append(friend.getName()).append("\",")
                    .append("\"email\":\"").append(friend.getEmail()).append("\",")
                    .append("\"phone\":\"").append(friend.getPhone()).append("\",")
                    .append("\"relationship\":\"").append(friend.getRelationship()).append("\",")
                    .append("\"timezone\":\"").append(friend.getTimezone()).append("\",")
                    .append("\"birthday\":\"").append(friend.getBirthday()).append("\",")
                    .append("\"notes\":\"").append(friend.getNotes()).append("\",")
                    .append("\"reminders\":").append(serializeReminders(friend.getRemindersList()))
                    .append("},");
        }
        if (friends.size() > 0) {
            serializedFriends.deleteCharAt(serializedFriends.length() - 1); // Remove last comma
        }
        serializedFriends.append("]");
        return serializedFriends.toString();
    }

    // Helper function to serialize reminders
    private String serializeReminders(List<FriendReminders> reminders) {
        StringBuilder serializedReminders = new StringBuilder("[");
        for (FriendReminders reminder : reminders) {
            serializedReminders.append("{")
                    .append("\"title\":\"").append(reminder.getTitle()).append("\",")
                    .append("\"startDateTime\":\"").append(reminder.getStartDateTime()).append("\",")
                    .append("\"endDateTime\":\"").append(reminder.getEndDateTime()).append("\",")
                    .append("\"showTime\":").append(reminder.getShowTime()).append(",")
                    .append("\"reminderType\":\"").append(reminder.getReminderType()).append("\"")
                    .append("},");
        }
        if (reminders.size() > 0) {
            serializedReminders.deleteCharAt(serializedReminders.length() - 1); // Remove last comma
        }
        serializedReminders.append("]");
        return serializedReminders.toString();
    }*/
}
