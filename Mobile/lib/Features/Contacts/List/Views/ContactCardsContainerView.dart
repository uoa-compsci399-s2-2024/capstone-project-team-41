import 'package:RemindMate/Features/Contacts/Models/UIOContantsContainer.dart';
import 'package:RemindMate/Features/Contacts/List/Views/ContactCardView.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';

class ContactContainerView extends StatelessWidget {
  final UIOContantsContainer uio;

  const ContactContainerView({super.key, required this.uio});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(uio.contactChar, style: Textstyles.P1),
              ),
              const Spacer()
            ],
          ),
          Divider(
            height: 20,
            color: ColorPalette.secondaryPink,
            thickness: 3,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: uio.contacts.length,
              itemBuilder: (context, index) {
                final contact = uio.contacts[index];

                return ContactCardView(uio: contact);
              }),
        ],
      ),
    );
  }
}
