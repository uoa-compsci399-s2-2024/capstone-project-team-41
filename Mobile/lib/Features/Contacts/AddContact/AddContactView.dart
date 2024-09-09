import 'package:RemindMate/Features/Contacts/AddContact/AddContactViewModel.dart';
import 'package:RemindMate/Features/Contacts/Reminder/AddReminderViewModel.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/TextFieldView.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:instant/instant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class AddContactView extends StatefulWidget {
  const AddContactView({super.key});

  @override
  State<AddContactView> createState() => _AddContactViewState();
}

class _AddContactViewState extends State<AddContactView> {
  final TextEditingController nameTextEditingController =
      TextEditingController();
  final TextEditingController notesTextEditingController =
      TextEditingController();
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<AddContactViewModel>(builder: (context, viewModel, child) {
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
                  "Add A Friend",
                  style: Textstyles.P0,
                ),
              ],
            ),
            Textfieldview(
                controller: nameTextEditingController,
                onChange: (value) {
                  viewModel.name = value;
                },
                hintText: "Name"),
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
                    viewModel.birthDay = date;
                  },
                      onConfirm: (date) {},
                      currentTime: viewModel.birthDay,
                      locale: picker.LocaleType.en);
                },
                child: Text(
                  'Birthday time',
                  style: TextStyle(color: Colors.blue),
                )),
            DropdownButton(
              value: viewModel.timeZone,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: timeZoneOffsets.keys.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  viewModel.timeZone = newValue!;
                });
              },
            ),
            Textfieldview(
              controller: phoneTextEditingController,
              onChange: (value) {
                viewModel.notes = value;
              },
              hintText: "Phone",
            ),
            Textfieldview(
              controller: emailTextEditingController,
              onChange: (value) {
                viewModel.notes = value;
              },
              hintText: "Email",
            ),
            Textfieldview(
              controller: notesTextEditingController,
              onChange: (value) {
                viewModel.notes = value;
              },
              hintText: "Nates",
            ),
            ElevatedButton(
                onPressed: () {
                  viewModel.saveContact();
                },
                child: Text("Save"))
          ],
        ),
      ));
    }));
  }
}
