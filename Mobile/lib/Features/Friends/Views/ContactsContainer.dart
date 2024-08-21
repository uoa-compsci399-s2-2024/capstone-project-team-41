import 'package:RemindMate/Features/Friends/Views/ContactsCard.dart';
import 'package:RemindMate/Features/Friends/Models/UIOContactsCard.dart';
import 'package:flutter/material.dart';

class ContactsContainer extends StatelessWidget {
  final UIOContactsCard carduio;

  const ContactsContainer({super.key, required this.carduio});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context, 
      removeTop: true,
      child: Scrollbar(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) => ContactsCard(uio: carduio),
          separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.only(bottom: 10)),
        ),
      )
    );
  }
}