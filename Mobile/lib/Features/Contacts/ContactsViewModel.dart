import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContactType.dart';
import 'package:flutter/material.dart';

class ContactsViewModel extends ChangeNotifier {
  List<UIOContact> contacts = [];

  ContactsViewModel() {
    contacts.add(UIOContact(
        firstName: "Jack",
        lastName: "Bond",
        type: UIOContactType.friend,
        timeZone: "PDT",
        hasNewReminder: true));
  }

  Map<String, List<UIOContact>> contactMap() {
    var contactMap = <String, List<UIOContact>>{};

    for (var contact in contacts) {
      if (!contactMap
          .containsKey(contact.lastName.substring(0, 1).toUpperCase())) {
        contactMap[contact.lastName.substring(0, 1).toUpperCase()] = [];
      }

      contactMap[contact.lastName.substring(0, 1).toUpperCase()]?.add(contact);
    }

    return contactMap;
  }

  List<String> sortedContactMapKeys() {
    var keyList = contactMap().keys.toList();
    keyList.sort();
    return keyList;
  }
}
