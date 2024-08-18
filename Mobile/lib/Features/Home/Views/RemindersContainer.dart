import 'package:RemindMate/Features/Home/Views/ReminderCard.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:flutter/material.dart';

class ReminderContainer extends StatelessWidget {
  final UIOReminderCard carduio;

  const ReminderContainer({super.key, required this.carduio});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) => ReminderCard(uio: carduio),
      separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.only(bottom: 10)),
    );
  }
}