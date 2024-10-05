import 'package:RemindMate/Features/Home/Views/ReminderCard.dart';
import 'package:RemindMate/Features/Reminders/RemindersViewModel.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RemindersView extends StatefulWidget {
  const RemindersView({super.key});

  @override
  State<RemindersView> createState() => _RemindersViewState();
}

class _RemindersViewState extends State<RemindersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<RemindersViewModel>(builder: (context, viewModel, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 100, bottom: 0, left: 16),
              child: Row(
                children: [
                  Text("Notifications Hub", style: Textstyles.H1,),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Text("Your upcoming reminders", style: Textstyles.S1,),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.sortedEventMappKeys().length,
              itemBuilder: (context, index) {
                final key = viewModel.sortedEventMappKeys()[index];
                final reminders = viewModel.eventMap[key];
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat("MMMM").format(DateTime.parse("$key-01")), style: Textstyles.P1,),
                          Divider(
                            height: 20,
                            thickness: 3,
                            color: ColorPalette.primaryPink,
                          )
                        ]
                      )
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reminders!.length,
                      itemBuilder: (context, index) {
                        final reminder = reminders[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          child: ReminderCard(uio: reminder)
                        );
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 50))
                  ],
                );
              },
            ),
          ],
        ),
      );
    }));
  }
}
