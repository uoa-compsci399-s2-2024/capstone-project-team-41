import 'package:RemindMate/Features/Calender/CalenderViewModel.dart';
import 'package:RemindMate/Features/Home/Views/ReminderCard.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
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
      backgroundColor: Colors.grey[50],
      body: Consumer<CalenderViewModel>(builder: (context, viewModel, child) {
        return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const Row(
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
              monthViewSettings: DateRangePickerMonthViewSettings(
                specialDates: viewModel.uniqueDates
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                specialDatesDecoration: BoxDecoration(
                  border: Border.all(color: ColorPalette.primaryOrange, width: 2),
                  shape: BoxShape.circle
                ),
                todayCellDecoration: BoxDecoration(
                  border: Border.all(color: ColorPalette.primaryPink, width: 2),
                  shape: BoxShape.circle
                ),
                todayTextStyle: TextStyle(color: ColorPalette.primaryPink)
              ),
              yearCellStyle: DateRangePickerYearCellStyle(
                todayCellDecoration: BoxDecoration(
                  border: Border.all(color: ColorPalette.primaryPink, width: 2),
                  shape: BoxShape.circle
                ),
                todayTextStyle: TextStyle(color: ColorPalette.primaryPink)
              ),
              selectionTextStyle: const TextStyle(color: Colors.black),
              selectionColor: ColorPalette.primaryPink,
              backgroundColor: ColorPalette.lightGray,
              headerStyle: DateRangePickerHeaderStyle(backgroundColor: ColorPalette.lightGray),
            ),
            viewModel.getLength() == 0 ? Container(
              padding: const EdgeInsets.all(20),
              child: const Text("No Reminders", style: Textstyles.B1)
            ) : Container(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.getLength(),
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
