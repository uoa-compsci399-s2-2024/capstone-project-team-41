package com.capstone.group41.remind.mate.service;

import com.capstone.group41.remind.mate.models.entities.PendingNotification;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import remind.mate.grpc.*;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import java.util.List;

@Service
public class NotificationService {
    // connect to db
    //

    // addReminderNotification

    // updateReminderNotification

    // deleteReminderNotification

    // IterateRecurringReminder

    // getPendingNotifications

    @Scheduled(fixedRate = 60000)
    public void sendDueReminders() {
        // syntax might need to change for gRPC (look at UserService)
        List<PendingNotification> pendingNotifications = // get pending reminders from db

        if (!pendingNotifications.isEmpty()) {
            for (PendingNotification pendingNotification : pendingNotifications) {
                fcmService.sendReminderNotification(pendingNotification);
                if (pendingNotification.isRecurringReminder())
                    // update from inside method if necessary
                    this.IterateRecurringReminder(pendingNotification);
                else {
                    // delete from inside method if necessary
                    this.deleteReminderNotification(pendingNotification);
                }

            }
        }
        //
    }
}
