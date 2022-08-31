import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Totomo',
          style: TextStyle(
              color: Color(AppTheme.primaryColor),
              fontSize: 30.sp,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Icon(
              Icons.message_rounded,
              size: 25.sp,
              color: Color(AppTheme.primaryColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 100.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: CircleAvatar(
                      backgroundColor: Color(AppTheme.primaryColor),
                      radius: 45.r,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://i.pinimg.com/originals/37/8a/30/378a308e0d89db685588c03f332d4a43.png",
                          fit: BoxFit.cover,
                          width: 80.w,
                          height: 80.h,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
