import 'package:RemindMate/Domain/Contact/SelectedContactRepo.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/Images.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';


class ReminderCard extends StatelessWidget {
  final UIOReminderCard uio;

  const ReminderCard({super.key, required this.uio});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SelectedContactRepo.instance.setSelectedContactId(uio.contact.id);
        AppState().setAppState(UIOAppState.contact);
      },
      child: Container(
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
                  Text(uio.contact.name)
                ],
              ),
            ),
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                const Padding(padding: EdgeInsets.only(right:6)),
                Container(
                  padding: EdgeInsets.all(2),
                  child: Text(uio.getStartDateTimeAsString("HH:mm a"), style: Textstyles.smallDate,)
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(right: 10))
          ],
        ),
      )
    );
  }
}
