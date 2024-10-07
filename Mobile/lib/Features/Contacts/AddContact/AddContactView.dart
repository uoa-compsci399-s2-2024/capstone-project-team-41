import 'package:RemindMate/Features/Contacts/AddContact/AddContactViewModel.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/SaveButton.dart';
import 'package:RemindMate/Features/Views/TextFieldView.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:instant/instant.dart';
import 'package:intl/intl.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<AddContactViewModel>(builder: (context, viewModel, child) {
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
                  "Add A Mate",
                  style: Textstyles.P0,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Textfieldview(
                controller: nameTextEditingController,
                onChange: (value) {
                  viewModel.name = value;
                },
                hintText: "Name"),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Column(children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Birthday",
                      style: Textstyles.textHint,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text("Catch Up Reminders", style: Textstyles.textHint)
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 0),
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
                              DateFormat("MMM d, y").format(viewModel.birthDay),
                              style: TextStyle(
                                  color: ColorPalette.primaryOrange, fontSize: 21),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 63),
                          child: Row(
                            children: [
                              Switch(
                                value: viewModel.isCatchup,
                                inactiveTrackColor: Colors.grey[50],
                                activeColor: ColorPalette.primaryOrange,
                                onChanged: (value) {
                                  setState(() {viewModel.isCatchup = value;});
                                }),
                              const Padding(padding: EdgeInsets.only(right: 16)),
                              DropdownButton(
                                value: viewModel.selectedPeriod,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: viewModel.catchUpPeriods,
                                style: TextStyle(color: ColorPalette.primaryOrange, fontSize: 17, fontWeight: FontWeight.w500),
                                onChanged: (value) {
                                  setState(() {
                                    viewModel.selectedPeriod = value!;
                                  });
                                },
                              ),
                            ],
                          )
                        )
                        

                      ],
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Timezone",
                      style: Textstyles.textHint,
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        DropdownButton(
                          value: viewModel.timeZone,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: timeZoneOffsets.keys.map((String items) {
                            String timeZoneNumber = timeZoneOffsets[items].toString();
                            if (timeZoneNumber[0] != "-") {timeZoneNumber = "+" + timeZoneNumber;}
                            return DropdownMenuItem(
                              value: items,
                              child: Text("$items $timeZoneNumber"),
                            );
                          }).toList(),
                          style: TextStyle(color: ColorPalette.primaryOrange, fontSize: 19, fontWeight: FontWeight.w500),
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
            const Padding(padding: EdgeInsets.only(top: 16)),
            Textfieldview(
              controller: phoneTextEditingController,
              onChange: (value) {
                viewModel.phone = value;
              },
              hintText: "Phone",
            ),
            const Padding(padding: EdgeInsets.only(top: 16)),
            Textfieldview(
              controller: emailTextEditingController,
              onChange: (value) {
                viewModel.email = value;
              },
              hintText: "Email",
            ),
            const Padding(padding: EdgeInsets.only(top: 16)),
            Textfieldview(
              controller: notesTextEditingController,
              onChange: (value) {
                viewModel.notes = value;
              },
              hintText: "Notes",
              tall: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 32, right: 32),
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
