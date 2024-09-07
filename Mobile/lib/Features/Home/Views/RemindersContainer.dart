import 'package:RemindMate/Features/Home/Views/ReminderCard.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:flutter/material.dart';

class ReminderContainer extends StatelessWidget {
  final List<UIOReminderCard> uios;

  const ReminderContainer({super.key, required this.uios});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context, 
      removeTop: true,
      child: Scrollbar(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          itemCount: uios.length,
          itemBuilder: (BuildContext context, int index) => ReminderCard(uio: uios[index]),
          separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.only(bottom: 10)),
        ),
      )
    );
  }
}