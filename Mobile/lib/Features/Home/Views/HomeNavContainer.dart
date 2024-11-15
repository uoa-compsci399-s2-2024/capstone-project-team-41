import 'package:RemindMate/Features/Home/Views/HomeNavButton.dart';
import 'package:flutter/material.dart';


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
                Expanded(child: HomeNavButton(buttonTitle: "Calender", iconWidget: Icon(Icons.calendar_month, color: Colors.white,), tabIndex: 2,)),
                Padding(padding: EdgeInsets.only(right: 14)),
                Expanded(child: HomeNavButton(buttonTitle: "Mates", iconWidget: Icon(Icons.contacts, color: Colors.white), tabIndex: 1),),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 14)),
            HomeNavButton(buttonTitle: "Notifications", iconWidget: Icon(Icons.notifications, color: Colors.white,), tabIndex: 3),
          ],
        )
      )
    );
  }
}
