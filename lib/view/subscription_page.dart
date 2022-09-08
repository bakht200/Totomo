import 'package:dating_app/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/primary_button_widget.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  var subscriptionList = [
    {
      'index': '1',
      'name': 'MONTH',
      'price': '\$399',
      'total': '\$399/mo',
    },
    {
      'index': '1',
      'name': 'YEAR',
      'price': '\$399',
      'total': '\$399/mo',
    }
  ];

  var premiumFacility = [
    {
      'icon': 'assets/images/hearts.png',
      'title': 'Search by city and gender',
    },
    {
      'icon': 'assets/images/tap.png',
      'title': 'meet more easily',
    },
    {
      'icon': 'assets/images/love.png',
      'title': 'More seen by everyone',
    },
    {
      'icon': 'assets/images/love-birds.png',
      'title': 'Access first to feature premium feature',
    },
    {
      'icon': 'assets/images/reputation.png',
      'title': 'get the VIP badge',
    },
    {
      'icon': 'assets/images/dollar-coin.png',
      'title': 'get 10 gold by months',
    },
    {
      'icon': 'assets/images/like.png',
      'title': 'use a coupon',
    },
  ];

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 219, 208),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Column(
            children: [
              Text(
                'Unlock Everything',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                  'please do this you will get free subscription and many more about this',
                  style:
                      TextStyle(fontSize: 12.sp, fontStyle: FontStyle.italic)),
              SizedBox(
                height: 120.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: subscriptionList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Stack(
                          children: [
                            Card(
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.grey[200],
                                child: Container(
                                  height: 100.h,
                                  width: 90.w,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.all(5.0.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                          subscriptionList[index]['index']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          subscriptionList[index]['name']
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10.h),
                                      Divider(
                                        height: 2.h,
                                      ),
                                      Text(
                                        subscriptionList[index]['price']
                                            .toString(),
                                        style: TextStyle(color: Colors.black38),
                                      ),
                                      Text(
                                        subscriptionList[index]['total']
                                            .toString(),
                                        style: TextStyle(color: Colors.black38),
                                      ),
                                    ],
                                  ),
                                )),
                            selectedIndex == index
                                ? Positioned(
                                    left: 4,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        color: Color(AppTheme.primaryColor),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0.w),
                                        child: Text(
                                          'Price',
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      );
                    }),
              ),
              Expanded(
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: premiumFacility.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(5.0.w),
                        child: ListTile(
                          leading: Image.asset(
                              premiumFacility[index]['icon'].toString()),
                          title:
                              Text(premiumFacility[index]['title'].toString()),
                        ),
                      );
                    }),
              ),
              SizedBox(
                  width: double.infinity, //
                  height: 45.h,
                  child: theme_primary_button_widget(
                      primaryColor: Color(AppTheme.primaryColor),
                      textColor: Color(0xFFFAFAFA),
                      onpressFunction: () {
                        Navigator.of(context).pop();
                      },
                      title: 'Continue')),
            ],
          ),
        ),
      ),
    );
  }
}
