import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';

class StoryItem extends StatelessWidget {
  final String img;
  final String name;
  const StoryItem({
    required this.img,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 68.w,
            height: 68.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: storyBorderColor)),
            child: Padding(
              padding: EdgeInsets.all(3.0.w),
              child: Container(
                width: 65.w,
                height: 65.h,
                decoration: BoxDecoration(
                    border: Border.all(color: black, width: 2.w),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                          img,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            width: 70.w,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0.w),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: black),
              ),
            ),
          )
        ],
      ),
    );
  }
}
