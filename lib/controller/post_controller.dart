import 'package:get/get.dart';

import '../services/helper_functions.dart';

class PostController extends GetxController {
  List postList = [];

  HelperFunction helperFunction = HelperFunction();

  getPostList() async {
    var response = await helperFunction.getpostList();
    if (response != null) {
      postList = response;
    }
    update();
  }
}
