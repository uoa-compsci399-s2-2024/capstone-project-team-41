package com.capstone.group41.remind.mate.service;

import com.google.firebase.messaging.FirebaseMessagingException;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.FirebaseMessaging;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FcmService {

    @Scheduled(fixedRate = 60000)
    public void sendReminderNotification() {

        String accessKeyId = "AKIAWBKIEPYFPAIMBUOW";
        String secretAccessKey = "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";
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
        Region region = Region.AP_SOUTHEAST_2;

        DynamoDbClient dynamoDbClient = DynamoDbClient.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .region(region)
                .build();

        long currentEpochTime = Instant.now().toEpochMilli();

        Map<String, AttributeValue> expressionAttributeValues = new HashMap<>();
        expressionAttributeValues.put(":currentEpoch", AttributeValue.builder().n(Long.toString(currentEpochTime)).build());

        ScanRequest scanRequest = ScanRequest.builder()
                .tableName("pending-notifications")
                .filterExpression("endDateTime < :currentEpoch")
                .expressionAttributeValues(expressionAttributeValues)
                .build();

        ScanResponse queryResponse = dynamoDbClient.scan(scanRequest);

        List<Map<String, AttributeValue>> items = queryResponse.items();

        for (Map<String, AttributeValue> item : items) {
            String notificationId = item.get("reminderId").s();
            String name = item.get("title").s();
            List<String> fcmDevices = item.get("fcmTokens").ss();

            for (String fcmtoken : fcmDevices) {
                Message notification = Message.builder()
                        .setToken(fcmtoken)
                        .putData("title", name)
                        .build();

                try {
                    String response = FirebaseMessaging.getInstance().send(notification);
                    response.equals("success");
                } catch (FirebaseMessagingException e) {
                }
            }

            DeleteItemRequest deleteRequest = DeleteItemRequest.builder()
                    .tableName("pending-notifications")
                    .key(Map.of("reminderId", AttributeValue.builder().s(notificationId).build()))
                    .build();

            dynamoDbClient.deleteItem(deleteRequest);
        }
    }
}
