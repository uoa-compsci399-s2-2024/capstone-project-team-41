import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TabBarState {
  static final TabBarState _singleton = TabBarState._internal();

  final PersistentTabController _tabController = PersistentTabController();

  PersistentTabController get tabController => _tabController;

  factory TabBarState() {
    return _singleton;
  }

  TabBarState._internal();

  void setTab(int index) {
    tabController.jumpToTab(index);
  }
}