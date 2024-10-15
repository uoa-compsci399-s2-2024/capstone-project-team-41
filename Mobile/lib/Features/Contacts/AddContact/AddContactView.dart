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
import 'package:input_quantity/input_quantity.dart';

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
            const Padding(padding: EdgeInsets.only(bottom: 30)),
            Textfieldview(
              controller: nameTextEditingController,
              onChange: (value) {
                viewModel.name = value;
              },
              hintText: "Name"
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Birthday",
                        style: Textstyles.textHint,
                      ),
                      Row(
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
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Timezone",
                            style: Textstyles.textHint,
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
                        ]
                      ),
                    ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Catch Up Reminders", style: Textstyles.textHint,),
                      const Padding(padding: EdgeInsets.only(bottom: 16)),
                      Row(
                        children: [
                          Switch(
                            value: viewModel.isCatchup,
                            inactiveTrackColor: Colors.grey[50],
                            activeColor: ColorPalette.primaryOrange,
                            onChanged: (value) {
                              setState(() {viewModel.isCatchup = value;});
                            }),
                          Container(
                            padding: const EdgeInsets.only(left: 6, right: 6, bottom: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[600]!, width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(16))
                            ),
                            child: Column(
                              children: [
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
                                InputQty(
                                  maxVal: 50,
                                  initVal: 1,
                                  steps: 1,
                                  minVal: 1,
                                  onQtyChanged: (val) {
                                    setState(() {
                                      viewModel.selectedInterval = val.toInt();
                                    });
                                  },
                                  qtyFormProps: const QtyFormProps(enableTyping: false),
                                  decoration: QtyDecorationProps(
                                    isBordered: false,
                                    btnColor: ColorPalette.primaryOrange,
                                    borderShape: BorderShapeBtn.circle,
                                  ),
                                ),
                              ],
                            )
                          )
                        ],
                      )
                    ]
                  )
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 64)),
            Textfieldview(
              controller: phoneTextEditingController,
              onChange: (value) {
                viewModel.phone = value;
              },
              hintText: "Contact Method",
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
