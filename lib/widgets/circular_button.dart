import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularButton extends StatelessWidget {
  final IconData buttonIcon;
  final void Function() buttonAction;
  final Color color;

  CircularButton(
      {required this.buttonIcon,
      required this.buttonAction,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.w),
      decoration:
          BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
      child: IconButton(
        icon: Icon(
          buttonIcon,
          color: color,
        ),
        onPressed: buttonAction,
      ),
    );
  }
}
