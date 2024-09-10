import 'package:RemindMate/Features/Home/Views/HomeNavButton.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';


class HomeNavContainer extends StatelessWidget {

  const HomeNavContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 0, right: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(child: HomeNavButton(buttonTitle: "Calender", iconWidget: Icon(Icons.calendar_month, color: Colors.white,), appState: UIOAppState.calendar,)),
                Padding(padding: EdgeInsets.only(right: 14)),
                Expanded(child: HomeNavButton(buttonTitle: "Contacts", iconWidget: Icon(Icons.contacts, color: Colors.white), appState: UIOAppState.calendar),),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 14)),
            HomeNavButton(buttonTitle: "Notifications", iconWidget: Icon(Icons.notifications, color: Colors.white,), appState: UIOAppState.calendar),
          ],
        )
      )
    );
  }
}
