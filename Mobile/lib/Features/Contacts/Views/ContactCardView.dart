import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';

class ContactCardView extends StatelessWidget {
  final UIOContact uio;

  const ContactCardView({super.key, required this.uio});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: uio.hasNewReminder ? 120 : 90,
      decoration: BoxDecoration(
          color: ColorPalette.primaryGreen,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.only(left: 26, right: 26, top: 8, bottom: 4),
        child: Column(
          children: [
            Row(
              children: [
                uio.profileImageUrl == null
                    ? Image.asset(
                        "lib/images/largeDefaultUserProfile.png",
                        scale: 15,
                      )
                    : Image.network(uio.profileImageUrl!),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${uio.firstName} ${uio.lastName}",
                        style: Textstyles.P1,
                      ),
                      Text(
                        uio.type.title,
                        style: Textstyles.B2,
                      )
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Icons.calendar_month),
                  ),
                  Text(
                    uio.getTimeZoneDate(),
                    style: Textstyles.B2,
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Icons.timer_outlined),
                  ),
                  Text(
                    uio.getTimeZoneTime(),
                    style: Textstyles.B2,
                  )
                ],
              ),
            ),
            Spacer(),
            uio.hasNewReminder
                ? Row(
                    children: [
                      Image.asset(
                        "lib/images/newReminderPill.png",
                        scale: 18,
                      )
                    ],
                  )
                : Container(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
