// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dating_app/services/helper_functions.dart';
// import 'package:dating_app/view/chat_detail_page.dart';
// import 'package:dating_app/view/find_new_friend.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../constants/app_theme.dart';
// import '../constants/secure_storage.dart';
// import '../model/chat_user_model.dart';
// import '../widgets/conversational_list.dart';

// class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   // List<ChatUsers> chatUsers = [
//   //   ChatUsers(
//   //       name: "Jane Russel",
//   //       messageText: "Awesome Setup",
//   //       imageURL:
//   //           "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
//   //       time: "Now"),
//   //   ChatUsers(
//   //       name: "Glady's Murphy",
//   //       messageText: "That's Great",
//   //       imageURL:
//   //           "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
//   //       time: "Yesterday"),
//   //   ChatUsers(
//   //       name: "Jorge Henry",
//   //       messageText: "Hey where are you?",
//   //       imageURL:
//   //           "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
//   //       time: "31 Mar"),
//   //   ChatUsers(
//   //       name: "Philip Fox",
//   //       messageText: "Busy! Call me in 20 mins",
//   //       imageURL:
//   //           "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
//   //       time: "28 Mar"),
//   //   ChatUsers(
//   //       name: "Debra Hawkins",
//   //       messageText: "Thankyou, It's awesome",
//   //       imageURL:
//   //           "https://static.vecteezy.com/system/resources/thumbnails/002/002/280/small_2x/old-man-with-beard-wearing-glasses-avatar-character-free-vector.jpg",
//   //       time: "23 Mar"),
//   // ];
//   HelperFunction databaseMethods = new HelperFunction();

//   TextEditingController searchEditingController = new TextEditingController();
//   QuerySnapshot? searchResultSnapshot;
//   bool isLoading = false;
//   bool haveUserSearched = false;

//   initiateSearch() async {
//     await databaseMethods.getAllUsers().then((snapshot) {
//       searchResultSnapshot = snapshot;

//       setState(() {
//         isLoading = false;
//         haveUserSearched = true;
//       });
//     });
//   }

//   searchUserName() async {
//     if (searchEditingController.text.isNotEmpty) {
//       setState(() {
//         isLoading = true;
//       });
//       await databaseMethods
//           .searchByName(searchEditingController.text)
//           .then((snapshot) {
//         searchResultSnapshot = snapshot;
//         print("$searchResultSnapshot");
//         setState(() {
//           isLoading = false;
//           haveUserSearched = true;
//         });
//       });
//     }
//   }

//   sendMessage(String userName) async {
//     String? name = await UserSecureStorage.fetchUserName();
//     List<String> users = [name!, userName];

//     String chatRoomId = getChatRoomId(name, userName);

//     Map<String, dynamic> chatRoom = {
//       "users": users,
//       "chatRoomId": chatRoomId,
//     };

//     databaseMethods.addChatRoom(chatRoom, chatRoomId);

//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => ChatDetailPage(
//                   chatRoomId: chatRoomId,
//                   sendTo: userName,
//                 )));
//   }

//   getChatRoomId(String a, String b) {
//     if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//       return "$b\_$a";
//     } else {
//       return "$a\_$b";
//     }
//   }

//   @override
//   void initState() {
//     initiateSearch();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(AppTheme.appBarBackgroundColor),
//         automaticallyImplyLeading: false,
//         title: Text(
//           "Conversations",
//           style: TextStyle(
//               fontSize: 22.sp, fontWeight: FontWeight.bold, color: white),
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.all(8.0.w),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (builder) => FindFriend()));
//               },
//               child: Container(
//                 padding: EdgeInsets.only(
//                     left: 8.w, right: 8.w, top: 2.h, bottom: 2.h),
//                 height: 30.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30.r),
//                   color: Color(AppTheme.primaryColor),
//                 ),
//                 child: Row(
//                   children: <Widget>[
//                     Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 20.sp,
//                     ),
//                     SizedBox(
//                       width: 2.w,
//                     ),
//                     Text(
//                       "Add New",
//                       style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//       body: isLoading
//           ? Container(
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             )
//           : SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding:
//                         EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
//                     child: TextField(
//                       controller: searchEditingController,
//                       decoration: InputDecoration(
//                         hintText: "Search...",
//                         hintStyle: TextStyle(color: Colors.grey.shade600),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Colors.grey.shade600,
//                           size: 20.sp,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey.shade100,
//                         contentPadding: EdgeInsets.all(8.w),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20.r),
//                             borderSide:
//                                 BorderSide(color: Colors.grey.shade100)),
//                       ),
//                     ),
//                   ),
//                   haveUserSearched
//                       ? ListView.builder(
//                           itemCount: searchResultSnapshot?.docs.length,
//                           shrinkWrap: true,
//                           padding: EdgeInsets.only(top: 16.h),
//                           physics: BouncingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return ConversationList(
//                               name: searchResultSnapshot?.docs[index]
//                                   ["fullName"],
//                               imageUrl: searchResultSnapshot?.docs[index]
//                                   ["profileImage"],
//                             );
//                           },
//                         )
//                       : Container(),
//                 ],
//               ),
//             ),
//     );
//   }
// }
