import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/view/login.dart';
import 'package:dating_app/view/signup.dart';
import 'package:dating_app/widgets/primary_button_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: storyBorderColor)),
        child: Padding(
          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset('assets/images/onboarding.png'))),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome\nto Totomo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0.h, bottom: 8.0.h),
                      child: Text(
                        'Connect with each other with chatting or calling. Enjoy safe and private texting',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                        width: double.infinity, //
                        height: 45.h,
                        child: theme_primary_button_widget(
                            primaryColor: Colors.white,
                            textColor: Color(AppTheme.primaryColor),
                            onpressFunction: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (builder) => const SignUpScreen()),
                              );
                            },
                            title: 'Join Now')),
                    Row(
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (builder) => const LoginScreen()),
                                (route) => false);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
