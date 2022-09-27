import 'package:badges/badges.dart';
import 'package:dating_app/view/search_page.dart';
import 'package:dating_app/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';
import '../view/chat_detail_page.dart';

class FindFriendList extends StatefulWidget {
  String? name;
  String? messageText;
  String? imageUrl;
  String? time;
  bool? isMessageRead;
  FindFriendList(
      {@required this.name,
      @required this.messageText,
      @required this.imageUrl,
      @required this.time,
      @required this.isMessageRead});
  @override
  _FindFriendListState createState() => _FindFriendListState();
}

class _FindFriendListState extends State<FindFriendList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return ChatDetailPage();
        // }));
      },
      child: Container(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h, bottom: 10.h),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl!),
                    maxRadius: 30.r,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.name!,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              )
                            ],
                          ),
                          Text(
                            '(M)',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            widget.messageText!,
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            'Tokyo, Japan',
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey.shade600,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                width: 80.w,
                height: 30.h,
                child: theme_primary_button_widget(
                    primaryColor: Color(AppTheme.primaryColor),
                    textColor: const Color(0xFFFAFAFA),
                    onpressFunction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => SearchPage()),
                      );
                    },
                    title: 'Message')),
          ],
        ),
      ),
    );
  }
}
