import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';

class Textfieldview extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChange;
  final String hintText;

  const Textfieldview(
      {super.key,
      required this.controller,
      required this.onChange,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                hintText,
                style: Textstyles.P1,
              ),
            ],
          ),
          TextField(
            controller: controller,
            onChanged: onChange,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: ColorPalette.midGray,
            ),
          ),
        ],
      ),
    );
  }
}
