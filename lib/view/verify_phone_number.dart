import 'dart:developer';

import 'package:dating_app/view/dashboard.dart';
import 'package:dating_app/view/home_page.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_theme.dart';
import '../widgets/custom_loader.dart';
import 'authentication_screen.dart';

class VerifyPhoneNumberScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyPhoneNumberScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen>
    with WidgetsBindingObserver {
  bool isKeyboardVisible = false;

  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomViewInsets = WidgetsBinding.instance.window.viewInsets.bottom;
    isKeyboardVisible = bottomViewInsets > 0;
  }

  // scroll to bottom of screen, when pin input field is in focus.
  Future<void> _scrollToBottomOnKeyboardOpen() async {
    while (!isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await Future.delayed(const Duration(milliseconds: 250));

    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: widget.phoneNumber,
        signOutOnSuccessfulVerification: false,
        linkWithExistingUser: false,
        autoRetrievalTimeOutDuration: const Duration(seconds: 60),
        otpExpirationDuration: const Duration(seconds: 60),
        onCodeSent: () {},
        onLoginSuccess: (userCredential, autoVerified) async {
          // log(
          //   VerifyPhoneNumberScreen.id,
          //   msg: autoVerified
          //       ? 'OTP was fetched automatically!'
          //       : 'OTP was verified manually!',
          // );

          Fluttertoast.showToast(msg: 'Phone number verified successfully!');

          // log(
          //   VerifyPhoneNumberScreen.id,
          //   msg: 'Login Success UID: ${userCredential.user?.uid}',
          // );

          Navigator.of(context).push(MaterialPageRoute(
              builder: (builder) => Dashboard(
                    index: 0,
                  )));
        },
        onLoginFailed: (authException, stackTrace) {
          // log(
          //   VerifyPhoneNumberScreen.id,
          //   msg: authException.message,
          //   error: authException,
          //   stackTrace: stackTrace,
          // );
          Fluttertoast.showToast(msg: 'Login Failed!');
        },
        onError: (error, stackTrace) {
          // log(
          //   VerifyPhoneNumberScreen.id,
          //   error: error,
          //   stackTrace: stackTrace,
          // );

          Fluttertoast.showToast(msg: 'An error occurred!');
        },
        builder: (context, controller) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 0,
              leading: const SizedBox.shrink(),
              title: Text('Verify Phone Number',
                  style: TextStyle(
                      fontSize: 22.sp,
                      color: Color(AppTheme.primaryColor),
                      fontWeight: FontWeight.bold)),
              actions: [
                if (controller.codeSent)
                  TextButton(
                    onPressed: controller.isOtpExpired
                        ? () async {
                            Fluttertoast.showToast(msg: 'Resend OTP');
                            await controller.sendOTP();
                          }
                        : null,
                    child: Text(
                      controller.isOtpExpired
                          ? 'Resend'
                          : '${controller.otpExpirationTimeLeft.inSeconds}s',
                      style: const TextStyle(color: (Colors.red), fontSize: 18),
                    ),
                  ),
                SizedBox(width: 5.w),
              ],
            ),
            body: controller.isSendingCode
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomLoader(),
                      SizedBox(height: 50.h),
                      Center(
                        child: Text(
                          'Sending OTP',
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ),
                    ],
                  )
                : ListView(
                    padding: EdgeInsets.all(20.w),
                    controller: scrollController,
                    children: [
                      Text(
                        "We've sent an SMS with a verification code to ${widget.phoneNumber}",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      const Divider(),
                      if (controller.isListeningForOtpAutoRetrieve)
                        Column(
                          children: [
                            CustomLoader(),
                            SizedBox(height: 50.h),
                            Text(
                              'Listening for OTP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            const Divider(),
                            const Text('OR', textAlign: TextAlign.center),
                            const Divider(),
                          ],
                        ),
                      SizedBox(height: 15.h),
                      Text(
                        'Enter OTP',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      PinInputField(
                        length: 6,
                        onFocusChange: (hasFocus) async {
                          if (hasFocus) await _scrollToBottomOnKeyboardOpen();
                        },
                        onSubmit: (enteredOtp) async {
                          final verified =
                              await controller.verifyOtp(enteredOtp);
                          if (verified) {
                            // number verify success
                            // will call onLoginSuccess handler
                          } else {
                            // phone verification failed
                            // will call onLoginFailed or onError callbacks with the error
                          }
                        },
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
