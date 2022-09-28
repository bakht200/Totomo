import 'package:dating_app/view/view_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import '../constants/app_theme.dart';

class PostItem extends StatelessWidget {
  var data;

  var userId;

  PostItem({
    required this.data,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(data['userImage']),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: Row(
                            children: [
                              Text(
                                data['userName'],
                                style: TextStyle(
                                    color: black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Funny',
                                style: TextStyle(
                                    color: Color(AppTheme.primaryColor),
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.location_on, color: Colors.grey),
                            Text(
                              'Peshawar',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          data['mediaUrl'].length != 0
              ? Container(
                  height: 200.h,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data['mediaUrl'].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 300.h,
                          child: Image.network(data['mediaUrl'][index]),
                        );
                      }),
                )
              : SizedBox(),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 3.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    true
                        ? SvgPicture.asset(
                            "assets/images/loved_icon.svg",
                            width: 27.w,
                            color: Colors.black,
                          )
                        : SvgPicture.asset(
                            "assets/images/love_icon.svg",
                            width: 27.w,
                            color: Colors.black,
                          ),
                    SizedBox(
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) =>
                                ViewPost(data: data, userId: userId)));
                      },
                      child: SvgPicture.asset(
                        "assets/images/comment_icon.svg",
                        width: 27.w,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Dialogs.materialDialog(
                            lottieBuilder: LottieBuilder.asset(
                                'assets/images/5084-gold-coin.json'),
                            color: Colors.white,
                            msg: 'Watch ads for send a gold or buy 100 golds!',
                            title: 'Send a gold',
                            context: context,
                            actions: [
                              IconsButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                text: 'Watch Add',
                                iconData: Icons.video_collection,
                                color: Color(AppTheme.primaryColor),
                                textStyle: TextStyle(color: Colors.white),
                                iconColor: Colors.white,
                              ),
                              IconsButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                text: 'Buy',
                                iconData: Icons.diamond_outlined,
                                color: Colors.blue,
                                textStyle: TextStyle(color: Colors.white),
                                iconColor: Colors.white,
                              ),
                            ]);
                      },
                      child: Icon(
                        Icons.diamond,
                        color: Colors.amber,
                        size: 35.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: data['userName'],
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                TextSpan(
                    text: "  ${data['description']}",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ]))),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }
}
