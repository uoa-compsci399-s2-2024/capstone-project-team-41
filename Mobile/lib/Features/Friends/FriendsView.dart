import 'package:RemindMate/Features/Friends/Models/UIOContactsCardType.dart';
import 'package:flutter/material.dart';
import 'package:RemindMate/Features/Friends/Models/UIOContactsCard.dart';
import 'package:RemindMate/Features/Friends/Views/ContactsCard.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({super.key});

  @override
  State<FriendsView> createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {

  // Sample data for demonstration
  List<UIOContactsCard> friendsList = [
    UIOContactsCard(
      cardType: UIOContactsCardType.calender,
      title: "Jack Bond",
      dateTime: DateTime(1990, 5, 15),
      showTime: false,
      friends: const []
    ),
    UIOContactsCard(
      cardType: UIOContactsCardType.calender,
      title: "Louis Bark",
      dateTime: DateTime(1985, 7, 20),
      showTime: false,
      friends: const []
    ),
    UIOContactsCard(
      cardType: UIOContactsCardType.calender,
      title: "Mary Evans",
      dateTime: DateTime(1992, 8, 10),
      showTime: false,
      friends: const []
    ), 
  ];

  @override
  Widget build(BuildContext context) {
    final groupedFriends = _groupFriendsByInitial(friendsList);
    final sortedKeys = groupedFriends.keys.toList()..sort();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Contacts',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      //put add friend and sort button here
                    ]
                  ),
                ],
              ),
            ),
            
            // Contacts list
            Expanded(
              child: ListView(
                children: sortedKeys.map((initial) {
                  final friendsList = groupedFriends[initial]!;



            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    initial,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),Divider(thickness: 5, color: ColorPalette.primaryPink),
                ...friendsList.map((friend) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ContactsCard(uio: friend),
                )),
                
              ],
            );
          }).toList(),
        ),
      ),
    ])
    )
    );
  }

  Map<String, List<UIOContactsCard>> _groupFriendsByInitial(List<UIOContactsCard> friends) {
    final Map<String, List<UIOContactsCard>> grouped = {};

    for (var friend in friends) {
      final initial = friend.title.isNotEmpty ? friend.title[0].toUpperCase() : '#';
      if (!grouped.containsKey(initial)) {
        grouped[initial] = [];
      }
      grouped[initial]!.add(friend);
    }
    
    return grouped;
  }
}
