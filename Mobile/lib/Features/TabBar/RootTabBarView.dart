import 'package:RemindMate/Features/Calender/CalenderView.dart';
import 'package:RemindMate/Features/Contacts/List/ContactsView.dart';
import 'package:RemindMate/Features/Home/HomeView.dart';
import 'package:RemindMate/Features/Reminders/RemindersView.dart';
import 'package:RemindMate/Features/TabBar/TabBarState.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class RootTabBarView extends StatelessWidget {
  RootTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        controller: TabBarState().tabController,
        tabs: [
          PersistentTabConfig(
            screen: const HomeView(),
            item: ItemConfig(
              icon: const Icon(Icons.home),
              title: "Home",
            ),
          ),
          PersistentTabConfig(
            screen: const ContactsView(),
            item: ItemConfig(
              icon: const Icon(Icons.home),
              title: "Contacts",
            ),
          ),
          PersistentTabConfig(
            screen: const CalenderView(),
            item: ItemConfig(
              icon: const Icon(Icons.home),
              title: "Calender",
            ),
          ),
          PersistentTabConfig(
            screen: const RemindersView(),
            item: ItemConfig(
              icon: const Icon(Icons.home),
              title: "Reminders",
            ),
          )
        ],
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }
}
