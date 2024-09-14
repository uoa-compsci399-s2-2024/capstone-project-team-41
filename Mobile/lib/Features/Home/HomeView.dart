import 'package:RemindMate/Features/Home/HomeViewModel.dart';
import 'package:RemindMate/Features/Home/Views/HomeNavContainer.dart';
import 'package:RemindMate/Features/Home/Views/RemindersContainer.dart';
import 'package:RemindMate/Features/Views/ColorPalette.dart';
import 'package:RemindMate/Features/Views/TextStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
      
          int l = viewModel.remindersLength;

          return Padding(
          padding:
              const EdgeInsets.only(top: 70, bottom: 60, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 10),
                alignment: Alignment.topRight,
                child: const Icon(Icons.settings, size: 35)
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Good Morning,", style: Textstyles.H1),
                    const Text("Tori!", style: Textstyles.H1Bold),

                    Text("You have $l upcoming events this week", style: TextStyle(color: ColorPalette.primaryOrange)),
                    const Padding(padding: EdgeInsets.only(bottom: 50)),
                    
                  ]
                )

              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: HomeNavContainer(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 15),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weekly Reminders",
                          style: Textstyles.P1,
                        ),
                        Text("This week's upcoming Reminders", style: Textstyles.S1)
                      ],
                    )),
              ),
              Flexible(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ReminderContainer(
                        uios: viewModel.upcomingReminders,
                      ))),
            ],
          ));
      }
    ));
  }
}
