import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/controller/post_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../constants/secure_storage.dart';
import '../widgets/profile_avatar.dart';

class ViewPost extends StatefulWidget {
  var postId;

  ViewPost({
    Key? key,
    required this.postId,
  }) : super(key: key);
  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  bool loading = false;
  final getPostContainer = Get.put(PostController());
  String? userId;

  @override
  void initState() {
    Future.delayed(Duration.zero, () => fetchData());

    super.initState();
  }

  Future<dynamic> fetchData() async {
    setState(() {
      loading = true;
    });
    print(widget.postId);
    // getImageController.contentTypeSearched("All");

    await getPostContainer.getPostList(widget.postId);
    print(getPostContainer.viewPostList);
    userId = await UserSecureStorage.fetchToken();
    setState(() {
      loading = false;
    });
  }

  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        title: Text(
          'View Post',
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        centerTitle: false,
      ),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : GetBuilder(
              init: getPostContainer,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          ProfileAvatar(
                              imageUrl: getPostContainer
                                  .viewPostList.first['userImage']),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getPostContainer.viewPostList.first['userName'],
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
                                    "${timeago.format((getPostContainer.viewPostList.first['postedAt'] as Timestamp).toDate())}",
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
                      ),
                      const SizedBox(height: 4.0),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0.w),
                        child: Text(
                          getPostContainer.viewPostList.first['description'],
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 20.sp),
                        ),
                      ),
                      getPostContainer.viewPostList.first['mediaUrl'].length !=
                              0
                          ? Container(
                              height: 200.h,
                              //  width: MediaQuery.of(context).size.width,
                              child: CarouselSlider.builder(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: getPostContainer
                                              .viewPostList
                                              .first['mediaUrl']
                                              .length <=
                                          1
                                      ? false
                                      : true,
                                  viewportFraction: 0.9,
                                  aspectRatio: 2.0,
                                  initialPage: 2,
                                ),
                                itemCount: getPostContainer
                                    .viewPostList.first['mediaUrl'].length,
                                itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) =>
                                    Stack(
                                  children: [
                                    Container(
                                      height: 200.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                        getPostContainer.viewPostList
                                            .first['mediaUrl'][itemIndex],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5.r)),
                                      child: Text(
                                        "${itemIndex + 1}"
                                        "/"
                                        "${getPostContainer.viewPostList.first['mediaUrl'].length}",
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
                      // Padding(
                      //   padding: EdgeInsets.only(left: 8.0.w, right: 10.w),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       // Container(
                      //       //     padding: const EdgeInsets.all(4.0),
                      //       //     decoration: BoxDecoration(
                      //       //       shape: BoxShape.circle,
                      //       //     ),
                      //       //     child: SvgPicture.asset(
                      //       //       "assets/images/loved_icon.svg",
                      //       //       width: 27.w,
                      //       //       color: Colors.black,
                      //       //     )),
                      //       // const SizedBox(width: 4.0),
                      //       // Expanded(
                      //       //   child: Text(
                      //       //     "${widget.data['like'].length}",
                      //       //     style: TextStyle(
                      //       //       color: Colors.grey[600],
                      //       //     ),
                      //       //   ),
                      //       // ),
                      //       // Container(
                      //       //   padding: const EdgeInsets.all(4.0),
                      //       //   decoration:  BoxDecoration(
                      //       //     color: Color(AppTheme.primaryColor),
                      //       //     shape: BoxShape.circle,
                      //       //   ),
                      //       //   child: const Icon(
                      //       //     Icons.report,
                      //       //     size: 10.0,
                      //       //     color: Colors.white,
                      //       //   ),
                      //       // ),
                      //       // const SizedBox(width: 4.0),
                      //       // Text(
                      //       //   "${widget.data['report'].length}",
                      //       //   style: TextStyle(
                      //       //     color: Colors.grey[600],
                      //       //   ),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                      Text(
                        'Comments',
                        style: TextStyle(
                          color: Color(AppTheme.primaryColor),
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.2,
                        ),
                      ),
                      getPostContainer.viewPostList.first['comment'].length != 0
                          ? GetBuilder(
                              init: getPostContainer,
                              builder: (context) {
                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: getPostContainer
                                        .viewPostList.first['comment'].length,
                                    itemBuilder: ((context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            color: Color.fromARGB(
                                                255, 189, 208, 196),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor: Color(AppTheme
                                                        .appBarBackgroundColor),
                                                    child: Text(
                                                      "${getPostContainer.viewPostList.first['comment'][index]['commentedBy'].substring(0, 1)}",
                                                      style: TextStyle(
                                                          fontSize: 14.0.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  title: Text(
                                                    getPostContainer
                                                            .viewPostList
                                                            .first['comment']
                                                        [index]['commentedBy'],
                                                    style: TextStyle(
                                                      fontSize: 13.0.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        getPostContainer
                                                                    .viewPostList
                                                                    .first[
                                                                'comment'][index]
                                                            ['commentText'],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14.sp),
                                                      ),
                                                      Text(
                                                        " ${timeago.format((getPostContainer.viewPostList.first['comment'][index]['commentedAt'] as Timestamp).toDate())}",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12.sp),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                        ],
                                      );
                                    }));
                              })
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
                                  maxLines: 6, //or null
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Enter your text here"),
                                ),
                              ))),
                      GetBuilder(
                          init: getPostContainer,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.w),
                              child: Container(
                                padding: EdgeInsets.only(top: 3.h, left: 3.w),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 30.h,
                                  onPressed: () async {
                                    var userName =
                                        await UserSecureStorage.fetchUserName();
                                    await getPostContainer.submitComment(
                                        getPostContainer
                                            .viewPostList.first['id'],
                                        userName,
                                        commentController.text,
                                        context);
                                    await getPostContainer
                                        .getPostList(widget.postId);
                                    commentController.clear();
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
                            );
                          }),
                    ],
                  ),
                );
              }),
    );
  }
}
