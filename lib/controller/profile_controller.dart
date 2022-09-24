import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/view/dashboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  removeSelectedImage(index) async {
    print(index);
    files.removeWhere((element) => element == files[index]);
    update();
  }

  insertPost(
      file, descriptionController, context, postType, imagePath, type) async {
    var response;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Loading...')
                ],
              ),
            ),
          );
        });
    print("calling upload file function");
    if (type == "cameraPost") {
      response = await helperFunction.cameraPost(
          file, descriptionController, postType, imagePath);
    } else {
      response = await helperFunction.uploadFile(
          file, descriptionController, postType, imagePath);
    }

    if (response == "filedUploaded") {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Post Added.");
      files.clear();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (builder) => Dashboard()));
    }
  }
}
