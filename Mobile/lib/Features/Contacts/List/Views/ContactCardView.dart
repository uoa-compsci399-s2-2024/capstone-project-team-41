import 'package:RemindMate/Domain/Contact/SelectedContactRepo.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';

class ContactCardView extends StatelessWidget {
  final UIOContact uio;

  const ContactCardView({super.key, required this.uio});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SelectedContactRepo.instance.setSelectedContactId(uio.id);
        AppState().setAppState(UIOAppState.contact);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
        child: Container(
          height: uio.hasNewReminder ? 120 : 90,
          decoration: BoxDecoration(
              color: ColorPalette.primaryGreen,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 26, right: 26, top: 8, bottom: 4),
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
                            uio.name,
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.calendar_month),
                      ),
                      Text(
                        uio.getTimeZoneDate(),
                        style: Textstyles.B2,
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(Icons.timer_outlined),
                      ),
                      Text(
                        uio.getTimeZoneTime(),
                        style: Textstyles.B2,
                      )
                    ],
                  ),
                ),
                const Spacer(),
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
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
