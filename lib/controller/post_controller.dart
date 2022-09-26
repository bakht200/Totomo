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
}
