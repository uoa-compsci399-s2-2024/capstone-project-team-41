package com.capstone.group41.remind.mate.models.entities;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.List;

@Document(collection = "reminders")
public class Reminder {
    @Id
    @Getter @Setter
    private String id;

    @Getter @Setter
    private List<String> contactIDs;

    @Getter @Setter
    private boolean recurringReminder;

    @Getter @Setter
    private LocalDateTime remindTime;

    @Getter @Setter
    private IntervalUnit intervalUnit;

    // Enum for the interval unit
    public enum IntervalUnit {
        DAYS,
        WEEKS,
        MONTHS
    }

    private String reminderNotes;
}
