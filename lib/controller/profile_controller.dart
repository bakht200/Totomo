import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../services/helper_functions.dart';

class ProfileController extends GetxController {
  List userInformation = [];

  HelperFunction helperFunction = HelperFunction();

  getUserData() async {
    var response = await helperFunction.getUserInformation();
    if (response != null) {
      userInformation = response;
      update();
    }
  }
}
