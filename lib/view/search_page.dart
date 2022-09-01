import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/primary_button_widget.dart';
import '../widgets/search_category_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: getBody());
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
                const SizedBox(
                  width: 15,
                ),
                Container(
                  width: size.width - 30,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
                children: List.generate(5, (index) {
              return const CategoryStoryItem(
                name: 'CateogryName',
              );
            })),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
            height: size.height / .5,
            child: GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.all(7.0.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 16,
                    childAspectRatio: (size.width / (size.height - 100.h)).w,
                    crossAxisCount: 3,
                    crossAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Color(AppTheme.primaryColor))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            flex: 2,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                                width: 90.w, //
                                height: 30.h,
                                child: theme_primary_button_widget(
                                    primaryColor: Color(AppTheme.primaryColor),
                                    textColor: const Color(0xFFFAFAFA),
                                    onpressFunction: () {
                                      // Navigator.of(context).push(
                                      // //   MaterialPageRoute(
                                      // //       builder: (builder) => Dashboard()),
                                      // );
                                    },
                                    title: 'Message')),
                          ),
                        ],
                      ),
                    ),
                  );
                }))
      ],
    ));
  }
}
