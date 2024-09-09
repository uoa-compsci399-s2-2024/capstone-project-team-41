package com.capstone.group41.remind.mate.service;

import com.capstone.group41.remind.mate.models.entities.PendingNotification;
import org.springframework.stereotype.Service;
import remind.mate.grpc.*;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import java.util.List;

@Service
public class FcmService {

    public void sendReminderNotification(PendingNotification notification) {
        // construct fcm message
        // send fcm request
        // make HTTP call to FCM API with message & headers
    }
}
