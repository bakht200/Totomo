import 'package:dating_app/constants/app_theme.dart';

import 'package:dating_app/view/chat_screen.dart';
import 'package:dating_app/view/profile.dart';
import 'package:dating_app/view/search_page.dart';
import 'package:dating_app/view/setting.dart';
import 'package:dating_app/view/subscription_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home_page.dart';
import 'messaging/search.dart';

class Dashboard extends StatefulWidget {
  int index;
  Dashboard({required this.index});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String searchQuery = "Search query";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      const HomePage(),
      Search(),
      const SearchPage(),
      SubscriptionPage(),
      const ProfilePage(),
    ];
    return IndexedStack(
      index: widget.index,
      children: pages,
    );
  }

  // Widget getAppBar() {
  //    else if (pageIndex == 1) {
  //     return     } else if (pageIndex == 2) {
  //     return ;
  //   } else if (pageIndex == 3) {
  //     return
  //   } else {
  //     return ;
  //   }
  // }

  Widget getFooter() {
    List bottomItems = [
      widget.index == 0
          ? "assets/images/home (2).png"
          : "assets/images/home.png",
      widget.index == 1
          ? "assets/images/email (1).png"
          : "assets/images/email.png",
      widget.index == 2
          ? "assets/images/magnifying-glass.png"
          : "assets/images/search.png",
      widget.index == 3
          ? "assets/images/diamond (2).png"
          : "assets/images/diamond (1).png",
      widget.index == 4
          ? "assets/images/man-user.png"
          : "assets/images/user.png",
    ];
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: const BoxDecoration(color: appFooterColor),
      child: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h, top: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItems.length, (index) {
            return InkWell(
                onTap: () {
                  selectedTab(index);
                },
                child: Image.asset(
                  bottomItems[index],
                  width: 20.w,
                  color: Color(AppTheme.primaryColor),
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      widget.index = index;
    });
  }
}
