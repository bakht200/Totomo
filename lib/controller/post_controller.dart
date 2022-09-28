import 'package:dating_app/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../services/helper_functions.dart';

class PostController extends GetxController {
  List postList = [];
  List userList = [];
  var searchList;

  HelperFunction helperFunction = HelperFunction();

  getPostList() async {
    var response = await helperFunction.getpostList();
    if (response != null) {
      postList = response;
    }
    update();
  }

  getUsers() async {
    var response = await helperFunction.getUserList();
    if (response != null) {
      userList = response;
    }
    update();
  }

  searchUsers(var name) async {
    var response = await helperFunction.searchByName(name);
    if (response != null) {
      searchList = response;
    }
    update();
  }

  submitComment(id, userName, commentText, context) async {
    var response = await helperFunction.addComment(id, commentText, userName);
    if (response == "Commented") {
      getPostList();
      Fluttertoast.showToast(msg: "Comment Added.");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (builder) => Dashboard(
                index: 0,
              )));
    }
    update();
  }
}
