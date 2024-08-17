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
  
  // TEMPORARY
  UIOReminderCard cardBuilder(String title) {
      return UIOReminderCard(
      cardType: UIOReminderCardType.calender,
      title: title,
      dateTime: DateTime.now(),
      showTime: false,
      friends: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReminderCard(uio: cardBuilder("Mother's Day")),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                    ReminderCard(uio: cardBuilder("Tom's Birthday")),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                    ReminderCard(uio: cardBuilder("Nana's Funeral :(")),
                    const Padding(padding: EdgeInsets.only(bottom: 20)),
                ],)
              ),]
          )
        ),
    );
  }
}
