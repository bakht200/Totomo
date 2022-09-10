import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/view/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        body: SingleChildScrollView(
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
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sophia',
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _EditProfileButton(),
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
                    interestList.length,
                    (index) {
                      return Padding(
                          padding: EdgeInsets.all(7.0.w),
                          child: GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   if (selectedItems.contains(index)) {
                              //     selectedItems.remove(index);
                              //   } else {
                              //     selectedItems.add(index);
                              //   }
                              // });
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
              ),
              _NoPostsMessage(),
            ],
          ),
        ));
  }
}

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton({Key? key}) : super(key: key);

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
                'Hi i am sophi i am from china i am learning spanish feel free to talk to me Hi i am sophi i am from china i am learning spanish feel free to talk to me',
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

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    Key? key,
    required this.numberOfPosts,
  }) : super(key: key);

  final int numberOfPosts;

  static const _statitisticsPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 8.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30.r,
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: _statitisticsPadding,
                  child: Column(
                    children: [
                      Text(
                        '$numberOfPosts',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'Posts',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: _statitisticsPadding,
                  child: Column(
                    children: [
                      Text(
                        '12',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'Find Friends',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: _statitisticsPadding,
                  child: SizedBox(
                    width: 40.w,
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          child: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Column(
                    children: [
                      Text(
                        "Full name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Josh',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
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
                        ),
                      ),
                      Text(
                        'Japan',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
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
                        ),
                      ),
                      Text(
                        'Tokyo',
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
          ),
        ),
      ],
    );
  }
}

class _NoPostsMessage extends StatelessWidget {
  const _NoPostsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
          child: Wrap(
              spacing: 2,
              runSpacing: 5,
              children: List.generate(12, (index) {
                return Container(
                  width: 70.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
                          ),
                          fit: BoxFit.cover)),
                );
              })),
        )
      ]),
    );
  }
}
