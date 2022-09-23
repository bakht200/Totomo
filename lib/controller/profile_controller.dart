import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../services/helper_functions.dart';

class ProfileController extends GetxController {
  List userInformation = [];
  List<File> files = [];

  HelperFunction helperFunction = HelperFunction();
  FilePickerResult? galleryFile;

  getUserData() async {
    var response = await helperFunction.getUserInformation();
    if (response != null) {
      userInformation = response;
      update();
    }
  }

  selectImages() async {
    galleryFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg',
          'png',
          'mp4',
        ],
        allowMultiple: true);

    if (galleryFile != null) {
      print(files);
      files.addAll(galleryFile!.paths.map((path) => File(path!)).toList());
    }
    update();
  }
}
