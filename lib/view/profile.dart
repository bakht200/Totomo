import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/controller/profile_controller.dart';
import 'package:dating_app/view/edit_profile.dart';
import 'package:dating_app/view/phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:get/get.dart';

import 'authentication_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List interestList = [
    {'title': 'Movies', 'image': 'assets/images/love.png'},
    {'title': 'Cooking', 'image': 'assets/images/cup.png'},
    {'title': 'Entertaintment', 'image': 'assets/images/businessman.png'},
    {'title': 'Game', 'image': 'assets/images/love.png'},
  ];

  List<int> selectedItems = [];
  final profileController = Get.put(ProfileController());
  bool? loading;

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
    await profileController.getUserPost();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Color(AppTheme.appBarBackgroundColor),
          title: Text(
            "Profile",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0.w),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => EditProfilePage()));
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        body: loading == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150.h,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/googlemap.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 30.r,
                            backgroundImage: NetworkImage(profileController
                                .userInformation.first['profileImage'][0]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    profileController
                                        .userInformation.first['fullName'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.diamond,
                                    color: Colors.amber,
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Country",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              profileController.userInformation
                                                  .first['country'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0.w),
                                        child: Column(
                                          children: [
                                            Text(
                                              "City",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            Text(
                                              profileController.userInformation
                                                  .first['city'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (builder) =>
                                          AuthenticationScreen()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(AppTheme.primaryColor)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Verify",
                                      style: TextStyle(
                                          color: Color(AppTheme.primaryColor),
                                          fontSize: 16.0.sp,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _EditProfileButton(
                      profileController.userInformation.first['description'],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: Row(
                        children: [
                          Text(
                            'Interest',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 140.h,
                      child: GridView.count(
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: (1 / .35),
                        shrinkWrap: true,
                        children: List.generate(
                          profileController
                              .userInformation.first['interests'].length,
                          (index) {
                            return Padding(
                                padding: EdgeInsets.all(7.0.w),
                                child: GestureDetector(
                                  onTap: () {},
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
                                            profileController.userInformation
                                                .first['interests'][index],
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
                    ),
                    SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 8.0.w),
                              child: Text(
                                'Recent Posts',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GetBuilder(
                                init: profileController,
                                builder: (context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black38)),
                                    child: Wrap(
                                        spacing: 2,
                                        runSpacing: 5,
                                        children: List.generate(
                                            profileController.userPost.length,
                                            (index) {
                                          return Container(
                                              width: 70.w,
                                              height: 100.h,
                                              child: ListView.builder(
                                                  itemCount: profileController
                                                      .userPost[index]
                                                          ['mediaUrl']
                                                      .length,
                                                  itemBuilder:
                                                      ((context, _index) {
                                                    return FullScreenWidget(
                                                      child: Container(
                                                          width: 70.w,
                                                          height: 100.h,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: NetworkImage(
                                                                    profileController.userPost[index]
                                                                            [
                                                                            'mediaUrl']
                                                                        [
                                                                        _index],
                                                                  ),
                                                                  fit: BoxFit.cover))),
                                                    );
                                                  }))
                                              // decoration: BoxDecoration(
                                              //     image: DecorationImage(
                                              //         image: NetworkImage(
                                              //           '',
                                              //         ),
                                              //         fit: BoxFit.cover)),
                                              );
                                        })),
                                  );
                                })
                          ]),
                    )
                  ],
                ),
              ));
  }
}

class _EditProfileButton extends StatelessWidget {
  var description;

  _EditProfileButton(this.description);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0.w),
          child: Text(
            'Self Introduction',
            style: TextStyle(
              color: Colors.black,
              fontSize: 17.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: 70.h,
          width: 500.w,
          child: Container(
              margin: EdgeInsets.all(12.w),
              child: Text(
                description,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.normal,
                ),
              )),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        //   child: Container(
        //     height: 40.h,
        //     width: 450.w,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(6.r),
        //         border:
        //             Border.all(color: Color(AppTheme.appBarBackgroundColor))),
        //     child: OutlinedButton(
        //       onPressed: () {
        //         Navigator.of(context).push(
        //             MaterialPageRoute(builder: (builder) => EditProfilePage()));
        //       },
        //       child: Text(
        //         'Edit Profile',
        //         style: TextStyle(
        //           color: Color(AppTheme.primaryColor),
        //           fontSize: 14.0.sp,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
