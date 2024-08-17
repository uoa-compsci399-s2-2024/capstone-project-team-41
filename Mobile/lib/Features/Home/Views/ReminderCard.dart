import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/Images.dart';
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
              child: Image.asset(uio.cardType.mainIcon),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(uio.title),
                Spacer(),
                Row(
                  children: [
                    Image.asset(Images.calenderIcon),
                    Text(uio.getDateTimeAsString("dd MMM")),
                    uio.showTime
                        ? Row(
                            children: [
                              Image.asset(Images.clockIcon),
                              Text(uio.getDateTimeAsString("dd MMM"))
                            ],
                          )
                        : Container()
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
