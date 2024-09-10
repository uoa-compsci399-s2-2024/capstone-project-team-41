import 'package:RemindMate/Features/Calender/CalenderViewModel.dart';
import 'package:RemindMate/Features/Contacts/Contact/ContactViewModel.dart';
import 'package:RemindMate/Features/Contacts/Contact/Views/ContactBodyView.dart';
import 'package:RemindMate/Features/Contacts/Contact/Views/ContactTitleView.dart';
import 'package:RemindMate/Features/Home/Views/ReminderCard.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Reminders/RemindersViewModel.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Notifications",
                  style: Textstyles.P0,
                )
              ],
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
                    Text(
                      key,
                      style: Textstyles.B1,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: reminders!.length,
                      itemBuilder: (context, index) {
                        final reminder = reminders[index];
                        return ReminderCard(uio: reminder);
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ));
    }));
  }
}
