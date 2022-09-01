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
                        Row(
                          children: [
                            Text(
                              'Bakht',
                              style: AppTheme.subHeadingStyle,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            )
                          ],
                        ),
                        Text(
                          'bakht@gmail.com',
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
                // showModalBottomSheet(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(30.r),
                //         topRight: Radius.circular(30.r),
                //       ),
                //     ),
                //     context: context,
                //     builder: (BuildContext context) {
                //       return Padding(
                //           padding: EdgeInsets.all(8.0.w),
                //           child: Wrap(children: <Widget>[
                //             Padding(
                //               padding: EdgeInsets.all(8.0.w),
                //               child: Center(
                //                 child: Container(
                //                   height: 3.h,
                //                   width: MediaQuery.of(context).size.width / 2,
                //                   decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(20.r),
                //                       color: Colors.grey),
                //                 ),
                //               ),
                //             ),
                //             SizedBox(
                //               height: 20.h,
                //             ),
                //             Padding(
                //               padding: EdgeInsets.all(8.0.w),
                //               child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       'Change Name',
                //                       style: AppTheme.subHeadingStyle,
                //                     ),
                //                     SizedBox(
                //                       height: 10.h,
                //                     ),
                //                     Text(
                //                       'This name will be displayed to the other users.',
                //                       style: AppTheme.listSubHeadingStyle,
                //                     ),
                //                     SizedBox(
                //                       height: 20.h,
                //                     ),
                //                     TextFormField(
                //                       controller: nameEditingController,
                //                       inputFormatters: [
                //                         FilteringTextInputFormatter.allow(
                //                             RegExp('[a-z A-Z]')),
                //                       ],
                //                       keyboardType: TextInputType.text,
                //                       decoration: InputDecoration(
                //                         hintText: 'Name',
                //                         fillColor: Colors.white,
                //                         errorBorder: OutlineInputBorder(
                //                           borderSide: BorderSide(
                //                             color: Color(AppTheme.primaryColor),
                //                           ),
                //                         ),
                //                         focusedErrorBorder: OutlineInputBorder(
                //                           borderSide: BorderSide(
                //                             color: Color(AppTheme.primaryColor),
                //                           ),
                //                         ),
                //                         focusedBorder: OutlineInputBorder(
                //                           borderSide: BorderSide(
                //                             color: Color(AppTheme.primaryColor),
                //                           ),
                //                         ),
                //                         enabledBorder: OutlineInputBorder(
                //                           borderSide: BorderSide(
                //                             color:
                //                                 Theme.of(context).primaryColor,
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                     SizedBox(
                //                       height: 30.h,
                //                     ),
                //                     SizedBox(
                //                       width: width,
                //                       height: height / 20,
                //                       child: ElevatedButton(
                //                           child: Text(
                //                             'Save',
                //                           ),
                //                           style:
                //                               AppTheme.themeFilledButtonStyle,
                //                           onPressed: () {
                //                             Navigator.pop(context);
                //                           }),
                //                     ),
                //                     SizedBox(
                //                       height: 10.h,
                //                     ),
                //                     Container(
                //                       width: width,
                //                       height: height / 20,
                //                       child: ElevatedButton(
                //                         child: Text('Cancel',
                //                             style: AppTheme
                //                                 .unFilledButtonTextStyle),
                //                         style: AppTheme.unfilledButtonStyle,
                //                         onPressed: () {
                //                           Navigator.pop(context);
                //                         },
                //                       ),
                //                     ),
                //                     SizedBox(
                //                       height: 20.h,
                //                     ),
                //                   ]),
                //             ),
                //           ]));
                //     });
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
            ListTile(
              leading: Icon(
                Icons.notifications,
                color: Color(AppTheme.primaryColor),
                size: 25.h,
              ),
              title: Text('Notification',
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
                Icons.remove_red_eye,
                color: Color(AppTheme.primaryColor),
                size: 25.h,
              ),
              title: Text('Appearance',
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
              title: Text('About', style: AppTheme.settingListTileHeadingStyle),
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
                      onTap: () async {
                        Navigator.pop(context);
                      },
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
