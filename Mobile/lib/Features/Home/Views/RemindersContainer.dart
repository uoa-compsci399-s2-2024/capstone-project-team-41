import 'package:RemindMate/Features/Home/Views/ReminderCard.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:flutter/material.dart';

class ReminderContainer extends StatelessWidget {
  final UIOReminderCard carduio;

  const ReminderContainer({super.key, required this.carduio});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context, 
      removeTop: true,
      child: Scrollbar(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => ReminderCard(uio: carduio),
          separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.only(bottom: 10)),
        ),
      )
    );
  }
}