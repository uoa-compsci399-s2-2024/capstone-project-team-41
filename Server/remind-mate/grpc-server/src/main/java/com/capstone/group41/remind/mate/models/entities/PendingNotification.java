package com.capstone.group41.remind.mate.models.entities;

import com.google.type.DateTime;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.List;

@Document(collection = "pendingNotifications")
public class PendingNotification {
    @Id
    @Getter @Setter
    private String id;

    @Getter  @Setter
    private String userId;

    @Getter @Setter
    private List<String> deviceTokens;

    @Getter @Setter
    private List<String> friendNames;

    @Getter @Setter
    private DateTime scheduledTime;

    @Getter @Setter
    private String message;

    @Getter @Setter
    private boolean recurringReminder;

    @Getter @Setter
    private Reminder.IntervalUnit intervalUnit;

    // Enum for the interval unit
    public enum IntervalUnit {
        DAYS,
        WEEKS,
        MONTHS
    }

}
