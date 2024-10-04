import 'package:RemindMate/Features/Contacts/Contact/ContactViewModel.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactTitleView extends StatelessWidget {
  final UIOContact uio;
  final ContactViewModel viewModel;

  const ContactTitleView({super.key, required this.uio, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: Row(
        children: [
          uio.profileImageUrl == null
              ? Image.asset(
                  "lib/images/largeDefaultUserProfile.png",
                  scale: 10,
                )
              : Image.network(uio.profileImageUrl!),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              uio.name,
              style: Textstyles.P0,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  viewModel.deleteContact(uio.id);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorPalette.secondaryPink,
                    border: Border.all(color: Colors.red, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
                  ),
                  child: const Text("Remove Mate", style: Textstyles.boldSmall,)
                )
              )
            )
          )

        ],
      ),
    );
  }
}
