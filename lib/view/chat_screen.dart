import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/chat_user_model.dart';
import '../widgets/conversational_list.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        imageURL:
            "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
        time: "Now"),
    ChatUsers(
        name: "Glady's Murphy",
        messageText: "That's Great",
        imageURL:
            "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
        time: "Yesterday"),
    ChatUsers(
        name: "Jorge Henry",
        messageText: "Hey where are you?",
        imageURL:
            "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
        time: "31 Mar"),
    ChatUsers(
        name: "Philip Fox",
        messageText: "Busy! Call me in 20 mins",
        imageURL:
            "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
        time: "28 Mar"),
    ChatUsers(
        name: "Debra Hawkins",
        messageText: "Thankyou, It's awesome",
        imageURL:
            "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
        time: "23 Mar"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20.sp,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8.w),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16.h),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
