import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/controller/auth_controller.dart';
import 'package:dating_app/controller/post_controller.dart';
import 'package:dating_app/controller/profile_controller.dart';
import 'package:dating_app/view/add_post.dart';
import 'package:dating_app/view/description.dart';
import 'package:dating_app/view/login.dart';
import 'package:dating_app/view/setting.dart';
import 'package:dating_app/view/view_post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/secure_storage.dart';
import '../controller/ads_service.dart';
import '../widgets/post_item.dart';
import '../widgets/story_item.dart';
import 'gallery_post.dart';
import 'get_coins.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

const int maxFailedLoadAttempts = 3;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  bool _isSearching = false;
  final TextEditingController _searchQueryController = TextEditingController();
  final TextEditingController categoryNameController = TextEditingController();

  final postController = Get.put(PostController());
  bool loading = false;
  String? userId;
  List<String> selectedCategory = [];
  var userSubscription;

  int _numRewardedLoadAttempts = 0;
  CarouselController controller = CarouselController();
  int pageIndex = 0;

  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  String? searchedValue;
  List<String> holdingCategories = [];
  RewardedAd? _rewardedAd;
  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();
    _createRewardedAd();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    Future.delayed(Duration.zero, () => fetchData());
    Future.delayed(Duration.zero, () => fetchUserList());
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdMobService.rewardedAdUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            debugPrint('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  showRewardedAd(data) {
    if (_rewardedAd == null) {
      debugPrint('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      postController.adCoins(data['id'], userId, data['postedBy']);
    });

    _rewardedAd = null;
  }

  @override
  void dispose() {
    super.dispose();

    _rewardedAd?.dispose();
    // _rewardedInterstitialAd?.dispose();
  }

  Future<dynamic> fetchUserList() async {
    setState(() {
      loading = true;
    });
    // getImageController.contentTypeSearched("All");
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // selectedCategory = prefs.getStringList('selectedGames')!;
    await postController.getUsers(null);
    await postController.getCategories();

    userId = await UserSecureStorage.fetchToken();
    userSubscription = await UserSecureStorage.fetchUserSubscription();
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

  Future<dynamic> searchDataList(searchedDta, type) async {
    setState(() {
      loading = true;
    });
    // getImageController.contentTypeSearched("All");

    await postController.searchPostList(searchedDta, type);

    setState(() {
      loading = false;
    });
  }

  Future<void> addToSP(List<String> tList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < tList.length; i++) {
      holdingCategories.add(tList[i]);
    }
    prefs.setStringList('selectedGames', holdingCategories);

    selectedCategory = prefs.getStringList('selectedGames')!;
  }

  Widget _buildSearchField() {
    return Text(
      'Select Category',
      style: TextStyle(
        color: Colors.white54,
        fontSize: 18.sp,
      ),
    );
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
            onPressed: () async {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  Future.delayed(Duration.zero, () => fetchData());
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
                            Icons.read_more,
                            color: Colors.red,
                          ),
                          title: const Text('All'),
                          onTap: () {
                            Future.delayed(Duration.zero, () => fetchData());
                            Navigator.pop(context);
                          },
                        ),
                        // ListTile(
                        //   leading: const Icon(
                        //     Icons.diamond,
                        //     color: Colors.amber,
                        //   ),
                        //   title: const Text('Most gold'),
                        //   onTap: () {
                        //     searchDataList('mostGold', null);
                        //     Navigator.pop(context);
                        //   },
                        // ),
                        // ListTile(
                        //   leading: const Icon(
                        //     Icons.rocket,
                        //     color: Colors.red,
                        //   ),
                        //   title: const Text('Best'),
                        //   onTap: () {},
                        // ),
                        ListTile(
                          leading: const Icon(
                            Icons.settings,
                            color: Colors.purple,
                          ),
                          title: const Text('New'),
                          onTap: () {
                            searchDataList('new', 'date');
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

                Timer(const Duration(milliseconds: 300),
                    () => Get.delete<ProfileController>());
                Timer(const Duration(milliseconds: 300),
                    () => Get.delete<AuthController>());
                Timer(const Duration(milliseconds: 300),
                    () => Get.delete<PostController>());

                Get.offUntil(GetPageRoute(page: () => const LoginScreen()),
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
                itemCount: postController.categoryList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      selectedCategory.contains(postController
                              .categoryList[index]['categoryName'])
                          ? selectedCategory.remove(postController
                              .categoryList[index]['categoryName'])
                          : addToSP([
                              postController.categoryList[index]
                                  ['categoryName'],
                            ]);
                      setState(() {});
                    },
                    child: ListTile(
                      trailing: Container(
                          decoration: BoxDecoration(
                              color: selectedCategory.contains(postController
                                      .categoryList[index]['categoryName'])
                                  ? Colors.red
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(30.r)),
                          child: IconButton(
                            icon: Icon(
                              selectedCategory.contains(postController
                                      .categoryList[index]['categoryName'])
                                  ? Icons.minimize
                                  : Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: null,
                          )),
                      title: Text(
                        postController.categoryList[index]['categoryName'],
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      leading: const Icon(
                        Icons.category,
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
                  SizedBox(
                    height: 10.h,
                  ),
                  selectedCategory.isNotEmpty
                      ? GetBuilder<PostController>(builder: (postController) {
                          return Padding(
                            padding: EdgeInsets.only(left: 8.0.w),
                            child: SizedBox(
                              height: 40.h,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: selectedCategory.length,
                                itemBuilder: (builde, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await postController.updateColor(index);
                                      Future.delayed(
                                        Duration.zero,
                                        () => searchDataList(
                                            selectedCategory[index],
                                            'category'),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 2.0.w, right: 2.0.w),
                                      child: Container(
                                        decoration: filterButtonStyle(index),
                                        child: FittedBox(
                                            child: Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Text(
                                            selectedCategory[index],
                                            style: filterButtonTextStyle(index),
                                          ),
                                        )),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        })
                      : const SizedBox(),
                  SizedBox(
                    height: 10.h,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: GetBuilder(
                              init: postController,
                              builder: (context) {
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
                    width: myBanner.size.width.toDouble(),
                    height: myBanner.size.height.toDouble(),
                    child: AdWidget(ad: myBanner),
                  ),
                  GetBuilder(
                      init: postController,
                      builder: (context) {
                        return Container(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: postController.postList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = postController.postList[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 7.h, horizontal: 10.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 40.w,
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              data[
                                                                  'userImage']),
                                                          fit: BoxFit.cover)),
                                                ),
                                                SizedBox(
                                                  width: 15.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0.w),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            data['userName'],
                                                            style: TextStyle(
                                                                color: black,
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                            data['postType'],
                                                            style: TextStyle(
                                                                color: Color(
                                                                    AppTheme
                                                                        .primaryColor),
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0.w),
                                                      child: Text(
                                                        '${timeago.format((data['postedAt'] as Timestamp).toDate())}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      data['mediaUrl'].length != 0
                                          ? Container(
                                              height: 200.h,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: CarouselSlider.builder(
                                                options: CarouselOptions(
                                                  autoPlay: true,
                                                  enlargeCenterPage: true,
                                                  enableInfiniteScroll:
                                                      data['mediaUrl'].length <=
                                                              1
                                                          ? false
                                                          : true,
                                                  viewportFraction: 0.9,
                                                  aspectRatio: 2.0,
                                                  initialPage: 2,
                                                ),
                                                itemCount:
                                                    data['mediaUrl'].length,
                                                itemBuilder: (BuildContext
                                                            context,
                                                        int itemIndex,
                                                        int pageViewIndex) =>
                                                    Stack(
                                                  children: [
                                                    Container(
                                                      height: 200.h,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Image.network(
                                                        data['mediaUrl']
                                                            [itemIndex],
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.r)),
                                                      child: Text(
                                                        "${itemIndex + 1}"
                                                        "/"
                                                        "${data['mediaUrl'].length}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                          : SizedBox(),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 15.w, right: 15.w, top: 3.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                GetBuilder(
                                                    init: postController,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          if (data['like']
                                                              .contains(
                                                                  userId)) {
                                                            postController
                                                                .removePostLike(
                                                              data['id'],
                                                              userId,
                                                            );
                                                          } else {
                                                            postController
                                                                .getPostLike(
                                                              data['id'],
                                                              userId,
                                                            );
                                                          }
                                                        },
                                                        child: Container(
                                                          child: data['like']
                                                                  .contains(
                                                                      userId)
                                                              ? SvgPicture
                                                                  .asset(
                                                                  "assets/images/loved_icon.svg",
                                                                  width: 27.w,
                                                                  color: Colors
                                                                      .black,
                                                                )
                                                              : SvgPicture
                                                                  .asset(
                                                                  "assets/images/love_icon.svg",
                                                                  width: 27.w,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                        ),
                                                      );
                                                    }),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (builder) =>
                                                                    ViewPost(
                                                                      postId: data[
                                                                          'id'],
                                                                    )));
                                                  },
                                                  child: SvgPicture.asset(
                                                    "assets/images/comment_icon.svg",
                                                    width: 27.w,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                userId == data['postedBy']
                                                    ? SizedBox()
                                                    : GestureDetector(
                                                        onTap: () async {
                                                          final equipmentCollection =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "users")
                                                                  .doc(userId);

                                                          final docSnap =
                                                              await equipmentCollection
                                                                  .get();

                                                          var queue = docSnap
                                                              .get('coins');
                                                          print(queue);
                                                          if (queue != 0) {
                                                            postController.giveCoin(
                                                                data['id'],
                                                                userId,
                                                                data[
                                                                    'postedBy']);
                                                          } else {
                                                            Dialogs.materialDialog(
                                                                lottieBuilder:
                                                                    LottieBuilder
                                                                        .asset(
                                                                            'assets/images/5084-gold-coin.json'),
                                                                color: Colors
                                                                    .white,
                                                                msg:
                                                                    'Watch ads for send a gold or buy golds!',
                                                                title:
                                                                    'Send a gold',
                                                                context:
                                                                    context,
                                                                actions: [
                                                                  IconsButton(
                                                                    onPressed:
                                                                        () {
                                                                      showRewardedAd(
                                                                          data);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    text:
                                                                        'Watch Add',
                                                                    iconData: Icons
                                                                        .video_collection,
                                                                    color: Color(
                                                                        AppTheme
                                                                            .primaryColor),
                                                                    textStyle: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                    iconColor:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                  IconsButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                              MaterialPageRoute(builder: (builder) => GetCoins()));
                                                                    },
                                                                    text: 'Buy',
                                                                    iconData: Icons
                                                                        .diamond_outlined,
                                                                    color: Colors
                                                                        .blue,
                                                                    textStyle: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                    iconColor:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                ]);
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.diamond,
                                                          color: Colors.amber,
                                                          size: 35.sp,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.w, right: 15.w),
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: '${data['like'].length}',
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black)),
                                            TextSpan(
                                                text: "  Likes",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ]))),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 15.w, right: 15.w),
                                          child: RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: data['userName'],
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black)),
                                            TextSpan(
                                                text:
                                                    "  ${data['description']}",
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ]))),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                    ],
                                  ),
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
      child: const Text("OK"),
      onPressed: () {},
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        'Create Category',
        style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
      ),
      content: TextField(
        controller: categoryNameController,
        autofocus: true,
        decoration: const InputDecoration(
            labelText: 'Category Name', hintText: 'eg. Funny'),
      ),
      actions: <Widget>[
        ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            }),
        ElevatedButton(
            child: const Text('Submit'),
            onPressed: () async {
              try {
                var uniqueId =
                    FirebaseFirestore.instance.collection("category").doc().id;

                FirebaseFirestore.instance
                    .collection('category')
                    .doc(uniqueId)
                    .set({
                  'categoryName': categoryNameController.text.trim(),
                  'id': uniqueId,
                });
                await postController.getCategories();
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Category submitted");
              } catch (e) {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Category failed");
              }
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

  filterButtonTextStyle(index) {
    if (index == postController.filterbutton) {
      return AppTheme.themeFilledButtonTextStyle;
    } else {
      return TextStyle(
        color: Color(AppTheme.primaryColor),
        fontWeight: FontWeight.bold,
        // fontFamily: AppTheme.acherusGrotesqueFamilyMedium,
      );
    }
  }

  filterButtonStyle(index) {
    if (index == postController.filterbutton) {
      return BoxDecoration(
          border: Border.all(
            color: Color(AppTheme.primaryColor),
          ),
          color: Color(AppTheme.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(3.r)));
    } else {
      return BoxDecoration(
          border: Border.all(
            color: Color(AppTheme.primaryColor),
          ),
          borderRadius: BorderRadius.all(Radius.circular(3.r)));
    }
  }
}
