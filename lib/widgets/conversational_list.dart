import 'package:badges/badges.dart';
import 'package:dating_app/view/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/chat_detail_page.dart';

class ConversationList extends StatefulWidget {
  String? name;

  String? imageUrl;
  String? country;

  ConversationList({
    @required this.name,
    @required this.imageUrl,
    @required this.country,
  });
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchPage();
        }));
      },
      child: Container(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h, bottom: 10.h),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name!,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            '${widget.country}',
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
          ],
        ),
      ),
    );
  }
}
