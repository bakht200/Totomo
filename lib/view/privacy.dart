import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_theme.dart';

class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
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
              "Privacy & Security",
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '1 .What information do we collect about you?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isLightMode ? Colors.black : Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'We collect and process information you give us when you create an account and upload content to the Platform. This includes technical and behavioural information about your use of the Platform.  We also collect information about you if you download the app and interact with the Platform without creating an account.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 16,
                            color: isLightMode ? Colors.black : Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '2 .How long do we keep hold of your information?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isLightMode ? Colors.black : Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'We retain your information for as long as it is necessary to provide you with the service. Where we do not need your information in order to provide the service to you, we retain it only as long as we have a legitimate business purpose in keeping such data or where we are subject to a legal obligation to retain the data. We will also retain your data if we believe it is or will be necessary for the establishment, exercise or defence of legal claims. ',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 16,
                            color: isLightMode ? Colors.black : Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '3 .How will we use the information about you?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isLightMode ? Colors.black : Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'We use your information to provide the Platform to you and to improve and administer it.  We use your information to, among other things, show you suggestions in the ‘For You’ feed, improve and develop the Platform and ensure your safety.  Where appropriate, we will also use your personal information to serve you targeted advertising and promote the Platform.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 16,
                            color: isLightMode ? Colors.black : Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
