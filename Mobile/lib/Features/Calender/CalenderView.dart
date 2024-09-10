import 'package:RemindMate/Features/Calender/CalenderViewModel.dart';
import 'package:RemindMate/Features/Contacts/Contact/ContactViewModel.dart';
import 'package:RemindMate/Features/Contacts/Contact/Views/ContactBodyView.dart';
import 'package:RemindMate/Features/Contacts/Contact/Views/ContactTitleView.dart';
import 'package:RemindMate/Features/Home/Views/ReminderCard.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CalenderView extends StatefulWidget {
  const CalenderView({super.key});

  @override
  State<CalenderView> createState() => _CalenderViewwState();
}

class _CalenderViewwState extends State<CalenderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<CalenderViewModel>(builder: (context, viewModel, child) {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Calender",
                  style: Textstyles.P0,
                )
              ],
            ),
            SfDateRangePicker(
              view: DateRangePickerView.year,
              onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                setState(() {
                  viewModel.selectedTime =
                      dateRangePickerSelectionChangedArgs.value;
                });
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel
                      .eventMap[viewModel.selectedTime
                          .toIso8601String()
                          .split("T")[0]]
                      ?.length ??
                  0,
              itemBuilder: (context, index) {
                final reminder = viewModel.eventMap[viewModel.selectedTime
                    .toIso8601String()
                    .split("T")[0]]![index];
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
