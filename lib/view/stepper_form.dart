import 'dart:io';

import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/controller/auth_controller.dart';
import 'package:dating_app/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
    {'title': 'Friends', 'image': 'assets/images/high-five.png'},
    {'title': 'Business', 'image': 'assets/images/businessman.png'},
    {'title': 'Fling', 'image': 'assets/images/cup.png'},
  ];

  List<int> selectedItems = [];
  List<int> ideaSelectedItem = [];

  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController description = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController perfecture = TextEditingController();
  TextEditingController city = TextEditingController();

  List<String> selectedInterestNames = [];
  List<String> selectedIdealNames = [];

  final authCotntroller = Get.put(AuthController());

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
                                onpressFunction: () async {
                                  bool isLastStep =
                                      (currentStep == getSteps().length - 1);
                                  if (isLastStep) {
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

                                    await authCotntroller.profileCompletion(
                                        imageFile!,
                                        description.text.trim(),
                                        selectedInterestNames,
                                        selectedIdealNames,
                                        city.text.trim(),
                                        country.text.trim(),
                                        perfecture.text.trim(),
                                        context);
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

  _getFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(image!.path);
    });
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 12.sp, color: black),
        ),
        content: Column(
          children: [
            GestureDetector(
              onTap: () {
                _getFromGallery();
              },
              child: Container(
                height: 200.h,
                width: 500.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(AppTheme.primaryColor)),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: imageFile == null
                    ? Column(
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
                      )
                    : Image.file(imageFile!),
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
                  controller: description,
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
          "Interest",
          style: TextStyle(fontSize: 12.sp, color: black),
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
                                selectedInterestNames.removeWhere((element) =>
                                    element == interestList[index]['title']);
                              } else {
                                selectedItems.add(index);

                                selectedInterestNames
                                    .add(interestList[index]['title']);
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
          style: TextStyle(fontSize: 12.sp, color: black),
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
                                selectedIdealNames.removeWhere((element) =>
                                    element == interestList[index]['title']);
                                ideaSelectedItem.remove(index);
                              } else {
                                ideaSelectedItem.add(index);
                                selectedIdealNames
                                    .add(interestList[index]['title']);
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
      Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: Text(
          "Location",
          style: TextStyle(fontSize: 12.sp, color: black),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.0.w),
              child: Text(
                'Enter your Country',
                style: TextStyle(
                    fontSize: 12.sp, color: black, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100.h,
              width: 500.w,
              child: Container(
                margin: EdgeInsets.all(12.r),
                child: TextField(
                  controller: country,
                  maxLines: 15,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    hintText: "Enter your Country",
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.0.w),
              child: Text(
                'Enter your Perfecture',
                style: TextStyle(
                    fontSize: 12.sp, color: black, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100.h,
              width: 500.w,
              child: Container(
                margin: EdgeInsets.all(12.r),
                child: TextField(
                  controller: perfecture,
                  maxLines: 15,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    hintText: "Enter your Perfecture",
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.0.w),
              child: Text(
                'Enter your City',
                style: TextStyle(
                    fontSize: 12.sp, color: black, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 100.h,
              width: 500.w,
              child: Container(
                margin: EdgeInsets.all(12.r),
                child: TextField(
                  controller: city,
                  maxLines: 15,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    hintText: "Enter your City",
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    ];
  }
}
