import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../constants/app_theme.dart';
import '../widgets/primary_button_widget.dart';
import 'package:http/http.dart' as http;

class GetCoins extends StatefulWidget {
  @override
  State<GetCoins> createState() => _GetCoinsState();
}

class _GetCoinsState extends State<GetCoins> {
  Map<String, dynamic>? paymentIntentData;

  var subscriptionList = [
    {
      'cryptoAmount': "12 per coin",
      'cryptoCurrency': "USD",
      'cryptoIconURL':
          "https://cdn4.iconfinder.com/data/icons/cryptocoins/227/ETH-alt-512.png",
      'name': "Bronze",
      'token': "Get 10 coins",
      'usdAmount': "12,000 USD",
    },
    {
      'cryptoAmount': "50 per coin",
      'cryptoCurrency': "USD",
      'cryptoIconURL':
          "http://www.pngall.com/wp-content/uploads/1/Bitcoin-Free-PNG-Image.png",
      'name': "Silver",
      'token': "Get 50 coins",
      'usdAmount': "50,000 USD",
    },
    {
      'cryptoAmount': "100 per coin",
      'cryptoCurrency': "USD",
      'cryptoIconURL':
          "https://images.cointelegraph.com/images/240_aHR0cHM6Ly9zMy5jb2ludGVsZWdyYXBoLmNvbS9zdG9yYWdlL3VwbG9hZHMvdmlldy9iZjc1NDFlMDlhNDU2YTNmYzYxMTNlYzljN2NkZjQwOC5wbmc=.png",
      'name': "Premium",
      'token': "Get 100 coins",
      'usdAmount': "10,0000 USD",
    }
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 214, 219, 208),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(AppTheme.appBarBackgroundColor),
        title: Text(
          "Buy coins",
          style: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Positioned(child: homePageContent()),
                Padding(
                  padding: EdgeInsets.only(top: 150.0.h),
                  child: Column(
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
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
                                  TokenCard(
                                    cryptoAmount: subscriptionList[index]
                                        ['cryptoAmount']!,
                                    cryptoCurrency: subscriptionList[index]
                                        ['cryptoCurrency']!,
                                    cryptoIconURL: subscriptionList[index]
                                        ['cryptoIconURL']!,
                                    name: subscriptionList[index]['name']!,
                                    token: subscriptionList[index]['token']!,
                                    usdAmount: subscriptionList[index]
                                        ['usdAmount']!,
                                  ),
                                  selectedIndex == index
                                      ? Positioned(
                                          left: 4,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.r),
                                              color:
                                                  Color(AppTheme.primaryColor),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(5.0.w),
                                              child: Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
                width: 100.w, //
                height: 45.h,
                child: theme_primary_button_widget(
                    primaryColor: Color(AppTheme.primaryColor),
                    textColor: Color(0xFFFAFAFA),
                    onpressFunction: () {
                      makePayment(subscriptionList[selectedIndex!]['name']);
                    },
                    title: 'Buy Now')),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(var coinName) async {
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

      displayPaymentSheet(coinName);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(var coinName) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        User user = FirebaseAuth.instance.currentUser!;
        if (coinName == 'Bronze') {
          print("here in month");
          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .update({
            'coins': 10,
          });
        } else if (coinName == 'Silver') {
          print("here in months");

          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .update({
            'coins': 50,
          });
        } else if (coinName == 'Premium') {
          print("here in year");

          await FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
              .update({
            'coins': 100,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Coins purchased successfully")));
        Navigator.of(context).pop();

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

class homePageContent extends StatefulWidget {
  @override
  State<homePageContent> createState() => _homePageContentState();
}

class _homePageContentState extends State<homePageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: MediaQuery.of(context).size.width,
      color: Color(AppTheme.appBarBackgroundColor),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 21.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Text("GET A COINS NOW !",
          //     style: Theme.of(context).textTheme.headlineLarge),
          SizedBox(height: 11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                  "Pay to get coins and share it \nwith your friends to get more",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontStyle: FontStyle.italic)),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Coins Subscription",
                  style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class TokenCard extends StatelessWidget {
  final String token,
      name,
      cryptoAmount,
      cryptoCurrency,
      usdAmount,
      cryptoIconURL;

  TokenCard({
    required this.token,
    required this.name,
    required this.cryptoAmount,
    required this.cryptoCurrency,
    required this.usdAmount,
    required this.cryptoIconURL,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 21.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.all(21),
      child: Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                cryptoIconURL,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    token,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  Text(
                    name,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "$cryptoAmount $cryptoCurrency",
                    softWrap: false,
                  ),
                  Text(
                    "\$$usdAmount",
                    // style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
