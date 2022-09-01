import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController nameEditingController = TextEditingController();

  var notificationStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
                      backgroundImage: NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/149/149071.png"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bakht',
                          style: AppTheme.subHeadingStyle,
                        ),
                        Text(
                          'Premium User',
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
              title: Padding(
                padding: EdgeInsets.only(left: 4.0.w),
                child: Text("Account Settings",
                    style: AppTheme.accountSettingHeadingStyle),
              ),
            ),
            ListTile(
              onTap: () {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Wrap(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Center(
                                child: Container(
                                  height: 3.h,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Change Name',
                                      style: AppTheme.subHeadingStyle,
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Text(
                                      'This name will be displayed to the other users.',
                                      style: AppTheme.listSubHeadingStyle,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    TextFormField(
                                      controller: nameEditingController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[a-z A-Z]')),
                                      ],
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Name',
                                        fillColor: Colors.white,
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(AppTheme.primaryColor),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(AppTheme.primaryColor),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(AppTheme.primaryColor),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    SizedBox(
                                      width: width,
                                      height: height / 20,
                                      child: ElevatedButton(
                                          child: Text(
                                            'Save',
                                          ),
                                          style:
                                              AppTheme.themeFilledButtonStyle,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      width: width,
                                      height: height / 20,
                                      child: ElevatedButton(
                                        child: Text('Cancel',
                                            style: AppTheme
                                                .unFilledButtonTextStyle),
                                        style: AppTheme.unfilledButtonStyle,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ]),
                            ),
                          ]));
                    });
              },
              leading: Image.asset(
                'assets/images/tag.png',
                color: Color(AppTheme.primaryColor),
                height: 25.h,
              ),
              title: Text('Change Name',
                  style: AppTheme.settingListTileHeadingStyle),
              trailing: Wrap(
                spacing: 5,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0.h),
                    child: Text(
                      'Bakht',
                      style: AppTheme.listSubHeadingStyle,
                    ),
                  ),
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
            //  ListTile(
            //     onTap: () async {

            //     },
            //     leading: Icon(
            //       Icons.notifications_active_outlined,
            //       color: Color(AppTheme.primaryColor),
            //     ),
            //     title: Text('Allow Notifications',
            //        // style: AppTheme.settingListTileHeadingStyle
            //         ),
            //     trailing: Switch(
            //       value: isSwitched,
            //       onChanged: (value) async {
            //         if (value == false) {
            //           String token =
            //               await FirebaseMessaging.instance.getToken();
            //           await signInServices.sendFcmToken(token,
            //               signInController.userData.first.user.id);

            //           _settingController.toggleButtonValue(value);
            //           await UserSecureStorage.setNotificationStatus(
            //               "true");
            //         } else {
            //           _settingController.toggleButtonValue(value);
            //           await FirebaseMessaging.instance.deleteToken();
            //           await UserSecureStorage.setNotificationStatus(
            //               "false");
            //         }
            //       },
            //       activeTrackColor: AppTheme.toggleTrackColor,
            //       activeColor: AppTheme.primaryColor,
            //     ),

            // ),
            ListTile(
              leading: Icon(
                Icons.location_on,
                color: Color(AppTheme.primaryColor),
              ),
              title:
                  Text('Location', style: AppTheme.settingListTileHeadingStyle),
              trailing: Padding(
                padding: EdgeInsets.only(top: 5.0.h, right: 10.0.h),
                child: Text(
                  "Peshawar",
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.listSubHeadingStyle,
                ),
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
                      onTap: () {},
                      child: Text(
                        'Sign out',
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
