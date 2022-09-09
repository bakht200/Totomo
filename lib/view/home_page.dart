import 'package:dating_app/constants/app_theme.dart';

import 'package:dating_app/view/add_post.dart';
import 'package:dating_app/view/description.dart';
import 'package:dating_app/view/setting.dart';
import 'package:dating_app/view/subscription_page.dart';
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
  bool _isSearching = false;
  final TextEditingController _searchQueryController = TextEditingController();

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

  Widget _buildSearchField() {
    return TextField(
        controller: _searchQueryController,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: "Search Data...",
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white30),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
        onChanged: (query) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                } else {
                  _isSearching = true;
                }
              });
            },
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(
                            Icons.rocket,
                            color: Colors.red,
                          ),
                          title: const Text('Best'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.settings,
                            color: Colors.purple,
                          ),
                          title: const Text('New'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            child: Image.asset('assets/images/filter.png',
                color: Colors.white, width: 15.w),
          ),
         
          PopupMenuButton<int>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    const Icon(Icons.settings, color: Colors.white),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Setting",
                      style: TextStyle(
                        color: white,
                        fontSize: 18.sp,
                      ),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: white,
                        fontSize: 18.sp,
                      ),
                    )
                  ],
                ),
              ),
            ],
            color: Color((AppTheme.appBarBackgroundColor)),
            elevation: 0,
            shape: Border.all(width: 0.5),
            offset: const Offset(0, kToolbarHeight),
            onSelected: (value) {
              if (value == 1) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => SettingPage()));
              } else if (value == 2) {
                print("LOGOUT");
              }
            },
          ),
        ],
        title: _isSearching
            ? _buildSearchField()
            : Text(
                "Totomo",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                ),
              ),
      ),
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            title: "Text",
            iconColor: Colors.white,
            bubbleColor: Color(AppTheme.primaryColor),
            icon: Icons.edit,
            titleStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
            onPress: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const DescriptionPostScreen()));
              _animationController?.reverse();
            },
          ),
          Bubble(
            title: "Gallery",
            iconColor: Colors.white,
            bubbleColor: Color(AppTheme.primaryColor),
            icon: Icons.photo,
            titleStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
            onPress: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const GalleryPostScreen()));
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => const CameraPostScreen()));
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
      body: _isSearching ? getSearchBody() : getBody(),
    );
  }

  Widget getSearchBody() {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_isSearching) {
                          _isSearching = false;
                        } else {
                          _isSearching = true;
                        }
                      });
                    },
                    child: ListTile(
                      title: Text(
                        'Title',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      leading: const Icon(
                        Icons.access_alarm_sharp,
                        color: Colors.purple,
                      ),
                    ),
                  );
                })),
      ],
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
                    return const StoryItem(
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
