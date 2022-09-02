import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_theme.dart';
import '../widgets/primary_button_widget.dart';

class DescriptionPostScreen extends StatefulWidget {
  const DescriptionPostScreen({Key? key}) : super(key: key);

  @override
  State<DescriptionPostScreen> createState() => _DescriptionPostScreenState();
}

class _DescriptionPostScreenState extends State<DescriptionPostScreen> {
  var cameraFile;
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
                  ? SizedBox(
                      width: double.infinity / 2,
                      height: 40.h,
                      child: theme_primary_button_widget(
                          primaryColor: Color(AppTheme.primaryColor),
                          textColor: Color(0xFFFAFAFA),
                          onpressFunction: () async {
                            // final ImagePicker _picker = ImagePicker();
                            // // Pick an image
                            // final XFile? image = await _picker.pickImage(
                            //     source: ImageSource.gallery);
                            // cameraFile = image;
                          },
                          title: 'Write a text'))
                  : Image.file(cameraFile)),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(12.r),
              height: 200.h,
              child: TextField(
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
                  onpressFunction: () {},
                  title: 'Submit Post')),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
