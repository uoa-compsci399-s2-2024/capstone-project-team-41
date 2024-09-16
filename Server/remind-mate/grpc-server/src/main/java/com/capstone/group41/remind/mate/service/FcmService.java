package com.capstone.group41.remind.mate.service;

import com.auth0.jwt.JWT;
import com.google.firebase.messaging.FirebaseMessagingException;
import io.grpc.Context;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.FirebaseMessaging;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.DeleteItemRequest;
import software.amazon.awssdk.services.dynamodb.model.QueryRequest;
import software.amazon.awssdk.services.dynamodb.model.QueryResponse;

import java.time.Instant;
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
            String notificationId = item.get("notificationid").s();
            String name = item.get("name").s();
            String messageBody = item.get("message").s();
            List<String> fcmDevices = item.get("fcmDevices").ss();

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
            // After sending the notification, delete it from the DynamoDB table
            DeleteItemRequest deleteRequest = DeleteItemRequest.builder()
                    .tableName("pending-notifications")
                    .key(Map.of("notificationid", AttributeValue.builder().s(notificationId).build()))
                    .build();

            dynamoDbClient.deleteItem(deleteRequest);
        }
    }
}
