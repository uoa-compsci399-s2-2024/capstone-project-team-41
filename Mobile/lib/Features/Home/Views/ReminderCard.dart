import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/Images.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';


class ReminderCard extends StatelessWidget {
  final UIOReminderCard uio;

  const ReminderCard({super.key, required this.uio});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: ColorPalette.primaryGreen,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                  color: ColorPalette.primaryPink,
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Icon(Icons.calendar_today, color: Colors.white, size: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(uio.title, style: Textstyles.boldSmall,),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorPalette.secondaryGreen,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Text(uio.getStartDateTimeAsString("dd MMM"), style: Textstyles.smallDate,)
                    ),
                    const Padding(padding: EdgeInsets.only(right:6)),
                    const Text("at", style: Textstyles.smallDate),
                    const Padding(padding: EdgeInsets.only(right:6)),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorPalette.secondaryGreen,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Text(uio.getStartDateTimeAsString("HH:mm"), style: Textstyles.smallDate,)
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
