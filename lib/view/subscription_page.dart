import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constants/app_theme.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../widgets/primary_button_widget.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  Map<String, dynamic>? paymentIntentData;

  var subscriptionList = [
    {
      'index': '1',
      'name': 'MONTH',
      'price': '\$399',
      'total': '\$399/mo',
    },
    {
      'index': '6',
      'name': 'MONTHS',
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
      'title': 'Search by nearest, perfecture, city, Vip',
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
      'title': 'Access first to premium feature',
    },
    {
      'icon': 'assets/images/reputation.png',
      'title': 'get the VIP badge',
    },
    {
      'icon': 'assets/images/dollar-coin.png',
      'title': 'get 10 gold by months',
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
              Text('MEET ANYONE MORE EASILY!',
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
                            print(selectedIndex);
                          });
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : Colors.grey[200],
                                  child: Container(
                                    height: 100.h,
                                    width: 90.w,
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5.0.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                        Text(
                                          subscriptionList[index]['total']
                                              .toString(),
                                          style:
                                              TextStyle(color: Colors.black38),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
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
              Text(
                'Do you have a coupon?',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(8.0.w),
                child: const TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.greenAccent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.0),
                    ),
                    hintText: 'Write your coupon code',
                  ),
                ),
              ),
              SizedBox(
                  width: double.infinity, //
                  height: 45.h,
                  child: theme_primary_button_widget(
                      primaryColor: Color(AppTheme.primaryColor),
                      textColor: Color(0xFFFAFAFA),
                      onpressFunction: () {
                        if (selectedIndex == -1) {
                        } else {
                          if (selectedIndex == 0) {
                            makePayment(
                              subscriptionList[0]['index'],
                              subscriptionList[0]['name'],
                              subscriptionList[0]['price'],
                            );
                          } else if (selectedIndex == 1) {
                            makePayment(
                              subscriptionList[0]['index'],
                              subscriptionList[1]['name'],
                              subscriptionList[1]['price'],
                            );
                          } else if (selectedIndex == 2) {
                            makePayment(
                              subscriptionList[0]['index'],
                              subscriptionList[2]['name'],
                              subscriptionList[2]['price'],
                            );
                          }
                        }
                      },
                      title: 'Continue')),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(index, subscriptionTime, subscriptionPrice) async {
    try {
      paymentIntentData = await createPaymentIntent('20', 'USD');

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  allowsDelayedPaymentMethods: true,

                  //testEnv: true,
                  style: ThemeMode.dark,
                  //  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      displayPaymentSheet(index, subscriptionTime);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(index, subscriptionTime) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        User user = FirebaseAuth.instance.currentUser!;
        if (subscriptionTime == 'MONTH') {
          print("here in month");
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .update({
            'userType': 'paid',
            'subscriptionTime': DateTime.now().add(Duration(days: 30)),
          });
        } else if (subscriptionTime == 'MONTHS') {
          print("here in months");

          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .update({
            'userType': 'paid',
            'subscriptionTime': DateTime.now().add(Duration(days: 180)),
          });
        } else if (subscriptionTime == 'YEAR') {
          print("here in year");

          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .update({
            'userType': 'paid',
            'subscriptionTime': DateTime.now().add(Duration(days: 365)),
          });
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {});
    } on StripeException catch (e) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {}
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LmBnzFGPLNyrnFGoOHkZCf5A3t2xaaBSRAtUcs3WY2ZbM0PuAISQEeFrpwRKWiWJyxzTspq3qSWiCIWM13dLKhD00RTkzlzzs',
            'Content-Type': 'application/x-www-form-urlencoded'
          });

      return jsonDecode(response.body);
    } catch (err) {}
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
