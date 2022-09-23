import 'package:dating_app/view/verify_phone_number.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';

import '../constants/app_theme.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  String? phoneNumber;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text('Can i get \nthose digits?',
                        style: TextStyle(
                            fontSize: 40.sp,
                            color: Color(AppTheme.primaryColor),
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    child: Text(
                      'Enter your phone number below to create your free account.',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              const SizedBox(height: 15),
              Container(
                color: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(AppTheme.primaryColor),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(AppTheme.primaryColor)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(AppTheme.primaryColor)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(AppTheme.primaryColor)),
                      ),
                    ),
                    autofocus: true,
                    invalidNumberMessage: 'Invalid Phone Number!',
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(fontSize: 22),
                    onChanged: (phone) => phoneNumber = phone.completeNumber,
                    initialCountryCode: 'IN',
                    flagsButtonPadding:
                        const EdgeInsets.only(right: 10, left: 10),
                    showDropdownIcon: false,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.all(10.0.w),
                child: SizedBox(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: AppTheme.themeFilledButtonStyle,
                    onPressed: () {
                      if (isNullOrBlank(phoneNumber) ||
                          !_formKey.currentState!.validate()) {
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => VerifyPhoneNumberScreen(
                                phoneNumber: phoneNumber!)));
                      }
                    },
                    child: Text('Next',
                        style: AppTheme.themeFilledButtonTextStyle),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PinInputField extends StatefulWidget {
  final int length;
  final void Function(bool)? onFocusChange;
  final void Function(String) onSubmit;

  const PinInputField({
    Key? key,
    this.length = 6,
    this.onFocusChange,
    required this.onSubmit,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PinInputFieldState createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> {
  late final TextEditingController _pinPutController;
  late final FocusNode _pinPutFocusNode;
  late final int _length;

  Size _findContainerSize(BuildContext context) {
    // full screen width
    double width = MediaQuery.of(context).size.width * 0.85;

    // using left-over space to get width of each container
    width /= _length;

    return Size.square(width);
  }

  @override
  void initState() {
    _pinPutController = TextEditingController();
    _pinPutFocusNode = FocusNode();

    if (widget.onFocusChange != null) {
      _pinPutFocusNode.addListener(() {
        widget.onFocusChange!(_pinPutFocusNode.hasFocus);
      });
    }

    _length = widget.length;
    super.initState();
  }

  @override
  void dispose() {
    _pinPutController.dispose();
    _pinPutFocusNode.dispose();
    super.dispose();
  }

  PinTheme _getPinTheme(
    BuildContext context, {
    required Size size,
  }) {
    return PinTheme(
      height: size.height,
      width: size.width,
      textStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(7.5),
      ),
    );
  }

  static const _focusScaleFactor = 1.15;

  @override
  Widget build(BuildContext context) {
    final size = _findContainerSize(context);
    final defaultPinTheme = _getPinTheme(context, size: size);

    return SizedBox(
      height: size.height * _focusScaleFactor,
      child: Pinput(
        length: _length,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          height: size.height * _focusScaleFactor,
          width: size.width * _focusScaleFactor,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: Theme.of(context).errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        onCompleted: widget.onSubmit,
        pinAnimationType: PinAnimationType.scale,
        // submittedFieldDecoration: _pinPutDecoration,
        // selectedFieldDecoration: _pinPutDecoration,
        // followingFieldDecoration: _pinPutDecoration,
        // textStyle: const TextStyle(
        //   color: Colors.black,
        //   fontSize: 20.0,
        //   fontWeight: FontWeight.w600,
        // ),
      ),
    );
  }
}

bool isNullOrBlank(String? data) => data?.trim().isEmpty ?? true;
