import 'package:dating_app/constants/app_theme.dart';

import 'package:dating_app/view/chat_screen.dart';
import 'package:dating_app/view/profile.dart';
import 'package:dating_app/view/search_page.dart';
import 'package:dating_app/view/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'home_page.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int pageIndex = 0;
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

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
      ChatPage(),
      const SearchPage(),
      SettingPage(),
      const ProfilePage(),
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getAppBar() {
    if (pageIndex == 0) {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                } else {
                  _isSearching = true;
                }
              });
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Image.asset('assets/images/filter.png',
              color: Colors.white, width: 20.w),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
        title: _isSearching
            ? _buildSearchField()
            : Center(
                child: Text(
                  "Totomo",
                  style: TextStyle(
                    color: white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.sp,
                  ),
                ),
              ),
      );
    } else if (pageIndex == 1) {
      return AppBar(
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 7.w, right: 16.w, top: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Conversations",
                style: TextStyle(
                    fontSize: 25.sp, fontWeight: FontWeight.bold, color: white),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Container(
              padding:
                  EdgeInsets.only(left: 8.w, right: 8.w, top: 2.h, bottom: 2.h),
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Color(AppTheme.primaryColor),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "Add New",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    } else if (pageIndex == 2) {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        title: Center(
          child: Text(
            "Search",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 32.sp,
            ),
          ),
        ),
      );
    } else if (pageIndex == 3) {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        title: Center(
          child: Text(
            "Setting",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 32.sp,
            ),
          ),
        ),
      );
    } else {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 32.sp,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildSearchField() {
    return TextField(
        controller: _searchQueryController,
        autofocus: true,
        decoration: InputDecoration(
          hintText: "Search Data...",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white30),
        ),
        style: TextStyle(color: Colors.white, fontSize: 16.0),
        onChanged: (query) {});
  }

  Widget getFooter() {
    List bottomItems = [
      pageIndex == 0 ? "assets/images/home (2).png" : "assets/images/home.png",
      pageIndex == 1
          ? "assets/images/comment (1).png"
          : "assets/images/comment.png",
      pageIndex == 2
          ? "assets/images/magnifying-glass.png"
          : "assets/images/search.png",
      pageIndex == 3 ? "assets/images/gear.png" : "assets/images/settings.png",
      pageIndex == 4 ? "assets/images/man-user.png" : "assets/images/user.png",
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
