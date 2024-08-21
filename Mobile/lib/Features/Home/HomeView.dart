import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCardType.dart';
import 'package:RemindMate/Features/Home/Views/HomeNavContainer.dart';
import 'package:RemindMate/Features/Home/Views/RemindersContainer.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final UIOReminderCard sampleUIO = UIOReminderCard(
      cardType: UIOReminderCardType.calender,
      title: "Mother's Day",
      dateTime: DateTime.now(),
      showTime: false,
      friends: const []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding:
              const EdgeInsets.only(top: 300, bottom: 120, left: 20, right: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: const HomeNavContainer(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 15),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weekly Reminders",
                          style: Textstyles.P1,
                        ),
                        Text("Your upcoming Reminders", style: Textstyles.S1)
                      ],
                    )),
              ),
              Flexible(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ReminderContainer(
                        carduio: sampleUIO,
                      ))),
            ],
          )),
    );
  }
}
