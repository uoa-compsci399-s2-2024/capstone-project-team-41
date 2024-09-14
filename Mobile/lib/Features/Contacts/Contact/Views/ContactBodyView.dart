import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/widgets.dart';

class ContactBodyView extends StatelessWidget {
  final UIOContact uio;

  const ContactBodyView({super.key, required this.uio});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [const Text("Relationship Type"), Text(uio.type.title)],
                ),
                Column(
                  children: [
                    const Text("Birthday"),
                    Row(
                      children: [Text(uio.birthday)],
                    )
                  ],
                )
              ],
            ),
            const Text("Phone"),
            Text(uio.phoneNumber),
            const Text("Email"),
            Text(uio.email),
            const Text("Notes"),
            Text(uio.notes)
          ],
        ));
  }
}
