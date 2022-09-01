import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../theme/colors.dart';

class PostItem extends StatelessWidget {
  final String profileImg;
  final String name;
  final String postImg;
  final String caption;
  final isLoved;
  final String likedBy;
  final String viewCount;

  const PostItem({
    required this.profileImg,
    required this.name,
    required this.postImg,
    required this.isLoved,
    required this.likedBy,
    required this.viewCount,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
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
                              image: NetworkImage(profileImg),
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
                          child: Text(
                            name,
                            style: TextStyle(
                                color: black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
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
            height: 12.h,
          ),
          Container(
            height: 400.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(postImg), fit: BoxFit.cover),
            ),
          ),
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
                    isLoved
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
                    SvgPicture.asset(
                      "assets/images/comment_icon.svg",
                      width: 27.w,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Row(children: [
          //     Icon(
          //       Icons.thumb_up_sharp,
          //       color: Colors.blue,
          //       size: 15,
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Text("12",
          //         style: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //             color: Colors.black)),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     Icon(
          //       Icons.comment_sharp,
          //       color: Colors.blue,
          //       size: 15,
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Text("12",
          //         style: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //             color: Colors.black)),
          //   ]),
          // ),

          Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "$name ",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                TextSpan(
                    text: "$caption",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ]))),
          SizedBox(
            height: 12.h,
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 15, right: 15),
          //   child: Text(
          //     "View $viewCount comments",
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 15,
          //         fontWeight: FontWeight.w500),
          //   ),
          // ),
          // SizedBox(
          //   height: 12,
          // ),
        ],
      ),
    );
  }
}
