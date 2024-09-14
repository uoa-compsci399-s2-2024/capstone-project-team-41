import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';

class Textfieldview extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChange;
  final String hintText;
  final bool tall;

  const Textfieldview(
      {super.key,
      required this.controller,
      required this.onChange,
      required this.hintText,
      this.tall = false});

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
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextField(
              minLines: tall ? 3 : 1,
              maxLines: tall ? 3 : 1,
              controller: controller,
              onChanged: onChange,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: ColorPalette.midGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
