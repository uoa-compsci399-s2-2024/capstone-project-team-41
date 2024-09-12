package com.capstone.group41.remind.mate.service;

import com.google.firebase.messaging.FirebaseMessagingException;
import org.springframework.stereotype.Service;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.FirebaseMessaging;

import java.util.List;

@Service
public class FcmService {

    public void sendReminderNotification(String message, List<String> fcmTokens) {

        for (String token: fcmTokens) {
            Message notification = Message.builder()
                    .setToken(token)
                    .putData("title", "Reminder")
                    .putData("body", message)
                    .build();
            String response = null;
            try {
                response = FirebaseMessaging.getInstance().send(notification);
                // Response is a message ID string.
                System.out.println("Successfully sent message: " + response);
            } catch (FirebaseMessagingException e) {
                System.err.println("Error sending FCM message to token " + token + ": " + e.getMessage());
            }

        }


    }
}
