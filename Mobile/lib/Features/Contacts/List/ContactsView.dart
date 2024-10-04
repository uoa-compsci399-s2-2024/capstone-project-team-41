import 'package:RemindMate/Features/Contacts/List/ContactsViewModel.dart';
import 'package:RemindMate/Features/Contacts/List/Views/ContactCardView.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContact.dart';
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
                        "Mates",
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
                // final uio = UIOContantsContainer(contactChar: key, contacts: contacts!);

                  return ContactContainerView(
                    uio: UIOContantsContainer(
                        contactChar: key, contacts: contacts!
                    )
                  );

                  // return Padding(
                  //   padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 0),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 8),
                  //             child: Text(uio.contactChar, style: Textstyles.P1),
                  //           ),
                  //           const Spacer()
                  //         ],
                  //       ),
                  //       Divider(
                  //         height: 20,
                  //         color: ColorPalette.secondaryPink,
                  //         thickness: 3,
                  //       ),
                  //       ListView.builder(
                  //           shrinkWrap: true,
                  //           physics: const NeverScrollableScrollPhysics(),
                  //           itemCount: uio.contacts.length,
                  //           itemBuilder: (context, index) {
                  //             final contact = uio.contacts[index];

                  //             return Dismissible(
                  //               key: ValueKey<UIOContact>(uio.contacts[index]),
                  //               onDismissed: (direction) {
                  //                 viewModel.deleteContact(contact.id);
                  //               },
                  //               background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 20), child: Text("DELETE")),
                  //               direction: DismissDirection.endToStart,
                  //               child: ContactCardView(uio: contact)
                  //             );
                  //           }),
                  //     ],
                  //   ),
                  // );
              },
            ),
          ],
        ),
      );
    }));
  }
}
