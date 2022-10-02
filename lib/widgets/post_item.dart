import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/controller/post_controller.dart';
import 'package:dating_app/view/view_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants/app_theme.dart';

class PostItem extends StatefulWidget {
  var data;
  var userId;
  PostController controller;

  PostItem({
    required this.data,
    required this.userId,
    required this.controller,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  CarouselController controller = CarouselController();
  int pageIndex = 0;
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
                              image: NetworkImage(widget.data['userImage']),
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
                                widget.data['userName'],
                                style: TextStyle(
                                    color: black,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                widget.data['postType'],
                                style: TextStyle(
                                    color: Color(AppTheme.primaryColor),
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: Text(
                            '${timeago.format((widget.data['postedAt'] as Timestamp).toDate())}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w300),
                          ),
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
          widget.data['mediaUrl'].length != 0
              ? Container(
                  height: 200.h,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll:
                          widget.data['mediaUrl'].length <= 1 ? false : true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 2,
                    ),
                    itemCount: widget.data['mediaUrl'].length,
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Stack(
                      children: [
                        Container(
                          height: 200.h,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            widget.data['mediaUrl'][itemIndex],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Text(
                            "${itemIndex + 1}"
                            "/"
                            "${widget.data['mediaUrl'].length}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ))
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
                    GetBuilder(
                        init: widget.controller,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              if (widget.data['like'].contains(widget.userId)) {
                                widget.controller.removePostLike(
                                  widget.data['id'],
                                  widget.userId,
                                );
                              } else {
                                widget.controller.getPostLike(
                                  widget.data['id'],
                                  widget.userId,
                                );
                              }
                            },
                            child: Container(
                              child: widget.data['like'].contains(widget.userId)
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
                            ),
                          );
                        }),
                    SizedBox(
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("TAPPING");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => ViewPost(
                                  postId: widget.data['id'],
                                )));
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
                    text: '${widget.data['like'].length}',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                TextSpan(
                    text: "  Likes",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ]))),
          Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: widget.data['userName'],
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                TextSpan(
                    text: "  ${widget.data['description']}",
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
