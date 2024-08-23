import 'package:RemindMate/Features/Contacts/ContactsViewModel.dart';
import 'package:RemindMate/Features/Contacts/Models/UIOContantsContainer.dart';
import 'package:RemindMate/Features/Contacts/Views/ContactCardsContainerView.dart';
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
        physics: ScrollPhysics(),
        child: ListView.builder(
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
      );
    }));
  }
}
