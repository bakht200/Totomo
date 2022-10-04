import 'package:dating_app/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../services/helper_functions.dart';

class PostController extends GetxController {
  List postList = [];
  List viewPostList = [];

  List userList = [];
  List categoryList = [];

  var searchList;
  var filterbutton;

  HelperFunction helperFunction = HelperFunction();

  updateColor(int index) async {
    filterbutton = index;
    update();
  }

  getPostList(var postId) async {
    if (postId != null) {
      var response = await helperFunction.getpostList(postId);
      if (response != null) {
        viewPostList = response;
        print(viewPostList);
      }
    } else {
      var response = await helperFunction.getpostList(postId);
      if (response != null) {
        postList = response;
      }
    }
    update();
  }

  searchPostList(postData, type) async {
    var response = await helperFunction.getSearchPostList(postData, type);
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

  getCategories() async {
    var response = await helperFunction.getCategoryList();
    if (response != null) {
      categoryList = response;
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
      getPostList(null);
      Fluttertoast.showToast(msg: "Comment Added.");
    }
    update();
  }

  getPostLike(id, userId) async {
    var response = await helperFunction.likepost(id, userId);
    if (response == "Updated") {
      getPostList(null);
    }
    update();
  }

  removePostLike(id, userId) async {
    var response = await helperFunction.unLikePost(id, userId);
    if (response == "Updated") {
      getPostList(null);
    }
    update();
  }
}
