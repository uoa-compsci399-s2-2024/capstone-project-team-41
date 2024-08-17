import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCardType.dart';
import 'package:RemindMate/Features/Home/Views/ReminderCard.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: (Center(
        child: ReminderCard(
            uio: UIOReminderCard(
                cardType: UIOReminderCardType.calender,
                title: "Mother's Day",
                dateTime: DateTime.now(),
                showTime: false,
                friends: [])),
      )),
    ));
  }
}
