import 'package:dating_app/view/authentication_screen.dart';
import 'package:dating_app/view/dashboard.dart';
import 'package:dating_app/view/on_boarding_screen.dart';
import 'package:dating_app/view/splash_screen.dart';
import 'package:dating_app/view/stepper_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return FirebasePhoneAuthProvider(
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
              home: OnBoardingScreen(),
            ),
          );
        });
  }
}
