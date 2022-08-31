import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/view/signup.dart';
import 'package:dating_app/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/primary_button_widget.dart';
import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                      TextFieldWidget(hintText: 'Email Address'),
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
                          onpressFunction: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (builder) => Dashboard()),
                            );
                          },
                          title: 'Login')),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
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
    );
  }
}
