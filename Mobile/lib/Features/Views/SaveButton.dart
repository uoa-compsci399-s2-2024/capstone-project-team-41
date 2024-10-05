
import 'package:flutter/material.dart';

class SaveButtonView extends StatelessWidget {
  final Function() onPress;

  const SaveButtonView({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xFFFFB366),
              Color(0xFFFF6E91),
            ],
            tileMode: TileMode.mirror,
          ),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(
              minWidth: 88.0,
              minHeight: 36.0), // min sizes for Material buttons
          alignment: Alignment.center,
          child: const Text(
            'Save',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
