package com.capstone.group41.remind.mate.service;

import remind.mate.grpc.*;
import org.springframework.stereotype.Service;

import remind.mate.grpc.*;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import java.util.List;

@Service
public class UserService {

    private static final String CONNECTION_STRING = "mongodb://houseTargaryen:h0useTargaryen@docdb-2024-08-19-02-29-402.ci7bv0oxri6k.ap-southeast-2.docdb.amazonaws.com:27017/?tls=true&tlsCAFile=global-bundle.pem&retryWrites=false";
    private static final String DATABASE_NAME = "MyDatabase";
    private static final String COLLECTION_NAME = "users";

    public AddFcmTokenResponse AddFcmToken(AddFcmTokenRequest request) {
        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

            String userId = request.getUserId();
            Document user = collection.find(new Document("userId", userId)).first();

            if (user != null) {
                List<String> fcmTokens = (List<String>) user.get("fcmTokens");
                if (!fcmTokens.contains(request.getFcmToken())) {
                    fcmTokens.add(request.getFcmToken());
                    collection.updateOne(
                            new Document("userId", userId),
                            new Document("$set", new Document("fcmTokens", fcmTokens))
                    );
                }
                return AddFcmTokenResponse.newBuilder()
                        .setSuccess(true)
                        .build();
            } else {
                // user doesn't exist, this clause shouldn't be taken
                return AddFcmTokenResponse.newBuilder()
                        .setSuccess(false)
                        .build();
            }
        }
    }
}
