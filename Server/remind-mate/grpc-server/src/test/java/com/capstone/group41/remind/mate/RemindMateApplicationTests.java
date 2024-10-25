package com.capstone.group41.remind.mate;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.*;
import remind.mate.grpc.Friend;
import remind.mate.grpc.FriendReminders;
import remind.mate.grpc.RelationshipType;
import remind.mate.grpc.ReminderType;

@SpringBootTest
class RemindMateApplicationTests {

    @Test
    void contextLoads() {
    }
}

class FriendAndReminderTests {

    @Test
    void testFriend() {
        Friend friend = Friend.newBuilder()
                .setName("John Doe")
                .setEmail("john@example.com")
                .setPhone("123-456-7890")
                .setRelationship(RelationshipType.FRIEND)
                .setTimezone("America/New_York")
                .setBirthday("1990-01-01")
                .setNotes("Best friend from college")
                .build();

        assertEquals("John Doe", friend.getName());
        assertEquals("john@example.com", friend.getEmail());
        assertEquals("123-456-7890", friend.getPhone());
        assertEquals(RelationshipType.FRIEND, friend.getRelationship());
        assertEquals("America/New_York", friend.getTimezone());
        assertEquals("1990-01-01", friend.getBirthday());
        assertEquals("Best friend from college", friend.getNotes());
    }

    @Test
    void testFriendReminders() {
        FriendReminders reminder = FriendReminders.newBuilder()
                .setTitle("Meeting with Sarah")
                .setStartDateTime(String.valueOf(1633036800L)) // Example Unix timestamp
                .setEndDateTime(String.valueOf(1633040400L))
                .setShowTime(true)
                .setReminderType(ReminderType.EVENT)
                .setReminderId("abc123")
                .setRecurringReminder(true)
                .setIntervalUnit("days")
                .setInterval(7L)
                .build();

        assertEquals("Meeting with Sarah", reminder.getTitle());
        assertEquals(String.valueOf(1633036800L), reminder.getStartDateTime());
        assertEquals(String.valueOf(1633040400L), reminder.getEndDateTime());
        assertTrue(reminder.getShowTime());
        assertEquals(ReminderType.EVENT, reminder.getReminderType());
        assertEquals("abc123", reminder.getReminderId());
        assertTrue(reminder.getRecurringReminder());
        assertEquals("days", reminder.getIntervalUnit());
        assertEquals(7L, reminder.getInterval());
    }
}
