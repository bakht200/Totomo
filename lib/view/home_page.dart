import 'package:dating_app/constants/app_theme.dart';

import 'package:dating_app/view/add_post.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/post_item.dart';
import '../widgets/story_item.dart';
import 'gallery_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            title: "Gallery",
            iconColor: Colors.white,
            bubbleColor: Color(AppTheme.primaryColor),
            icon: Icons.photo,
            titleStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
            onPress: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => GalleryPostScreen()));
              _animationController?.reverse();
            },
          ),
          Bubble(
            title: "Camera",
            iconColor: Colors.white,
            bubbleColor: Color(AppTheme.primaryColor),
            icon: Icons.camera,
            titleStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
            onPress: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (builder) => CameraPostScreen()));
              _animationController?.reverse();
            },
          ),
        ],
        animation: _animation!,
        onPress: () => _animationController!.isCompleted
            ? _animationController?.reverse()
            : _animationController?.forward(),
        iconColor: Colors.white,
        iconData: Icons.add,
        backGroundColor: Color(AppTheme.primaryColor),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Row(
                      children: List.generate(10, (index) {
                    return StoryItem(
                      img:
                          'https://st2.depositphotos.com/3310833/7828/v/380/depositphotos_78289624-stock-illustration-flat-hipster-character.jpg?forcejpeg=true',
                      name: 'Story',
                    );
                  })),
                ),
              ],
            ),
          ),
          Divider(
            color: white.withOpacity(0.3),
          ),
          Column(
            children: List.generate(5, (index) {
              return PostItem(
                postImg:
                    'https://st2.depositphotos.com/3310833/7828/v/380/depositphotos_78289624-stock-illustration-flat-hipster-character.jpg?forcejpeg=true',
                profileImg:
                    'https://st2.depositphotos.com/3310833/7828/v/380/depositphotos_78289624-stock-illustration-flat-hipster-character.jpg?forcejpeg=true',
                name: 'Bakht',
                caption: 'Hello here man how are you',
                isLoved: true,
                viewCount: '5',
                likedBy: 'likesBy',
              );
            }),
          )
        ],
      ),
    );
  }
}
