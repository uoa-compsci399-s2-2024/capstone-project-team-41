package com.capstone.group41.remind.mate.service;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.GetItemRequest;
import software.amazon.awssdk.services.dynamodb.model.GetItemResponse;
import software.amazon.awssdk.services.dynamodb.model.DynamoDbException;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;

import java.util.HashMap;
import java.util.Map;

public class DynamoDBHelper {

    private final DynamoDbClient dynamoDbClient;
    private final String accessKeyId = "AKIAWBKIEPYFPAIMBUOW";
    private final String secretAccessKey = "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";
    private final Region region = Region.AP_SOUTHEAST_2;
    private final String tableName = "table";
    private final String partitionKeyName = "key";

    public DynamoDBHelper() {
        // Create the AWS credentials
        AwsBasicCredentials awsCreds = AwsBasicCredentials.create(accessKeyId, secretAccessKey);

        // Create the DynamoDbClient with credentials and region
        this.dynamoDbClient = DynamoDbClient.builder()
                .credentialsProvider(StaticCredentialsProvider.create(awsCreds))
                .region(region)
                .build();
    }

    public Map<String, AttributeValue> getItemByPartitionKey(String partitionKeyValue) {
        // Create a map with the key condition
        Map<String, AttributeValue> keyToGet = new HashMap<>();
        keyToGet.put(partitionKeyName, AttributeValue.builder().s(partitionKeyValue).build());

        GetItemRequest request = GetItemRequest.builder()
                .tableName(tableName)
                .key(keyToGet)
                .build();

        try {
            GetItemResponse response = dynamoDbClient.getItem(request);
            if (response.hasItem()) {
                return response.item();
            } else {
                System.out.println("No item found with the partition key: " + partitionKeyValue);
                return null;
            }
        } catch (DynamoDbException e) {
            System.err.println(e.getMessage());
            return null;
        }
    }
}
