import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/view/signup.dart';
import 'package:dating_app/view/stepper_form.dart';
import 'package:dating_app/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/secure_storage.dart';
import '../widgets/primary_button_widget.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hi,Welcome Back!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Image.asset(
                            'assets/images/handwave.gif',
                            height: 60.h,
                          )
                        ],
                      ),
                      Text(
                        'Hello again,you\'ve been missed!',
                        style: TextStyle(
                            color: Color.fromARGB(221, 76, 67, 67),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.0.w),
                            child: Text(
                              'Email Address',
                              style: TextStyle(
                                color: Color.fromARGB(221, 76, 67, 67),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          TextFieldWidget(
                            obsecure: false,
                            controller: email,
                            hintText: 'Email Address',
                            validator: (val) =>
                                val.isEmpty || !val.contains("@")
                                    ? "enter a valid email"
                                    : null,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.0.h),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                color: Color.fromARGB(221, 76, 67, 67),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          TextFieldWidget(
                            obsecure: true,
                            validator: (val) =>
                                val.isEmpty ? "enter password" : null,
                            controller: password,
                            hintText: 'Password',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      SizedBox(
                          width: double.infinity, //
                          height: 45.h,
                          child: theme_primary_button_widget(
                              primaryColor: Color(AppTheme.primaryColor),
                              textColor: Color(0xFFFAFAFA),
                              onpressFunction: () async {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (_) {
                                        return Dialog(
                                          backgroundColor: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
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

                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: email.text.trim(),
                                            password: password.text.trim());
                                    User? user =
                                        FirebaseAuth.instance.currentUser;

                                    await UserSecureStorage.setToken(user!.uid);

                                    await UserSecureStorage.fetchToken();

                                    final snapshot = await FirebaseFirestore
                                        .instance
                                        .collection('users')
                                        .where('uid', isEqualTo: user.uid)
                                        .get();
                                    if (snapshot.docs[0]['subscriptionTime'] !=
                                        '') {
                                      DateTime date = DateTime.parse(snapshot
                                          .docs[0]['subscriptionTime']
                                          .toDate()
                                          .toString());

                                      if (DateTime.now().isBefore(date)) {
                                        await UserSecureStorage.setUserName(
                                            snapshot.docs[0]['fullName']);
                                        await UserSecureStorage.fetchUserName();
                                        await UserSecureStorage
                                            .setUserSubscription(
                                                snapshot.docs[0]['userType']);
                                        if (snapshot.docs[0]
                                                ['profileCompleted'] ==
                                            true) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (builder) => Dashboard(
                                                      index: 0,
                                                    )),
                                          );
                                        } else {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    FormPage()),
                                          );
                                        }
                                      } else {
                                        await FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(user.uid)
                                            .update({
                                          'userType': 'free',
                                          'subscriptionTime': '',
                                        });

                                        final snapshot = await FirebaseFirestore
                                            .instance
                                            .collection('users')
                                            .where('uid', isEqualTo: user.uid)
                                            .get();

                                        await UserSecureStorage.setUserName(
                                            snapshot.docs[0]['fullName']);
                                        await UserSecureStorage.fetchUserName();
                                        await UserSecureStorage
                                            .setUserSubscription(
                                                snapshot.docs[0]['userType']);
                                        if (snapshot.docs[0]
                                                ['profileCompleted'] ==
                                            true) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (builder) => Dashboard(
                                                      index: 0,
                                                    )),
                                          );
                                        } else {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    FormPage()),
                                          );
                                        }
                                      }
                                    } else {
                                      await UserSecureStorage.setUserName(
                                          snapshot.docs[0]['fullName']);
                                      await UserSecureStorage.fetchUserName();
                                      await UserSecureStorage
                                          .setUserSubscription(
                                              snapshot.docs[0]['userType']);
                                      if (snapshot.docs[0]
                                              ['profileCompleted'] ==
                                          true) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) => Dashboard(
                                                    index: 0,
                                                  )),
                                        );
                                      } else {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (builder) => FormPage()),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    print(e.toString());
                                    Navigator.of(context).pop();
                                    Fluttertoast.showToast(msg: e.toString());
                                  }
                                }
                              },
                              title: 'Login')),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (builder) => const SignUpScreen()),
                            (route) => false);
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(AppTheme.primaryColor)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
