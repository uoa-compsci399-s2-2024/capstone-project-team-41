import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCardType.dart';
import 'package:RemindMate/Features/Home/Views/HomeNavButton.dart';
import 'package:RemindMate/Features/Home/Views/RemindersContainer.dart';
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
    friends: const []
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 0, left: 32, right: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeNavButton(),
                  Row(
                    children: [
                      Expanded(child: HomeNavButton(),),
                      Expanded(child: HomeNavButton(),),
                    ],
                  )
                ],
              )
            ),
            Flexible(
              child: ReminderContainer(carduio: sampleUIO,)
            )
          ],
        )
      ),
    );
  }
}
