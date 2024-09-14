import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ContactBodyView extends StatelessWidget {
  final UIOContact uio;

  const ContactBodyView({super.key, required this.uio});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Relationship Type", style: Textstyles.S1),
                    const Padding(padding: EdgeInsets.only(bottom: 7),),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                      color: ColorPalette.secondaryPink,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Text(uio.type.title)
                    )

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Birthday", style: Textstyles.S1),
                    const Padding(padding: EdgeInsets.only(bottom: 7),),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Text(DateFormat("dd MMMM").format(DateTime.parse(uio.birthday)), style: TextStyle(fontSize: 15),)
                    )
                    
                  ],
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  const Text("Phone", style: Textstyles.boldSmall),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorPalette.coolGray,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Text(uio.phoneNumber)
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  const Text("Email", style: Textstyles.boldSmall),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorPalette.coolGray,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Text(uio.email),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
                  const Text("Notes", style: Textstyles.boldSmall),
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 50, left: 7),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorPalette.coolGray,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Text(uio.notes)
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40)),
                ],
              ),
            )
          ],
        ));
  }
}
