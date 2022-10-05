import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/view/messaging/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/secure_storage.dart';
import '../../services/helper_functions.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  HelperFunction databaseMethods = new HelperFunction();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot? searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    await databaseMethods.getAllUsers().then((snapshot) {
      setState(() {
        searchResultSnapshot = snapshot;

        isLoading = false;
        haveUserSearched = true;
      });
    });
  }

  searchUserName(String value) async {
    if (value.isNotEmpty) {
      await databaseMethods.searchByName(value).then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          haveUserSearched = true;
          print(searchResultSnapshot?.docs.first["fullName"]);
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? Container(
            height: MediaQuery.of(context).size.height / 1.2,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchResultSnapshot?.docs.length,
                itemBuilder: (context, index) {
                  return userTile(
                    searchResultSnapshot?.docs[index]["fullName"],
                    searchResultSnapshot?.docs[index]["profileImage"][0],
                    "${searchResultSnapshot?.docs[index]["region"]}, ${searchResultSnapshot?.docs[index]["city"]}",
                  );
                }),
          )
        : Container();
  }

  /// 1.create a chatroom, send user to the chatroom, other userdetails
  sendMessage(String userName) async {
    String? name = await UserSecureStorage.fetchUserName();
    List<String> users = [name!, userName];

    String chatRoomId = getChatRoomId(name, userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId": chatRoomId,
    };

    databaseMethods.addChatRoom(chatRoom, chatRoomId);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  chatRoomId: chatRoomId,
                  sendTo: userName,
                )));
  }

  Widget userTile(String userName, String profileImage, String userEmail) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(profileImage),
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.black54, fontSize: 14.sp),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              sendMessage(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Color(AppTheme.primaryColor),
                  borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Message",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        automaticallyImplyLeading: false,
        title: Text(
          "Conversations",
          style: TextStyle(
              fontSize: 22.sp, fontWeight: FontWeight.bold, color: white),
        ),
        centerTitle: false,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      color: Color.fromARGB(82, 161, 204, 169),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: searchEditingController,
                              onChanged: (value) {
                                searchUserName(value);
                              },
                              decoration: InputDecoration(
                                  hintText: "search username ...",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // searchUserName();
                            },
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(54, 157, 185, 169),
                                          Color.fromARGB(15, 89, 127, 96)
                                        ],
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight),
                                    borderRadius: BorderRadius.circular(40)),
                                padding: EdgeInsets.all(12),
                                child: Image.asset(
                                  "assets/images/search_white.png",
                                  height: 25,
                                  width: 25,
                                  color: Colors.black,
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              initiateSearch();
                            },
                            child: Icon(Icons.refresh),
                          )
                        ],
                      ),
                    ),
                    userList()
                  ],
                ),
              ),
            ),
    );
  }
}
