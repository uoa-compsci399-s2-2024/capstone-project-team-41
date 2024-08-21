import 'package:RemindMate/Features/Friends/Views/FriendsNavButton.dart';
import 'package:flutter/material.dart';


class FriendsNavContainer extends StatelessWidget {

  const FriendsNavContainer({super.key});

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
                Expanded(child: FriendsNavButton(buttonTitle: "Calender")),
                Padding(padding: EdgeInsets.only(right: 14)),
                Expanded(child: FriendsNavButton(buttonTitle: "Contacts"),),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 14)),
            FriendsNavButton(buttonTitle: "Notifications"),
          ],
        )
      )
    );
  }
}
