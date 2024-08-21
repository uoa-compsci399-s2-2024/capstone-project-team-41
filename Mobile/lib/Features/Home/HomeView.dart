import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCardType.dart';
import 'package:RemindMate/Features/Home/Views/HomeNavContainer.dart';
import 'package:RemindMate/Features/Home/Views/RemindersContainer.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    friends: const []
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 150, bottom: 0, left: 20, right: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 20),
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Good Morning,", style: Textstyles.header1),
                    const Text("Tori!", style: Textstyles.header1Bold),
                    Container(
                      width: 220,
                      padding: const EdgeInsets.only(bottom: 20, left: 5),
                      child: RichText(
                        text: const TextSpan(
                          style: Textstyles.P2,
                          children: [
                            TextSpan(
                              text: "You have ",
                            ),
                            TextSpan(
                              style: Textstyles.P2orange,
                              text: "4 upcoming events",
                            ),
                            TextSpan(
                              text: " this week",
                            ),
                          ],
                        ),
                      )
                    )
                  ],
                )
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: HomeNavContainer(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 15),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Weekly Reminders", style: Textstyles.P1,),
                    Text("Your upcoming Reminders", style: Textstyles.S1)
                  ],
                )
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ReminderContainer(carduio: sampleUIO,)
              ) 
            )
          ],
        )
      ),
    );
  }
}
