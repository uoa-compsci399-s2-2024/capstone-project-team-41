package com.capstone.group41.remind.mate;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class RemindMateApplicationTests {

    @Test
    void contextLoads() {
    }

}

@Test
void testFriend() {
    // Create a Friend object
    Friend friend = Friend.newBuilder()
            .setName("John Doe")
            .setEmail("john@example.com")
            .setPhone("123-456-7890")
            .setRelationship(RelationshipType.FRIEND)
            .setTimezone("America/New_York")
            .setBirthday("1990-01-01")
            .setNotes("Best friend from college")
            .build();

    // Assert the fields are correctly set
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
    // Create a FriendReminders object
    FriendReminders reminder = FriendReminders.newBuilder()
            .setTitle("Meeting with Sarah")
            .setStartDateTime(1633036800L) // Example Unix timestamp
            .setEndDateTime(1633040400L)
            .setShowTime(true)
            .setReminderType(ReminderType.EVENT)
            .setReminderId("abc123")
            .setRecurringReminder(true)
            .setIntervalUnit("days")
            .setInterval(7L)
            .build();

    // Assert the fields are correctly set
    assertEquals("Meeting with Sarah", reminder.getTitle());
    assertEquals(1633036800L, reminder.getStartDateTime());
    assertEquals(1633040400L, reminder.getEndDateTime());
    assertTrue(reminder.getShowTime());
    assertEquals(ReminderType.EVENT, reminder.getReminderType());
    assertEquals("abc123", reminder.getReminderId());
    assertTrue(reminder.getRecurringReminder());
    assertEquals("days", reminder.getIntervalUnit());
    assertEquals(7L, reminder.getInterval());
}