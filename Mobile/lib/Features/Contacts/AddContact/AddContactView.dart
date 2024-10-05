import 'package:RemindMate/Features/Contacts/AddContact/AddContactViewModel.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/SaveButton.dart';
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
                    icon: const Icon(Icons.arrow_back)),
                const Text(
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                const Row(
                  children: [
                    Text(
                      "Birthday",
                      style: Textstyles.P1,
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              picker.DatePicker.showDatePicker(context,
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
                                viewModel.updateBirthdayDate(date);
                              },
                                  onConfirm: (date) {},
                                  currentTime: viewModel.birthDay,
                                  locale: picker.LocaleType.en);
                            },
                            child: Text(
                              viewModel.birthDay.toString().split(" ")[0],
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 21),
                            )),
                      ],
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                const Row(
                  children: [
                    Text(
                      "Timezone",
                      style: Textstyles.P1,
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
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
                      ],
                    ))
              ]),
            ),
            Textfieldview(
              controller: phoneTextEditingController,
              onChange: (value) {
                viewModel.phone = value;
              },
              hintText: "Phone",
            ),
            Textfieldview(
              controller: emailTextEditingController,
              onChange: (value) {
                viewModel.email = value;
              },
              hintText: "Email",
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
              child: SaveButtonView(onPress: () async {
                try {
                  await viewModel.saveContact();
                } catch (_) {
                  const snackBar = SnackBar(
                    content: Text("Friend with same name already exists"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }),
            ),
          ],
        ),
      ));
    }));
  }
}
