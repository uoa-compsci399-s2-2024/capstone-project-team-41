import 'package:RemindMate/Features/Contacts/Reminder/AddReminderViewModel.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class AddReminderView extends StatefulWidget {
  const AddReminderView({super.key});

  @override
  State<AddReminderView> createState() => _AddReminderViewState();
}

class _AddReminderViewState extends State<AddReminderView> {
  final TextEditingController titleTextEditingController =
      TextEditingController();
  final TextEditingController notesTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<AddRedminderViewModel>(builder: (context, viewModel, child) {
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
                    icon: Icon(Icons.arrow_back)),
                Text("Add A Reminder"),
              ],
            ),
            TextField(
              controller: titleTextEditingController,
              onChanged: (value) {
                viewModel.title = value;
              },
            ),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2019, 6, 7),
                      theme: picker.DatePickerTheme(
                          headerColor: Colors.orange,
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    viewModel.startTime = date;
                  },
                      onConfirm: (date) {},
                      currentTime: viewModel.startTime,
                      locale: picker.LocaleType.en);
                },
                child: Text(
                  'Start time',
                  style: TextStyle(color: Colors.blue),
                )),
            TextButton(
                onPressed: () {
                  picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2018, 3, 5),
                      maxTime: DateTime(2019, 6, 7),
                      theme: picker.DatePickerTheme(
                          headerColor: Colors.orange,
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    viewModel.endTime = date;
                  },
                      onConfirm: (date) {},
                      currentTime: viewModel.endTime,
                      locale: picker.LocaleType.en);
                },
                child: Text(
                  'End time',
                  style: TextStyle(color: Colors.blue),
                )),
            TextField(
              controller: notesTextEditingController,
              onChanged: (value) {
                viewModel.notes = value;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  viewModel.saveReminder();
                },
                child: Text("Save"))
          ],
        ),
      ));
    }));
  }
}
