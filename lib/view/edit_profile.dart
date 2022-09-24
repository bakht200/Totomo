import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/view/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
    nameController.text = profileController.userInformation.first['fullName'];

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
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 60.r,
                                backgroundColor: Color(0xff476cfb),
                                child: ClipOval(
                                  child: FullScreenWidget(
                                    child: SizedBox(
                                      width: 180.0.w,
                                      height: 180.0.h,
                                      child: (_image != null)
                                          ? Image.file(
                                              File(_image!.path),
                                              fit: BoxFit.fill,
                                            )
                                          : Image.network(
                                              profileController.userInformation
                                                              .first[
                                                          'profileImage'][0] !=
                                                      null
                                                  ? profileController
                                                      .userInformation
                                                      .first['profileImage'][0]
                                                  : "https://i.stack.imgur.com/l60Hf.png",
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 50.0.h, left: 60.w),
                              child: IconButton(
                                icon: const Icon(
                                  MdiIcons.camera,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  getImage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      buildTextField("Full Name", "Dor Alex", false, (value) {
                        if (value!.isEmpty) {
                          return 'Enter Firstname';
                        }
                      }, edited, nameController),
                      buildTextField(
                          "E-mail",
                          "alexd@gmail.com",
                          false,
                          (val) => val!.isEmpty || !val.contains("@")
                              ? "Enter a valid email"
                              : null,
                          edited,
                          emailController),
                      buildTextField("Password", "********", true, (value) {
                        if (value!.isEmpty) {
                          return 'Enter Firstname';
                        }
                      }, edited, passwordController),
                      buildTextField("Bio", "Hi i'm, Dor Alex", false, (value) {
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
      // var inputFormatters,
      var validator,
      var edited,
      TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 35.0.h),
      child: TextField(
        onChanged: (_) {
          if (edited == false) {
            edited = true;
          }
        },
        // inputFormatters: inputFormatters,
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
