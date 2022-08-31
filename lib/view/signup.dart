import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/model/gender_model.dart';
import 'package:dating_app/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

import '../widgets/gender_selection_widget.dart';
import '../widgets/primary_button_widget.dart';
import '../widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<Gender> genders = [];

  int _currentValue = 1;
  String? selectedGender;

  @override
  void initState() {
    genders.add(Gender("Male", MdiIcons.genderMale, false));
    genders.add(Gender("Female", MdiIcons.genderFemale, false));
    genders.add(Gender("Others", MdiIcons.genderTransgender, false));
    super.initState();
  }

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
          padding: EdgeInsets.only(left: 12.0.w, right: 12.w),
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
                        'Hi,Welcome!',
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
                    'Connect with your friends today!',
                    style: TextStyle(
                        color: Color.fromARGB(221, 76, 67, 67),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 3.0.h),
                        child: Text(
                          'Enter Full Name',
                          style: TextStyle(
                            color: Color.fromARGB(221, 76, 67, 67),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      TextFieldWidget(
                        hintText: 'Full Name',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0.h),
                        child: Text(
                          'Enter Email Address',
                          style: TextStyle(
                            color: Color.fromARGB(221, 76, 67, 67),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      TextFieldWidget(
                        hintText: 'Email Address',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0.h),
                        child: Text(
                          'Enter Password',
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

                  //NUMBER PICKER
                  SizedBox(
                    height: 5.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0.h),
                        child: Text(
                          'How old are you?',
                          style: TextStyle(
                            color: Color.fromARGB(221, 76, 67, 67),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 15.0.w,
                                  vertical: 15.0.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.0.w,
                                ),
                                alignment: Alignment.center,
                                height: 40.h,
                              ),
                              Positioned(
                                  child: Container(
                                height: 50.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 15.0.r,
                                      spreadRadius: 1.0.r,
                                      offset: const Offset(
                                        0.0,
                                        0.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                              Container(
                                alignment: Alignment.center,
                                child: NumberPicker(
                                  axis: Axis.horizontal,
                                  itemHeight: 45.h,
                                  itemWidth: 45.0.w,
                                  step: 1,
                                  selectedTextStyle: TextStyle(
                                    fontSize: 20.0.sp,
                                    color: Color.fromARGB(255, 48, 69, 48),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0.sp,
                                  ),
                                  itemCount: 7,
                                  value: _currentValue,
                                  minValue: 1,
                                  maxValue: 100,
                                  onChanged: (v) {
                                    setState(() {
                                      _currentValue = v;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: genders.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            splashColor: Colors.pinkAccent,
                            onTap: () {
                              setState(() {
                                for (var gender in genders) {
                                  gender.selected = false;
                                }
                                genders[index].selected = true;
                                selectedGender = genders[index].name;
                                print(selectedGender);
                              });
                            },
                            child: CustomRadio(genders[index]),
                          );
                        }),
                  ),
/////
                  ///
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                      width: double.infinity, //
                      height: 45.h,
                      child: theme_primary_button_widget(
                          primaryColor: Color(AppTheme.primaryColor),
                          textColor: Color(0xFFFAFAFA),
                          onpressFunction: () {},
                          title: 'Sign Up')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: Colors.black,
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
                      'Sign In',
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
