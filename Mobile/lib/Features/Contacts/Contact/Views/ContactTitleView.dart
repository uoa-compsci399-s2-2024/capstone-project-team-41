import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/widgets.dart';

class ContactTitleView extends StatelessWidget {
  final UIOContact uio;

  const ContactTitleView({super.key, required this.uio});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 32),
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
          )
        ],
      ),
    );
  }
}
