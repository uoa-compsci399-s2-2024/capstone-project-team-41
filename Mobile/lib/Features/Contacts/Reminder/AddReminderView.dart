import 'package:RemindMate/Features/Contacts/Reminder/AddReminderViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddReminderView extends StatefulWidget {
  const AddReminderView({super.key});

  @override
  State<AddReminderView> createState() => _AddReminderViewState();
}

class _AddReminderViewState extends State<AddReminderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<AddRedminderViewModel>(builder: (context, viewModel, child) {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [Text("Add A Reminder")],
        ),
      ));
    }));
  }
}
