import 'package:RemindMate/Features/Contacts/List/ContactsViewModel.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContantsContainer.dart';
import 'package:RemindMate/Features/Contacts/List/Views/ContactCardsContainerView.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ContactsViewModel>(builder: (context, viewModel, child) {
      return SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 16),
              child: Row(
                children: [
                  Text(
                    "Contacts",
                    style: Textstyles.H1,
                  )
                ],
              ),
            ),
            Row(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(onTap: () {}, child: Icon(Icons.add)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(onTap: () {}, child: Icon(Icons.list)),
                )
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.sortedContactMapKeys().length,
              itemBuilder: (context, index) {
                final key = viewModel.sortedContactMapKeys()[index];
                final contacts = viewModel.contactMap()[key];

                return ContactContainerView(
                    uio: UIOContantsContainer(
                        contactChar: key, contacts: contacts!));
              },
            ),
          ],
        ),
      );
    }));
  }
}
