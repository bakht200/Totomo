import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_theme.dart';
import '../constants/secure_storage.dart';
import '../controller/profile_controller.dart';
import '../widgets/primary_button_widget.dart';
import '../widgets/profile_avatar.dart';

class GalleryPostScreen extends StatefulWidget {
  const GalleryPostScreen({Key? key}) : super(key: key);

  @override
  State<GalleryPostScreen> createState() => _GalleryPostScreenState();
}

class _GalleryPostScreenState extends State<GalleryPostScreen> {
  var cameraFile;
  final profileController = Get.put(ProfileController());
  final TextEditingController descriptionController = TextEditingController();
  var imagePath;
  String? userName;

  final List<String> postItems = [
    'Funny',
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
    'Teen',
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
    imagePath = profileController.userInformation.first['profileImage'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              ProfileAvatar(imageUrl: imagePath),
              SizedBox(width: 8.0.w),
              Container(
                height: 30.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        userName == null ? '' : "$userName",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              flex: 2,
              child: cameraFile == null
                  ? SizedBox(
                      width: double.infinity / 2,
                      height: 40.h,
                      child: theme_primary_button_widget(
                          primaryColor: Color(AppTheme.primaryColor),
                          textColor: Color(0xFFFAFAFA),
                          onpressFunction: () async {
                            profileController.selectImages();
                          },
                          title: 'Choose Image from Gallery'))
                  : AnimatedBuilder(
                      animation: profileController,
                      builder: (context, child) {
                        return SizedBox(
                          height: 250.h,
                          child: profileController.files != null
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: AnimatedBuilder(
                                      animation: profileController,
                                      builder: (context, child) {
                                        return ListView.builder(
                                            itemExtent:
                                                ScreenUtil().setHeight(246),
                                            itemCount:
                                                profileController.files.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Stack(children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8.0.h,
                                                      bottom: 8.0.h),
                                                  child: Image.file(
                                                      File(profileController
                                                          .files[index].path),
                                                      fit: BoxFit.cover),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 10,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        // getImageController
                                                        //     .removeSelectedImage(
                                                        //         index);
                                                      },
                                                      child: Cutout(
                                                        color: Colors.red,
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]);
                                            });
                                      }))
                              : const SizedBox(),
                        );
                      })),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(12.r),
              height: 200.h,
              child: TextField(
                controller: descriptionController,
                maxLines: 15,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0.w),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0.r),
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
                                                profileController.files,
                                                descriptionController.text,
                                                context,
                                                postType,
                                                imagePath);
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

class Cutout extends StatelessWidget {
  const Cutout({
    Key? key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcOut,
      shaderCallback: (bounds) =>
          LinearGradient(colors: [color!], stops: [0.0]).createShader(bounds),
      child: child,
    );
  }
}
