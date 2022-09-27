// import 'package:dating_app/constants/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../model/chat_message.dart';

// class ChatDetailPage extends StatefulWidget {

//    final String? chatRoomId;
//   final String? sendTo;

//   ChatDetailPage({this.chatRoomId, this.sendTo});
//   @override
//   _ChatDetailPageState createState() => _ChatDetailPageState();
// }

// class _ChatDetailPageState extends State<ChatDetailPage> {
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         flexibleSpace: SafeArea(
//           child: Container(
//             padding: EdgeInsets.only(right: 16.w),
//             child: Row(
//               children: <Widget>[
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.arrow_back,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 2.w,
//                 ),
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://randomuser.me/api/portraits/men/5.jpg"),
//                   maxRadius: 20.r,
//                 ),
//                 SizedBox(
//                   width: 12.w,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         "Kriss Benwat",
//                         style: TextStyle(
//                             fontSize: 16.sp, fontWeight: FontWeight.w600),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: 12.w,
//                 ),
//                 Icon(
//                   Icons.diamond,
//                   color: Colors.amber,
//                 ),
//                 SizedBox(
//                   width: 10.w,
//                 ),
//                 Icon(
//                   Icons.block,
//                   color: Colors.red,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           ListView.builder(
//             itemCount: messages.length,
//             shrinkWrap: true,
//             padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return Container(
//                 padding: EdgeInsets.only(
//                     left: 14.w, right: 14.w, top: 10.h, bottom: 10.h),
//                 child: Align(
//                   alignment: (messages[index].messageType == "receiver"
//                       ? Alignment.topLeft
//                       : Alignment.topRight),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.r),
//                         color: (messages[index].messageType == "receiver"
//                             ? Colors.grey.shade200
//                             : Color(AppTheme.secondaryColor))),
//                     padding: EdgeInsets.all(16.w),
//                     child: Text(
//                       messages[index].messageContent!,
//                       style: TextStyle(fontSize: 15.sp),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               padding: EdgeInsets.only(left: 10.w, bottom: 10.h, top: 10.h),
//               height: 60,
//               width: double.infinity,
//               color: Colors.white,
//               child: Row(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       height: 30.h,
//                       width: 30.w,
//                       decoration: BoxDecoration(
//                         color: Color(AppTheme.primaryColor),
//                         borderRadius: BorderRadius.circular(30.r),
//                       ),
//                       child: Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         size: 20.sp,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15.w,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                           hintText: "Write message...",
//                           hintStyle: TextStyle(color: Colors.black54),
//                           border: InputBorder.none),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15.w,
//                   ),
//                   FloatingActionButton(
//                     onPressed: () {},
//                     child: Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                     backgroundColor: Color(AppTheme.primaryColor),
//                     elevation: 0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
