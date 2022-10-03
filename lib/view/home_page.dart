import 'dart:async';

import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/controller/auth_controller.dart';
import 'package:dating_app/controller/post_controller.dart';
import 'package:dating_app/controller/profile_controller.dart';

import 'package:dating_app/view/add_post.dart';
import 'package:dating_app/view/description.dart';
import 'package:dating_app/view/login.dart';
import 'package:dating_app/view/setting.dart';
import 'package:dating_app/view/subscription_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../constants/secure_storage.dart';
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
  final postController = Get.put(PostController());
  bool loading = false;
  String? userId;

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    myBanner.load();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    Future.delayed(Duration.zero, () => fetchData());
    Future.delayed(Duration.zero, () => fetchUserList());

    super.initState();
  }

  Future<dynamic> fetchUserList() async {
    setState(() {
      loading = true;
    });
    // getImageController.contentTypeSearched("All");

    await postController.getUsers();
    userId = await UserSecureStorage.fetchToken();
    setState(() {
      loading = false;
    });
  }

  Future<dynamic> fetchData() async {
    setState(() {
      loading = true;
    });
    // getImageController.contentTypeSearched("All");

    await postController.getPostList(null);
    userId = await UserSecureStorage.fetchToken();
    setState(() {
      loading = false;
    });
  }

  List searchCategories = ['cat', 'blog', 'funny', 'weather', 'sports', 'news'];

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
                            Icons.diamond,
                            color: Colors.amber,
                          ),
                          title: const Text('Most gold'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
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
                //  onTap: ,
                value: 2,
                child: Row(
                  children: [
                    const Icon(Icons.category, color: Colors.white),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      "Create Category",
                      style: TextStyle(
                        color: white,
                        fontSize: 18.sp,
                      ),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
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
            onSelected: (value) async {
              print(value);
              if (value == 1) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => SettingPage()));
              } else if (value == 3) {
                await FirebaseAuth.instance.signOut();
                await UserSecureStorage.deleteSecureStorage();

                Timer(Duration(milliseconds: 300),
                    () => Get.delete<ProfileController>());
                Timer(Duration(milliseconds: 300),
                    () => Get.delete<AuthController>());
                Timer(Duration(milliseconds: 300),
                    () => Get.delete<PostController>());

                Get.offUntil(GetPageRoute(page: () => LoginScreen()),
                    ModalRoute.withName('toNewLogin'));
              } else if (value == 2) {
                showAlertDialog(context);
              }
            },
          ),
        ],
        title: _isSearching
            ? _buildSearchField()
            : Row(
                children: [
                  Text(
                    "Totomo",
                    style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    "Homepage",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18.sp,
                    ),
                  ),
                ],
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
                itemCount: searchCategories.length,
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
                      trailing: Container(
                          decoration: BoxDecoration(
                              color: (index == 2 || index == 3)
                                  ? (Colors.green)
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(30.r)),
                          child: IconButton(
                            icon: Icon(
                              (index == 2 || index == 3)
                                  ? Icons.add
                                  : Icons.minimize,
                              color: Colors.white,
                            ),
                            onPressed: null,
                          )),
                      title: Text(
                        searchCategories[index].toString(),
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
    return loading == true
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: fetchData,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: GetBuilder(
                              init: postController,
                              builder: (context) {
                                print(postController.userList.length);
                                return Row(
                                    children: List.generate(
                                        postController.userList.length,
                                        (index) {
                                  return StoryItem(
                                    img: postController.userList[index]
                                        ['profileImage'][0],
                                    name: postController.userList[index]
                                        ['fullName'],
                                  );
                                }));
                              }),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: white.withOpacity(0.3),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: AdWidget(ad: myBanner),
                    width: myBanner.size.width.toDouble(),
                    height: myBanner.size.height.toDouble(),
                  ),
                  GetBuilder(
                      init: postController,
                      builder: (context) {
                        return Container(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: postController.postList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return PostItem(
                                  data: postController.postList[index],
                                  userId: userId,
                                  controller: postController,
                                );
                              }),
                        );
                      }),
                ],
              ),
            ),
          );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        'Create Category',
        style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
      ),
      content: TextField(
        autofocus: true,
        decoration:
            InputDecoration(labelText: 'Category Name', hintText: 'eg. Funny'),
      ),
      actions: <Widget>[
        FlatButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            }),
        FlatButton(
            child: const Text('Submit'),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
