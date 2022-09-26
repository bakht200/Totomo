import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/view/chat_detail_page.dart';
import 'package:dating_app/view/profile.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../constants/secure_storage.dart';
import '../controller/post_controller.dart';
import '../model/gender_model.dart';
import '../widgets/gender_selection_widget.dart';
import '../widgets/primary_button_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool filterType = false;
  List<Gender> genders = [];
  bool _switchValue = true;

  int _currentValue = 1;
  String? selectedGender;
  int _groupValue = -1;
  final double _min = 18;
  final double _max = 60;
  SfRangeValues _values = const SfRangeValues(40.0, 60.0);
  final postController = Get.put(PostController());
  bool loading = false;
  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    genders.add(Gender("Male", MdiIcons.genderMale, false));
    genders.add(Gender("Female", MdiIcons.genderFemale, false));
    genders.add(Gender("Others", MdiIcons.genderTransgender, false));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Color(AppTheme.appBarBackgroundColor),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0.w),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      isDismissible: false,
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.94,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0),
                                topRight: Radius.circular(25.0),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(4.0.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.all(8.0.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Icon(Icons.close)),
                                        Text(
                                          'Search by',
                                          style: TextStyle(
                                            color: black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 8.w,
                                                right: 8.w,
                                                top: 2.h,
                                                bottom: 2.h),
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                              color:
                                                  Color(AppTheme.primaryColor),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.refresh,
                                                  color: Colors.white,
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 2.w,
                                                ),
                                                Text(
                                                  "Reset",
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      flex: 9,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Region/City',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.sp,
                                              )),
                                          ListTile(
                                            leading: Icon(
                                              Icons.location_pin,
                                              color: Colors.red,
                                              size: 25.h,
                                            ),
                                            title: Text('Region',
                                                style: TextStyle(
                                                  color: Color(0xFF555555),
                                                  fontSize: 15.sp,
                                                )),
                                            trailing: Wrap(
                                              spacing: 5,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5.0.h),
                                                  child: Icon(
                                                    Icons.navigate_next,
                                                    size: 35.sp,
                                                    color: Color(
                                                        AppTheme.primaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.location_city,
                                              color: Colors.red,
                                              size: 25.h,
                                            ),
                                            title: Row(
                                              children: [
                                                Text('Prefecture',
                                                    style: TextStyle(
                                                      color: Color(0xFF555555),
                                                      fontSize: 15.sp,
                                                    )),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                )
                                              ],
                                            ),
                                            trailing: Wrap(
                                              spacing: 5,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5.0.h),
                                                  child: Icon(
                                                    Icons.navigate_next,
                                                    size: 35.sp,
                                                    color: Color(
                                                        AppTheme.primaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.location_pin,
                                              color: Colors.deepOrange,
                                              size: 25.h,
                                            ),
                                            title: Row(
                                              children: [
                                                Text('City',
                                                    style: TextStyle(
                                                      color: Color(0xFF555555),
                                                      fontSize: 15.sp,
                                                    )),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                )
                                              ],
                                            ),
                                            trailing: Wrap(
                                              spacing: 5,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5.0.h),
                                                  child: Icon(
                                                    Icons.navigate_next,
                                                    size: 35.sp,
                                                    color: Color(
                                                        AppTheme.primaryColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            leading: Icon(
                                              Icons.location_pin,
                                              color: Colors.red,
                                              size: 25.h,
                                            ),
                                            title: Row(
                                              children: [
                                                Text('Nearest',
                                                    style: TextStyle(
                                                      color: Color(0xFF555555),
                                                      fontSize: 15.sp,
                                                    )),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                )
                                              ],
                                            ),
                                            trailing: Wrap(
                                              spacing: 5,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 5.0.h),
                                                  child: CupertinoSwitch(
                                                    value: _switchValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _switchValue = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Text('Gender',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                  )),
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 50.h,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: genders.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                      splashColor:
                                                          Colors.pinkAccent,
                                                      onTap: () {
                                                        setState(() {
                                                          for (var gender
                                                              in genders) {
                                                            gender.selected =
                                                                false;
                                                          }
                                                          genders[index]
                                                              .selected = true;
                                                          selectedGender =
                                                              genders[index]
                                                                  .name;
                                                          print(selectedGender);
                                                        });
                                                      },
                                                      child: Card(
                                                          color: genders[index]
                                                                  .selected
                                                              ? Color(AppTheme
                                                                  .primaryColor)
                                                              : Colors
                                                                  .grey[300],
                                                          child: Container(
                                                            height: 70.h,
                                                            width: 70.w,
                                                            alignment: Alignment
                                                                .center,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5.0.w),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  genders[index]
                                                                      .name,
                                                                  style: TextStyle(
                                                                      color: genders[index].selected
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black38),
                                                                )
                                                              ],
                                                            ),
                                                          )));
                                                }),
                                          ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Text('User Type',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                  )),
                                            ],
                                          ),
                                          _myRadioButton(
                                            title: "All Member",
                                            value: 0,
                                            onChanged: (newValue) => setState(
                                                () => _groupValue = newValue),
                                          ),
                                          _myRadioButton(
                                            title: "VIP",
                                            value: 1,
                                            onChanged: (newValue) => setState(
                                                () => _groupValue = newValue),
                                          ),
                                          Divider(),
                                          Row(
                                            children: [
                                              Text('Age',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17.sp,
                                                  )),
                                            ],
                                          ),
                                          SfRangeSlider(
                                            activeColor:
                                                Color(AppTheme.primaryColor),
                                            min: _min,
                                            max: _max,
                                            values: _values,
                                            interval: 5,
                                            showTicks: true,
                                            showLabels: true,
                                            onChanged: (SfRangeValues value) {
                                              setState(() {
                                                _values = value;
                                                print(value);
                                              });
                                            },
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width: double.infinity, //
                                        height: 45.h,
                                        child: theme_primary_button_widget(
                                            primaryColor:
                                                Color(AppTheme.primaryColor),
                                            textColor: Color(0xFFFAFAFA),
                                            onpressFunction: () {},
                                            title: 'Search')),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      });
                },
                child: Image.asset('assets/images/filter.png',
                    color: Colors.white, width: 15.w),
              ),
            ),
          ],
          title: Text(
            "Search",
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
        ),
        body: getBody());
  }

  Widget _myRadioButton({String? title, int? value, onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: value == 0
          ? Text(title!)
          : Row(
              children: [
                Text(title!),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                )
              ],
            ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: size.width - 55.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.grey.shade200),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search by name',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: black.withOpacity(0.3),
                        )),
                    style: TextStyle(color: black.withOpacity(0.3)),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  child: filterType
                      ? Image.asset(
                          'assets/images/row.png',
                          height: 30.h,
                          width: 20.w,
                        )
                      : Image.asset(
                          'assets/images/layout.png',
                          height: 30.h,
                          width: 20.w,
                        ),
                  onTap: () {
                    setState(() {
                      if (filterType) {
                        filterType = false;
                      } else {
                        filterType = true;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
            height: size.height / .5,
            child: filterType
                ? GetBuilder(
                    init: postController,
                    builder: (context) {
                      return GridView.builder(
                          itemCount: postController.userList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: EdgeInsets.all(7.0.w),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 16.w,
                                  childAspectRatio:
                                      (size.width / (size.height - 100.h)).w,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10.h),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      color: Color(AppTheme.primaryColor))),
                              child: Padding(
                                padding: EdgeInsets.all(6.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CircleAvatar(
                                        radius: 40.r,
                                        backgroundImage: NetworkImage(
                                          postController.userList[index]
                                              ['profileImage'][0],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            postController.userList[index]
                                                ['fullName'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height: 35.h,
                                        width: 100.w,
                                        child: Text(
                                          postController.userList[index]
                                              ['description'],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                          width: 90.w, //
                                          height: 30.h,
                                          child: theme_primary_button_widget(
                                              primaryColor:
                                                  Color(AppTheme.primaryColor),
                                              textColor:
                                                  const Color(0xFFFAFAFA),
                                              onpressFunction: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (builder) =>
                                                          ChatDetailPage()),
                                                );
                                              },
                                              title: 'Message')),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    })
                : GetBuilder(
                    init: postController,
                    builder: (context) {
                      return ListView.builder(
                          itemCount: postController.userList.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(5.0.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        color: Color(AppTheme.primaryColor))),
                                child: ListTile(
                                  leading: Padding(
                                    padding: EdgeInsets.only(bottom: 2.0.h),
                                    child: CircleAvatar(
                                      radius: 40.r,
                                      backgroundImage: NetworkImage(
                                        postController.userList[index]
                                            ['profileImage'][0],
                                      ),
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            postController.userList[index]
                                                ['fullName'],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        postController.userList[index]
                                            ['description'],
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            MdiIcons.map,
                                            color: Colors.blue,
                                          ),
                                          Text(postController.userList[index]
                                              ['country']),
                                          const Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                          ),
                                          Text(postController.userList[index]
                                              ['city']),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      ChatDetailPage()),
                                            );
                                          },
                                          child: Icon(
                                            Icons.message_rounded,
                                            color: Colors.black,
                                          )),
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      ProfilePage()),
                                            );
                                          },
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }))
      ],
    ));
  }
}
