import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';
import '../widgets/primary_button_widget.dart';

class CameraPostScreen extends StatefulWidget {
  const CameraPostScreen({Key? key}) : super(key: key);

  @override
  State<CameraPostScreen> createState() => _CameraPostScreenState();
}

class _CameraPostScreenState extends State<CameraPostScreen> {
  var cameraFile = null;
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
                      print(file);
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
