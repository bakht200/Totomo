import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/primary_button_widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int currentStep = 0;
  List interestList = [
    {'title': 'Movies', 'image': 'assets/images/love.png'},
    {'title': 'Cooking', 'image': 'assets/images/cup.png'},
    {'title': 'Entertaintment', 'image': 'assets/images/businessman.png'},
    {'title': 'Game', 'image': 'assets/images/love.png'},
    {'title': 'Watching', 'image': 'assets/images/cup.png'},
    {'title': 'Running', 'image': 'assets/images/businessman.png'},
    {'title': 'Sleeping', 'image': 'assets/images/cup.png'},
    {'title': 'Laughing', 'image': 'assets/images/businessman.png'},
    {'title': 'Reading', 'image': 'assets/images/cup.png'},
    {'title': 'Coding', 'image': 'assets/images/love.png'},
    {'title': 'Writing', 'image': 'assets/images/cup.png'},
    {'title': 'Sports', 'image': 'assets/images/cup.png'},
    {'title': 'Outdoor', 'image': 'assets/images/businessman.png'},
    {'title': 'Travelling', 'image': 'assets/images/businessman.png'},
  ];

  List idealMatch = [
    {'title': 'Love', 'image': 'assets/images/love.png'},
    {'title': 'Friends', 'image': 'assets/images/love-birds.png'},
    {'title': 'Business', 'image': 'assets/images/businessman.png'},
    {'title': 'Fling', 'image': 'assets/images/cup.png'},
  ];

  List<int> selectedItems = [];
  List<int> ideaSelectedItem = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            height: 600.h,
            width: 500.w,
            child: Theme(
              data: ThemeData(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Color(AppTheme.primaryColor),
                    secondary: Color(AppTheme.primaryColor)),
              ),
              child: Stepper(
                controlsBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.all(20.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                            width: 70.w,
                            height: 45.h,
                            child: theme_primary_button_widget(
                                primaryColor: Color(AppTheme.primaryColor),
                                textColor: const Color(0xFFFAFAFA),
                                onpressFunction: () {
                                  bool isLastStep =
                                      (currentStep == getSteps().length - 1);
                                  if (isLastStep) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => Dashboard()),
                                        (Route<dynamic> route) => false);
                                  } else {
                                    setState(() {
                                      currentStep += 1;
                                    });
                                  }
                                },
                                title: 'Next')),
                        SizedBox(
                            width: 70.w, //
                            height: 45.h,
                            child: theme_primary_button_widget(
                                primaryColor: Colors.black,
                                textColor: const Color(0xFFFAFAFA),
                                onpressFunction: () {
                                  currentStep == 0
                                      ? null
                                      : setState(() {
                                          currentStep -= 1;
                                        });
                                },
                                title: 'Back')),
                        // SizedBox(
                        //     width: 70.w, //
                        //     height: 45.h,
                        //     child: theme_primary_button_widget(
                        //         primaryColor: Colors.red,
                        //         textColor: const Color(0xFFFAFAFA),
                        //         onpressFunction: () {
                        //           Navigator.of(context).pop();
                        //         },
                        //         title: 'Logout')),
                      ],
                    ),
                  );
                },
                elevation: 0,
                type: StepperType.horizontal,
                currentStep: currentStep,
                steps: getSteps(),
              ),
            )),
      ),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text(
          "Upload Profile",
          style: TextStyle(
              fontSize: 13.sp, fontWeight: FontWeight.bold, color: black),
        ),
        content: Column(
          children: [
            GestureDetector(
              onTap: () {
                ImagePicker.platform.getImage(source: ImageSource.gallery);
              },
              child: Container(
                height: 200.h,
                width: 500.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(AppTheme.primaryColor)),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image,
                      color: Color(AppTheme.primaryColor),
                    ),
                    Text(
                      'Select an Image',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: black),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 200.h,
              width: 500.w,
              child: Container(
                margin: EdgeInsets.all(12.r),
                child: TextField(
                  maxLines: 15,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    hintText: "Enter a description",
                    fillColor: Colors.grey[200],
                    filled: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text(
          "Interests",
          style: TextStyle(
              fontSize: 13.sp, fontWeight: FontWeight.bold, color: black),
        ),
        content: Column(
          children: [
            Text(
              'Select a few of your interests to match with users who have similar things in common.',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            Container(
              height: 400.h,
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: (1 / .4),
                shrinkWrap: true,
                children: List.generate(
                  interestList.length,
                  (index) {
                    return Padding(
                        padding: EdgeInsets.all(10.0.w),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedItems.contains(index)) {
                                selectedItems.remove(index);
                              } else {
                                selectedItems.add(index);
                              }
                            });
                          },
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            child: Center(
                              child: Row(
                                children: [
                                  Image.asset(
                                    interestList[index]['image'],
                                    height: 25.h,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text(
                                    interestList[index]['title'],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 2,
                                color: selectedItems.contains(index)
                                    ? Color(AppTheme.primaryColor)
                                    : Colors.white,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r),
                                  bottomLeft: Radius.circular(10.r),
                                  bottomRight: Radius.circular(10.r)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(AppTheme.primaryColor)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text(
          "Ideal Match",
          style: TextStyle(
              fontSize: 13.sp, fontWeight: FontWeight.bold, color: black),
        ),
        content: Column(
          children: [
            Text(
              'What are you hopping to find on the totomo app?',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 350.h,
              child: GridView.count(
                physics: BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 10.0,
                shrinkWrap: true,
                children: List.generate(
                  idealMatch.length,
                  (index) {
                    return Padding(
                        padding: EdgeInsets.all(10.0.w),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (ideaSelectedItem.contains(index)) {
                                ideaSelectedItem.remove(index);
                              } else {
                                ideaSelectedItem.add(index);
                              }
                            });
                          },
                          child: Container(
                            height: 20.h,
                            width: 20.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  idealMatch[index]['image'],
                                  height: 80.h,
                                ),
                                Text(
                                  idealMatch[index]['title'],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 2,
                                color: ideaSelectedItem.contains(index)
                                    ? Color(AppTheme.primaryColor)
                                    : Colors.white,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r),
                                  bottomLeft: Radius.circular(10.r),
                                  bottomRight: Radius.circular(10.r)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(AppTheme.primaryColor)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ];
  }
}
