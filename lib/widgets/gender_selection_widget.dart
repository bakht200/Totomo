import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/model/gender_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadio extends StatelessWidget {
  Gender _gender;

  CustomRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    return Card(
        color:
            _gender.selected ? Color(AppTheme.primaryColor) : Colors.grey[300],
        child: Container(
          height: 70.h,
          width: 70.w,
          alignment: Alignment.center,
          margin: EdgeInsets.all(5.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                _gender.icon,
                color: _gender.selected ? Colors.white : Colors.black38,
                size: 40.sp,
              ),
              SizedBox(height: 10.h),
              Text(
                _gender.name,
                style: TextStyle(
                    color: _gender.selected ? Colors.white : Colors.black38),
              )
            ],
          ),
        ));
  }
}
