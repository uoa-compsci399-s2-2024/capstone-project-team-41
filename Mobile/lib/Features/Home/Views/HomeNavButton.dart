import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/Images.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';


class HomeNavButton extends StatelessWidget {

  final String buttonTitle;
  // NEEDS UIO

  const HomeNavButton({super.key, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: ColorPalette.primaryOrange,
        borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.only(right: 16)),
          Image.asset(Images.calenderIcon),
          const Padding(padding: EdgeInsets.only(right: 5)),
          Text(buttonTitle,
            style: Textstyles.H3,
          )
        ],
      ),
    );
  }
}
