import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/view/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_theme.dart';
import '../controller/profile_controller.dart';
import '../widgets/primary_button_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  var loading;
  bool showPassword = false;
  bool edited = false;
  final profileController = Get.put(ProfileController());
  PickedFile? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future fetchUserData() async {
    setState(() {
      loading = true;
    });
    await profileController.getUserData();
    nameController.text = profileController.userInformation.first['firstName'];

    emailController.text = profileController.userInformation.first['email'];
    passwordController.text =
        profileController.userInformation.first['passowrd'];
    bioController.text = profileController.userInformation.first['description'];

    setState(() {
      loading = false;
    });
  }

  Future getImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;

      if (edited == false) {
        edited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
      ),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(left: 16.w, top: 25.h, right: 16.w),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130.w,
                              height: 130.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4.w,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                      ))),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 4.w,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      color: Colors.green,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      buildTextField("Full Name", "Dor Alex", false, [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z]+|\s"),
                        )
                      ], (value) {
                        if (value!.isEmpty) {
                          return 'Enter Firstname';
                        }
                      }, edited, nameController),
                      buildTextField(
                          "E-mail",
                          "alexd@gmail.com",
                          false,
                          emailController,
                          (val) => val!.isEmpty || !val.contains("@")
                              ? "Enter a valid email"
                              : null,
                          edited,
                          emailController),
                      buildTextField("Password", "********", true, [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z]+|\s"),
                        )
                      ], (value) {
                        if (value!.isEmpty) {
                          return 'Enter Firstname';
                        }
                      }, edited, passwordController),
                      buildTextField("Bio", "Hi i'm, Dor Alex", false, [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z]+|\s"),
                        )
                      ], (value) {
                        if (value!.isEmpty) {
                          return 'Enter Firstname';
                        }
                      }, edited, bioController),
                      SizedBox(
                        height: 35.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 120.w, //
                              height: 45.h,
                              child: theme_primary_button_widget(
                                  primaryColor: Color(AppTheme.primaryColor),
                                  textColor: Color(0xFFFAFAFA),
                                  onpressFunction: () async {
                                    if (edited == true) {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (_) {
                                            return Dialog(
                                              backgroundColor: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                      if (_formKey.currentState!.validate()) {
                                        String? url;
                                        User? user =
                                            FirebaseAuth.instance.currentUser;
                                        if (_image != null) {
                                          final path = firebaseStorage
                                              .FirebaseStorage.instance
                                              .ref("datingApp/${user!.uid}");

                                          final child = path
                                              .child(DateTime.now().toString());
                                          await child
                                              .putFile(File(_image!.path));
                                          await child
                                              .getDownloadURL()
                                              .then((value) => url = value);
                                        }

                                        await FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(user?.uid)
                                            .update({
                                          'uid': user!.uid,
                                          'fullName':
                                              nameController.text.trim(),
                                          'email': emailController.text.trim(),
                                          'passowrd':
                                              passwordController.text.trim(),
                                          'description':
                                              bioController.text.trim()
                                        });

                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                            msg:
                                                "Profile Updated Successfully");
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) => Dashboard()));
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please edit profile");
                                    }
                                  },
                                  title: 'Save')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildTextField(
      String labelText,
      String placeholder,
      bool isPasswordTextField,
      var inputFormatters,
      var validator,
      var edited,
      var controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35.0.h),
      child: TextField(
        onChanged: (_) {
          if (edited == false) {
            edited = true;
          }
        },
        inputFormatters: inputFormatters,
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0.w),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.0),
            ),
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
