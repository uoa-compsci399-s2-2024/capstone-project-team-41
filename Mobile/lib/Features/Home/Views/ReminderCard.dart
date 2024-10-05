import 'package:RemindMate/Domain/Contact/SelectedContactRepo.dart';
import 'package:RemindMate/Features/Home/HomeView.dart';
import 'package:RemindMate/Features/Home/HomeViewModel.dart';
import 'package:RemindMate/Features/Home/Models/UIOReminderCard.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
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
                  child: const Icon(Icons.calendar_today, color: Colors.white, size: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(uio.title, style: Textstyles.boldSmall,),
                      const Padding(padding: EdgeInsets.only(right: 10)),
                    ],),
                    Row(
                      children: [
                        Text(uio.contact.name),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        uio.isRecurring?
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: ColorPalette.secondaryPink,
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.white, width: 2.0)
                          ),
                          child: const Text("recurring", style: Textstyles.smallDate,)
                        )
                        :Container()
                      ],
                    )

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
                    padding: const EdgeInsets.all(2),
                    child: Text(uio.getStartDateTimeAsString("dd MMM"), style: Textstyles.smallDate,)
                  ),
                  const Padding(padding: EdgeInsets.only(right:6)),
                  const Padding(padding: EdgeInsets.only(right:6)),
                  Container(
                    padding: const EdgeInsets.all(2),
                    child: Text(uio.getStartDateTimeAsString("HH:mm a"), style: Textstyles.smallDate,)
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(right: 10))
            ],
          ),
        )
      );
  }
}
