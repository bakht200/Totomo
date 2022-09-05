import 'package:dating_app/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 32.sp,
            ),
          ),
        ),
      ),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _ProfileHeader(
              numberOfPosts: 0,
            ),
          ),
          SliverToBoxAdapter(
            child: _EditProfileButton(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
          SliverFillRemaining(child: _NoPostsMessage())
        ],
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            border: Border.all(color: Color(AppTheme.appBarBackgroundColor))),
        child: OutlinedButton(
          onPressed: () {
            // TODO handle onPressed
          },
          child: Text(
            'Edit Profile',
            style: TextStyle(
              color: Color(AppTheme.primaryColor),
              fontSize: 14.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
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
                  child: Column(
                    children: [
                      Text(
                        '15',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        'Premium Users',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Full name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                )
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
    return Column(children: [
      Expanded(
        flex: 5,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
          child: Wrap(
              spacing: 2,
              runSpacing: 5,
              children: List.generate(12, (index) {
                return Container(
                  width: 70.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHw%3D&w=1000&q=80',
                          ),
                          fit: BoxFit.cover)),
                );
              })),
        ),
      )
    ]);
  }
}
