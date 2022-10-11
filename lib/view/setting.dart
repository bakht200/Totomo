import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/app_theme.dart';
import '../controller/profile_controller.dart';
import 'edit_profile.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController nameEditingController = TextEditingController();
  final profileController = Get.put(ProfileController());
  bool? loading;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future fetchUserData() async {
    setState(() {
      loading = true;
    });
    await profileController.getUserData();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          backgroundColor: Color(AppTheme.appBarBackgroundColor),
          title: Text(
            "Setting",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
        ),
        body: loading == true
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 4.0.w),
                          child: CircleAvatar(
                            radius: 40.r,
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(profileController
                                .userInformation.first['profileImage'][0]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    profileController
                                        .userInformation.first['fullName'],
                                    style: AppTheme.subHeadingStyle,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  )
                                ],
                              ),
                              Text(
                                profileController
                                    .userInformation.first['email'],
                                style: AppTheme.listSubHeadingStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (builder) => EditProfilePage()));
                    },
                    leading: Image.asset(
                      'assets/images/tag.png',
                      color: Color(AppTheme.primaryColor),
                      height: 25.h,
                    ),
                    title: Text('Account Setting',
                        style: AppTheme.settingListTileHeadingStyle),
                    trailing: Wrap(
                      spacing: 5,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5.0.h),
                          child: Icon(
                            Icons.navigate_next,
                            size: 35.sp,
                            color: Color(AppTheme.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.notifications,
                  //     color: Color(AppTheme.primaryColor),
                  //     size: 25.h,
                  //   ),
                  //   title: Text('Notification',
                  //       style: AppTheme.settingListTileHeadingStyle),
                  //   trailing: Wrap(
                  //     spacing: 5,
                  //     children: <Widget>[
                  //       Padding(
                  //         padding: EdgeInsets.only(top: 5.0.h),
                  //         child: Icon(
                  //           Icons.navigate_next,
                  //           size: 35.sp,
                  //           color: Color(AppTheme.primaryColor),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.remove_red_eye,
                  //     color: Color(AppTheme.primaryColor),
                  //     size: 25.h,
                  //   ),
                  //   title: Text('Appearance',
                  //       style: AppTheme.settingListTileHeadingStyle),
                  //   trailing: Wrap(
                  //     spacing: 5,
                  //     children: <Widget>[
                  //       Padding(
                  //         padding: EdgeInsets.only(top: 5.0.h),
                  //         child: Icon(
                  //           Icons.navigate_next,
                  //           size: 35.sp,
                  //           color: Color(AppTheme.primaryColor),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: Color(AppTheme.primaryColor),
                      size: 25.h,
                    ),
                    title: Text('Privacy & Security',
                        style: AppTheme.settingListTileHeadingStyle),
                    trailing: Wrap(
                      spacing: 5,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5.0.h),
                          child: Icon(
                            Icons.navigate_next,
                            size: 35.sp,
                            color: Color(AppTheme.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.headphones,
                      color: Color(AppTheme.primaryColor),
                      size: 25.h,
                    ),
                    title: Text('Help & Support',
                        style: AppTheme.settingListTileHeadingStyle),
                    trailing: Wrap(
                      spacing: 5,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5.0.h),
                          child: Icon(
                            Icons.navigate_next,
                            size: 35.sp,
                            color: Color(AppTheme.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help_center,
                      color: Color(AppTheme.primaryColor),
                      size: 25.h,
                    ),
                    title: Text('About',
                        style: AppTheme.settingListTileHeadingStyle),
                    trailing: Wrap(
                      spacing: 5,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5.0.h),
                          child: Icon(
                            Icons.navigate_next,
                            size: 35.sp,
                            color: Color(AppTheme.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: GestureDetector(
                            child: Text(
                              '',
                              style: AppTheme.appBarSubHeadingStyle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Row(
                            children: [
                              Text(
                                "Version: 0.1",
                                style: AppTheme.tabBarHeadingStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
