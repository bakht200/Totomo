import 'package:dating_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../constants/app_theme.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar();

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  bool? _hideNavBar;
  var index;
  var selectedValue;
  PersistentTabController? _controller;
  @override
  void initState() {
    _hideNavBar = false;
    index = 0;

    _controller = PersistentTabController(initialIndex: index);

    _buildScreens();
    _navBarsItems();
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      Home(),
      Home(),
      Home(),
      Home(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: 'Home',
          activeColorPrimary: Color(AppTheme.primaryColor),
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.people),
          title: 'Friends',
          activeColorPrimary: Color(AppTheme.primaryColor),
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: 'Profile',
          activeColorPrimary: Color(AppTheme.primaryColor),
          inactiveColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.settings),
          title: 'Setting',
          activeColorPrimary: Color(AppTheme.primaryColor),
          inactiveColorPrimary: Colors.grey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      hideNavigationBar: _hideNavBar,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 10),
      ),
      navBarStyle: NavBarStyle.style11,
      onItemSelected: (value) {
        selectedValue = value;
      },
    );
  }
}
