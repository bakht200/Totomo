import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/theme/colors.dart';
import 'package:dating_app/view/chat_screen.dart';
import 'package:dating_app/view/profile.dart';
import 'package:dating_app/view/search_page.dart';
import 'package:dating_app/view/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'home_page.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0.h), child: getAppBar()),
      backgroundColor: black,
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      HomePage(),
      SearchPage(),
      SettingPage(),
      ProfilePage(),
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Totomo",
              style: TextStyle(
                color: black,
                fontFamily: 'Billabong',
                fontSize: 35.sp,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (builder) => ChatPage()));
              },
              child: SvgPicture.asset(
                "assets/images/message_icon.svg",
                width: 30.w,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    } else if (pageIndex == 1) {
      return AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          "Search",
          style: TextStyle(
            color: black,
            fontFamily: 'Billabong',
            fontSize: 35.sp,
          ),
        ),
      );
    } else if (pageIndex == 2) {
      return AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          "Setting",
          style: TextStyle(
            color: black,
            fontFamily: 'Billabong',
            fontSize: 35.sp,
          ),
        ),
      );
    } else if (pageIndex == 3) {
      return AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          "Profile",
          style: TextStyle(
            color: black,
            fontFamily: 'Billabong',
            fontSize: 35.sp,
          ),
        ),
      );
    } else {
      return AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: Text(
          "Account",
          style: TextStyle(
            color: black,
            fontFamily: 'Billabong',
            fontSize: 35.sp,
          ),
        ),
      );
    }
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0 ? "assets/images/home (2).png" : "assets/images/home.png",
      pageIndex == 1
          ? "assets/images/magnifying-glass.png"
          : "assets/images/search.png",
      pageIndex == 2 ? "assets/images/gear.png" : "assets/images/settings.png",
      pageIndex == 3 ? "assets/images/man-user.png" : "assets/images/user.png",
    ];
    return Container(
      width: double.infinity,
      height: 80.h,
      decoration: BoxDecoration(color: appFooterColor),
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
                  width: 27.w,
                  color: Color(AppTheme.primaryColor),
                ));
          }),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
