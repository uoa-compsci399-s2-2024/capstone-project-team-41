import 'package:RemindMate/Features/Contacts/List/ContactsViewModel.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContantsContainer.dart';
import 'package:RemindMate/Features/Contacts/List/Views/ContactCardsContainerView.dart';
import 'package:RemindMate/Features/Main/AppState.dart';
import 'package:RemindMate/Features/Main/Models/UIOAppState.dart';
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
        backgroundColor: Colors.grey[50],
        body: Consumer<ContactsViewModel>(builder: (context, viewModel, child) {
      return SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 70)),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 0, left: 16),
                  child: Row(
                    children: [
                      Text(
                        "Contacts",
                        style: Textstyles.H1,
                      )
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: GestureDetector(
                      onTap: () {
                        AppState().setAppState(UIOAppState.addContact);
                      },
                      child: Icon(Icons.add_circle_outline, size: 30)),
                ),
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
