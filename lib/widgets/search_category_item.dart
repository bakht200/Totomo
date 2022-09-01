import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';

class CategoryStoryItem extends StatelessWidget {
  final String name;
  const CategoryStoryItem({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
            border: Border.all(color: black.withOpacity(0.2))),
        child: Padding(
          padding:
              EdgeInsets.only(left: 20.w, right: 25.w, top: 10.h, bottom: 10.h),
          child: Text(
            name,
            style: TextStyle(
                color: black, fontWeight: FontWeight.w500, fontSize: 15.sp),
          ),
        ),
      ),
    );
  }
}
