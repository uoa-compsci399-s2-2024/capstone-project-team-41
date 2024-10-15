import 'package:RemindMate/Features/Contacts/Reminder/AddReminderViewModel.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/SaveButton.dart';
import 'package:RemindMate/Features/Views/TextFieldView.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<AddRedminderViewModel>(builder: (context, viewModel, child) {
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
                Text(
                  "Add A Reminder",
                  style: Textstyles.P0,
                ),
              ],
            ),
            Textfieldview(
              controller: titleTextEditingController,
              onChange: (value) {
                viewModel.title = value;
              },
              hintText: "Title",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Start Time",
                      style: Textstyles.textHint,
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              picker.DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 0, 0),
                                  maxTime: DateTime(2025, 0, 0),
                                  theme: picker.DatePickerTheme(
                                      headerColor: ColorPalette.primaryOrange,
                                      backgroundColor: ColorPalette.coolGray,
                                      itemStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16)), onChanged: (date) {
                                viewModel.endTime = date;
                              }, onConfirm: (date) {
                                setState(() {
                                  viewModel.startTime = date;
                                });
                              },
                                  currentTime: viewModel.startTime,
                                  locale: picker.LocaleType.en);
                            },
                            child: Text(
                              DateFormat("dd MMMM, y - H:mm").format(viewModel.startTime),
                              style: TextStyle(
                                  color: ColorPalette.primaryOrange, fontSize: 21),
                            )),
                      ],
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "End Time",
                      style: Textstyles.textHint,
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              picker.DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 0, 0),
                                  maxTime: DateTime(2025, 0, 0),
                                  theme: picker.DatePickerTheme(
                                      headerColor: ColorPalette.primaryOrange,
                                      backgroundColor: ColorPalette.coolGray,
                                      itemStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      doneStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16)), onChanged: (date) {
                                viewModel.endTime = date;
                              }, onConfirm: (date) {
                                setState(() {
                                  viewModel.endTime = date;
                                });
                              },
                                  currentTime: viewModel.endTime,
                                  locale: picker.LocaleType.en);
                            },
                            child: Text(
                              DateFormat("dd MMMM, y - H:mm").format(viewModel.endTime),
                              style: TextStyle(
                                  color: ColorPalette.primaryOrange, fontSize: 21),
                            )),
                      ],
                    ))
              ]),
            ),
            Textfieldview(
              controller: notesTextEditingController,
              onChange: (value) {
                viewModel.notes = value;
              },
              hintText: "Notes",
              tall: true,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: SaveButtonView(onPress: () {
                viewModel.saveReminder();
              }),
            )
          ],
        ),
      ));
    }));
  }
}
