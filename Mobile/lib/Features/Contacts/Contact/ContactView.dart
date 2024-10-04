import 'package:RemindMate/Features/Contacts/Contact/ContactViewModel.dart';
import 'package:RemindMate/Features/Contacts/Contact/Views/ContactBodyView.dart';
import 'package:RemindMate/Features/Contacts/Contact/Views/ContactTitleView.dart';
import 'package:RemindMate/Features/Home/Views/ReminderCard.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ContactViewModel>(builder: (context, viewModel, child) {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      AppState().setAppState(UIOAppState.home);
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
            viewModel.contact != null
                ? ContactTitleView(uio: viewModel.contact!, viewModel: viewModel,)
                : Container(),
            viewModel.contact != null
                ? ContactBodyView(uio: viewModel.contact!)
                : Container(),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 16)),
                Text("Upcoming Reminders", style: Textstyles.B1),
                TextButton(
                    onPressed: () {
                      AppState().setAppState(UIOAppState.addReminder);
                    },
                    child: Text("Add reminder")),
                Padding(padding: EdgeInsets.only(left: 100)),
              ],
            ),
            ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.reminders.length,
              itemBuilder: (context, index) {
                final reminder = viewModel.reminders[index];

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: ReminderCard(uio: reminder),
                );
              },
            ),
          ],
        ),
      ));
    }));
  }
}
