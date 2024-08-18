import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/Images.dart';
import 'package:flutter/material.dart';


class HomeNavButton extends StatelessWidget {

  // NEEDS UIO

  const HomeNavButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: ColorPalette.primaryOrange,
        borderRadius: const BorderRadius.all(Radius.circular(16))),
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Image.asset(Images.calenderIcon),
          const Text("Calender",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
