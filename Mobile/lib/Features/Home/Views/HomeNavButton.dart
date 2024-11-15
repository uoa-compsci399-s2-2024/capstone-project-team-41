import 'package:RemindMate/Features/TabBar/TabBarState.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';



class HomeNavButton extends StatelessWidget {

  final String buttonTitle;
  final Icon iconWidget;
  final int tabIndex;

  const HomeNavButton({super.key, required this.buttonTitle, required this.iconWidget, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        TabBarState().setTab(tabIndex)
      },
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: ColorPalette.primaryOrange,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Row(
          children: [
            const Padding(padding: EdgeInsets.only(right: 16)),
            iconWidget,
            const Padding(padding: EdgeInsets.only(right: 5)),
            Text(buttonTitle,
              style: Textstyles.H3,
            )
          ],
        ),
      )
    );
  }
  
  void setState(Null Function() param0) {}
}
