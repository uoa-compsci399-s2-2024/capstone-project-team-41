import 'dart:async';

import 'package:RemindMate/Domain/Database/DatabaseConnector.dart';
import 'package:RemindMate/Domain/Database/Models/Contact.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class ContactsViewModel extends ChangeNotifier {
  List<UIOContact> contacts = [];

  ContactsViewModel() {
    lockPopulate();
    watchChanges();
  }

  void watchChanges() {
    final database = DatabaseConnector.instance.isar;
    Stream<void> contactsChanged = database.contacts.watchLazy();
    contactsChanged.listen((contacts) {
      lockPopulate();
    });
  }

  Future<void>? _currentTask;

  Future<void> lockPopulate() {
    if (_currentTask != null) {
      return _currentTask!;
    }

    _currentTask = populateFromDatabase();

    return _currentTask!.whenComplete(() {
      _currentTask = null;
    }
    );
  }

  Future<void>? populateFromDatabase() async {
    contacts = [];

    final database = DatabaseConnector.instance.isar;
    var dbContacts = await database.contacts.where().findAll();
    for (final contact in dbContacts) {
      contacts.add(UIOContact(contact));
    }
    notifyListeners();
  }

  Map<String, List<UIOContact>> contactMap() {
    var contactMap = <String, List<UIOContact>>{};

    for (var contact in contacts) {
      if (!contactMap.containsKey(contact.name.substring(0, 1).toUpperCase())) {
        contactMap[contact.name.substring(0, 1).toUpperCase()] = [];
      }

      contactMap[contact.name.substring(0, 1).toUpperCase()]?.add(contact);
    }

    return contactMap;
  }

  List<String> sortedContactMapKeys() {
    var keyList = contactMap().keys.toList();
    keyList.sort();
    return keyList;
  }
}
