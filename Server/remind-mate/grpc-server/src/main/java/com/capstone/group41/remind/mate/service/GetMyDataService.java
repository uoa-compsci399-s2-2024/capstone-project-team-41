package com.capstone.group41.remind.mate.service;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import org.springframework.stereotype.Service;
import remind.mate.grpc.*;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Service
public class GetMyDataService {

    private static final String CONNECTION_STRING = "mongodb://houseTargaryen:h0useTargaryen@docdb-2024-08-19-02-29-402.ci7bv0oxri6k.ap-southeast-2.docdb.amazonaws.com:27017/?tls=true&tlsCAFile=global-bundle.pem&retryWrites=false";
    private static final String DATABASE_NAME = "MyDatabase";
    private static final String COLLECTION_NAME = "friends";

    public GetMyDataResponse getMyData(GetMyDataRequest request) {
        List<Friend> friends = new ArrayList<>();

        try (MongoClient mongoClient = MongoClients.create(CONNECTION_STRING)) {
            MongoDatabase database = mongoClient.getDatabase(DATABASE_NAME);
            MongoCollection<Document> collection = database.getCollection(COLLECTION_NAME);

            for (Document doc : collection.find()) {
                Friend friend = buildFriendFromDocument(doc);
                friends.add(friend);
            }
        }

        return GetMyDataResponse.newBuilder()
                .addAllFriends(friends)
                .build();
    }

    private Friend buildFriendFromDocument(Document doc) {
        return Friend.newBuilder()
                .setName(doc.getString("name"))
                .setEmail(doc.getString("email"))
                .setPhone(doc.getString("phone"))
                .setRelationship(RelationshipType.valueOf(doc.getString("relationship")))
                .setTimezone(doc.getString("timezone"))
                .setBirthday(doc.getString("birthday"))
                .setNotes(doc.getString("notes"))
                .addAllReminders(buildRemindersFromDocument(doc))
                .build();
    }

    private List<FriendReminders> buildRemindersFromDocument(Document doc) {
        List<Document> remindersDocs = (List<Document>) doc.get("reminders");
        List<FriendReminders> reminders = new ArrayList<>();

        long currentTime = Instant.now().toEpochMilli(); // Get current time in milliseconds

        for (Document reminderDoc : remindersDocs) {
            long endDateTime = reminderDoc.getLong("endDateTime");
            if (endDateTime > currentTime) { // Only include reminders where the endDateTime is in the future
                FriendReminders reminder = FriendReminders.newBuilder()
                        .setTitle(reminderDoc.getString("title"))
                        .setStartDateTime(reminderDoc.getLong("startDateTime"))
                        .setEndDateTime(endDateTime)
                        .setShowTime(reminderDoc.getBoolean("showTime"))
                        .setReminderType(ReminderType.valueOf(reminderDoc.getString("reminderType")))
                        .build();
                reminders.add(reminder);
            }
        }

        return reminders;
    }
}