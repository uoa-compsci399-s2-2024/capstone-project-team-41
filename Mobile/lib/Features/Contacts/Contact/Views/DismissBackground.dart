import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';

class Dismissbackground extends StatelessWidget {

  const Dismissbackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 10),
      child: const Text("Delete\nReminder", style: Textstyles.boldSmall,)
    );
  }

}