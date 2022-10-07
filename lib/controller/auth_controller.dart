import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/view/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../constants/secure_storage.dart';
import '../view/stepper_form.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

class AuthController extends GetxController {
  SignUpFunction(email, password, name, age, gender, context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = FirebaseAuth.instance.currentUser!;

      await UserSecureStorage.setToken(user.uid);

      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'fullName': name,
        'email': email,
        'passowrd': password,
        'age': age,
        'gender': gender,
        'profileCompleted': false,
        'profileImage': '',
        'description': '',
        'interests': '',
        'habbits': '',
        'city': '',
        'region': '',
        'perfecture': '',
        'userType': 'free',
        'subscriptionTime':'',
      });

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get();

      await UserSecureStorage.setUserName(snapshot.docs[0]['fullName']);

      Navigator.of(context).pop();

      Navigator.of(context).push(
        MaterialPageRoute(builder: (builder) => FormPage()),
      );
    } catch (e) {
      Navigator.of(context).pop();

      Fluttertoast.showToast(msg: e.toString());
    }
  }

  profileCompletion(File profilePath, description, interests, habbits, city,
      country, perfecture, context) async {
    try {
      List<String> url = [];
      User user = FirebaseAuth.instance.currentUser!;
      final path =
          firebaseStorage.FirebaseStorage.instance.ref("datingApp/${user.uid}");

      final child = path.child(DateTime.now().toString());

      await child.putFile(File(profilePath.path));

      await child.getDownloadURL().then((value) => {url.add(value)});

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({
        'profileCompleted': true,
        'profileImage': url,
        'description': description,
        'interests': interests,
        'habbits': habbits,
        'city': city,
        'region': country,
        'perfecture': perfecture,
        'userType': 'free'
      });
      Navigator.of(context).pop();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => Dashboard(
                    index: 0,
                  )),
          (Route<dynamic> route) => false);
    } catch (e) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
