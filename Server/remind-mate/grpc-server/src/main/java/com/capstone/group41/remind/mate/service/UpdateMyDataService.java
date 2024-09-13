package com.capstone.group41.remind.mate.service;

import com.auth0.jwt.JWT;
import io.grpc.Context;
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

        return UpdateMyDataResponse.newBuilder().build();
    }
}
