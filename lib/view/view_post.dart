import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/controller/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants/secure_storage.dart';
import '../widgets/profile_avatar.dart';

class ViewPost extends StatefulWidget {
  var data;
  var userId;

  ViewPost({@required this.data, @required userId});
  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(AppTheme.primaryColor)),
        backgroundColor: Colors.white,
        title: Text(
          'View Post',
          style: TextStyle(
            color: Color(AppTheme.primaryColor),
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: ViewContainer(data: widget.data, userId: widget.userId),
    );
  }
}

class ViewContainer extends StatefulWidget {
  var data;

  var userId;

  ViewContainer({@required this.data, @required userId});
  @override
  State<ViewContainer> createState() => _ViewContainerState();
}

class _ViewContainerState extends State<ViewContainer> {
  @override
  Widget build(BuildContext context) {
    final getPostContainer = Get.put(PostController());
    TextEditingController commentController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(left: 10.0.w),
      child: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),
          _PostHeader(post: widget.data!),
          const SizedBox(height: 4.0),
          Padding(
            padding: EdgeInsets.only(left: 10.0.w),
            child: Text(widget.data!['description']),
          ),
          widget.data['mediaUrl'].length != 0
              ? Container(
                  height: 200.h,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.data['mediaUrl'].length,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: FullScreenWidget(
                              child: Image.network(widget.data['mediaUrl'][i]),
                            ));
                      }),
                )
              : SizedBox(),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Color(AppTheme.primaryColor),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/images/loved_icon.svg",
                      width: 27.w,
                      color: Colors.black,
                    )),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    "${widget.data['like'].length}",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.all(4.0),
                //   decoration:  BoxDecoration(
                //     color: Color(AppTheme.primaryColor),
                //     shape: BoxShape.circle,
                //   ),
                //   child: const Icon(
                //     Icons.report,
                //     size: 10.0,
                //     color: Colors.white,
                //   ),
                // ),
                // const SizedBox(width: 4.0),
                // Text(
                //   "${widget.data['report'].length}",
                //   style: TextStyle(
                //     color: Colors.grey[600],
                //   ),
                // ),
              ],
            ),
          ),
          Text(
            'Comments',
            style: TextStyle(
              color: Color(AppTheme.primaryColor),
              fontSize: 20.0.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2,
            ),
          ),
          widget.data['comment'].length != 0
              ? Container(
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.data['comment'].length,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Container(
                            color: Color.fromARGB(255, 189, 208, 196),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        Color(AppTheme.primaryColor),
                                    child: Text(
                                        "${widget.data['comment'][index]['commentedBy'].substring(0, 1)}"),
                                  ),
                                  title: Text(
                                    widget.data['comment'][index]
                                        ['commentedBy'],
                                    style: TextStyle(
                                      fontSize: 15.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    " ${timeago.format((widget.data['comment'][index]['commentedAt'] as Timestamp).toDate())}",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.sp),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 40.0.w),
                                  child: Text(
                                    widget.data['comment'][index]
                                        ['commentText'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14.sp),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
                )
              : SizedBox(),
          SizedBox(
            height: 10.h,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(AppTheme.primaryColor),
                        width: 2,
                      )),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: commentController,
                      maxLines: 8, //or null
                      decoration: InputDecoration.collapsed(
                          hintText: "Enter your text here"),
                    ),
                  ))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Container(
              padding: EdgeInsets.only(top: 3.h, left: 3.w),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 30.h,
                onPressed: () async {
                  var userName = await UserSecureStorage.fetchUserName();
                  await getPostContainer.submitComment(widget.data['id'],
                      userName, commentController.text, context);
                },
                color: Color(AppTheme.primaryColor),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  "Comment",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  var post;

  _PostHeader({this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post['userImage']),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['userName'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            // Text(
            //   (post['useIdentity'] == 'Yes' && post['location'] != null)
            //       ? post['location']
            //       : 'No Location',
            //   style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            // ),
            Row(
              children: [
                Text(
                  "${timeago.format((post['postedAt'] as Timestamp).toDate())}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.0,
                  ),
                ),
                Icon(
                  Icons.public,
                  color: Colors.grey[600],
                  size: 12.0,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
