import 'package:camera_camera/camera_camera.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constants/app_theme.dart';
import '../constants/secure_storage.dart';
import '../controller/profile_controller.dart';
import '../widgets/primary_button_widget.dart';
import '../widgets/profile_avatar.dart';

class CameraPostScreen extends StatefulWidget {
  const CameraPostScreen({Key? key}) : super(key: key);

  @override
  State<CameraPostScreen> createState() => _CameraPostScreenState();
}

class _CameraPostScreenState extends State<CameraPostScreen> {
  var cameraFile = null;
  final TextEditingController descriptionController = TextEditingController();
  final profileController = Get.put(ProfileController());
  var imagePath;
  String? userName;

  final List<String> postItems = [
    'GBV',
    'Mens health',
    'Womens health',
    'Crime',
    'General',
    'Kids',
    'Religion',
    'Tradition',
    'Entrepreneurship',
    'Business Law',
    'Education',
    'Sports',
    'Domestic',
    'Ads',
    'Teen Pregnancy',
    'Health',
    'Depression',
    'Anxiety'
  ];
  String? postType;
  @override
  void initState() {
    super.initState();
    fetchCurrentUserName();
  }

  fetchCurrentUserName() async {
    userName = await UserSecureStorage.fetchUserName();
    await profileController.getUserData();
    imagePath = profileController.userInformation.first['profileImage'][0];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: cameraFile == null
                  ? CameraCamera(onFile: (file) {
                      setState(() {
                        cameraFile = file;
                      });
                    })
                  : Image.file(cameraFile)),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(12),
              height: 200.h,
              child: TextField(
                controller: descriptionController,
                maxLines: 15,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Enter a description",
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
              width: 200.w,
              height: 40.h,
              child: theme_primary_button_widget(
                  primaryColor: Color(AppTheme.primaryColor),
                  textColor: Color(0xFFFAFAFA),
                  onpressFunction: () {
                    if (descriptionController.text.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return AlertDialog(
                                  title: Text(
                                    "Information",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Color(AppTheme.primaryColor),
                                    ),
                                  ),
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          "Post type",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(AppTheme.primaryColor),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButton2(
                                            isExpanded: true,
                                            hint: Row(
                                              children: const [
                                                Expanded(
                                                  child: Text(
                                                    'Select Type',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            items: postItems
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ))
                                                .toList(),
                                            value: postType,
                                            onChanged: (value) {
                                              setState(() {
                                                postType = value as String;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                            ),
                                            iconSize: 14,
                                            buttonHeight: 50,
                                            buttonWidth: 180,
                                            buttonPadding:
                                                const EdgeInsets.only(
                                                    left: 14, right: 14),
                                            buttonDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              border: Border.all(
                                                color: Color(
                                                    AppTheme.primaryColor),
                                              ),
                                              color: Colors.white,
                                            ),
                                            buttonElevation: 2,
                                            itemHeight: 40,
                                            itemPadding: const EdgeInsets.only(
                                                left: 14, right: 14),
                                            dropdownMaxHeight: 200,
                                            dropdownWidth: 200,
                                            dropdownPadding: null,
                                            dropdownDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: Colors.white,
                                            ),
                                            dropdownElevation: 8,
                                            scrollbarRadius:
                                                const Radius.circular(40),
                                            scrollbarThickness: 6,
                                            scrollbarAlwaysShow: true,
                                            offset: const Offset(-20, 0),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ]),
                                  actions: <Widget>[
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 3.h, left: 3.w),
                                      child: MaterialButton(
                                        minWidth: 40.w,
                                        height: 40.h,
                                        onPressed: () async {
                                          if (postType == null) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please Select the values.");
                                          } else {
                                            await profileController.insertPost(
                                                cameraFile,
                                                descriptionController.text,
                                                context,
                                                postType,
                                                imagePath,
                                                'cameraPost');
                                          }
                                        },
                                        color: Color(AppTheme.primaryColor),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                        ),
                                        child: Text(
                                          "Post",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]);
                            },
                          );
                        },
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please write some description");
                    }
                  },
                  title: 'Submit Post')),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
