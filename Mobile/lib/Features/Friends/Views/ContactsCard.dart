import 'package:flutter/material.dart';
import 'package:RemindMate/Features/Friends/Models/UIOContactsCard.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/Images.dart';

class ContactsCard extends StatelessWidget {
  final UIOContactsCard uio;

  const ContactsCard({super.key, required this.uio});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 120, 
      decoration: BoxDecoration(
        color: ColorPalette.primaryGreen,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: ColorPalette.primaryPink,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Image.asset(uio.cardType.mainIcon),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  uio.title, 
                  style: TextStyle(
                    color: const Color(0xFF575757),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Birthday: ${uio.getDateTimeAsString("dd MMM")}",
                  style: TextStyle(
                    color: const Color(0xFF575757),
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add reminder setting logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPalette.primaryPink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Set Reminder"),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
