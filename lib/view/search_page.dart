import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/view/chat_detail_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/primary_button_widget.dart';
import '../widgets/search_category_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool filterType = false;

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
              "Search",
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 32.sp,
              ),
            ),
          ),
        ),
        body: getBody());
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
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: black.withOpacity(0.3),
                        )),
                    style: TextStyle(color: white.withOpacity(0.3)),
                    cursorColor: white.withOpacity(0.3),
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: Row(
                children: List.generate(5, (index) {
              return const CategoryStoryItem(
                name: 'CateogryName',
              );
            })),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
            height: size.height / .5,
            child: filterType
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.all(7.0.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          padding: EdgeInsets.all(8.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                  radius: 40.r,
                                  backgroundImage: const NetworkImage(
                                    'https://www.fivesquid.com/pics/t2/1568868712-108802-1-1.jpg',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'UserName',
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
                                  child: const Text(
                                    'Hello here i am Josh he is ',
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
                                        textColor: const Color(0xFFFAFAFA),
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
                    })
                : ListView.builder(
                    itemCount: 15,
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
                                backgroundImage: const NetworkImage(
                                  'https://www.fivesquid.com/pics/t2/1568868712-108802-1-1.jpg',
                                ),
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'UserName',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    )
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    height: 35.h,
                                    width: 100.w,
                                    child: const Text(
                                      'Hello here i am Josh he is ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            trailing: SizedBox(
                                width: 90.w,
                                height: 30.h,
                                child: theme_primary_button_widget(
                                    primaryColor: Color(AppTheme.primaryColor),
                                    textColor: const Color(0xFFFAFAFA),
                                    onpressFunction: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                ChatDetailPage()),
                                      );
                                    },
                                    title: 'Message')),
                          ),
                        ),
                      );
                    }))
      ],
    ));
  }
}
