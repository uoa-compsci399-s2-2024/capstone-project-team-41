package com.capstone.group41.remind.mate.service;

import org.springframework.stereotype.Service;
import remind.mate.grpc.*;

import java.util.List;

@Service
public class GetMyDataService {

    public GetMyDataResponse getMyData(GetMyDataRequest request) {
        return GetMyDataResponse.newBuilder()
                .addAllFriends(List.of(
                        Friend.newBuilder()
                                .setEmail("john.doe@example.com")
                                .setName("John Doe")
                                .setPhone("123-456-7890")
                                .setRelationship(RelationshipType.FRIEND)
                                .setTimezone("America/New_York")
                                .setBirthday("1990-01-15")
                                .setNotes("Met at college, loves hiking")
                                .addAllReminders(List.of(
                                        FriendReminders.newBuilder()
                                                .setTitle("John's Birthday Party")
                                                .setStartDateTime("2024-01-15T18:00:00")
                                                .setEndDateTime("2024-01-15T21:00:00")
                                                .setShowTime(true)
                                                .setReminderType(ReminderType.EVENT)
                                                .build()
                                ))
                                .build(),
                        Friend.newBuilder()
                                .setEmail("jane.smith@example.com")
                                .setName("Jane Smith")
                                .setPhone("987-654-3210")
                                .setRelationship(RelationshipType.FRIEND)
                                .setTimezone("Europe/London")
                                .setBirthday("1985-06-20")
                                .setNotes("Co-worker, enjoys reading")
                                .addAllReminders(List.of(
                                        FriendReminders.newBuilder()
                                                .setTitle("Book Club Meeting")
                                                .setStartDateTime("2024-08-01T19:00:00")
                                                .setEndDateTime("2024-08-01T20:30:00")
                                                .setShowTime(true)
                                                .setReminderType(ReminderType.EVENT)
                                                .build()
                                ))
                                .build()
                ))
                .build();

    }
}
