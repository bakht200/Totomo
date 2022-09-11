import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:dating_app/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final number = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  var _text = '';
  FocusNode myFocusNode = new FocusNode();

  @override
  void dispose() {
    number.dispose();
    super.dispose();
  }

  get _errorText {
    final text = number.value.text;

    if (text.isEmpty) {
      return '';
    }
    if (text.length < 11) {
      return 'Number length must be 11';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          return currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 60.0.h),
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Column(
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
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CountryPickerDropdown(
                            initialValue: 'AR',
                            itemBuilder: _buildDropdownItem,
                            priorityList: [
                              CountryPickerUtils.getCountryByIsoCode('GB'),
                              CountryPickerUtils.getCountryByIsoCode('CN'),
                            ],
                            sortComparator: (Country a, Country b) =>
                                a.isoCode.compareTo(b.isoCode),
                            onValuePicked: (Country country) {
                              print("${country.name}");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Form(
                              key: formGlobalKey,
                              child: TextField(
                                focusNode: myFocusNode,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(11),
                                ],
                                keyboardType: TextInputType.phone,
                                controller: number,
                                onChanged: (text) => setState(() => _text),
                                decoration: InputDecoration(
                                  errorText: _errorText,
                                  labelText: '800-111-2222',
                                  labelStyle: TextStyle(
                                      color: myFocusNode.hasFocus
                                          ? Color(AppTheme.primaryColor)
                                          : Colors.grey),
                                  fillColor: Colors.white,
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: myFocusNode.hasFocus
                                          ? Color(AppTheme.primaryColor)
                                          : Colors.grey,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: myFocusNode.hasFocus
                                          ? Color(AppTheme.primaryColor)
                                          : Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: myFocusNode.hasFocus
                                          ? Color(AppTheme.primaryColor)
                                          : Colors.grey,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: myFocusNode.hasFocus
                                          ? Color(AppTheme.primaryColor)
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.w),
                      child: SizedBox(
                        height: 40.h,
                        width: width,
                        child: ElevatedButton(
                          style: AppTheme.themeFilledButtonStyle,
                          onPressed:
                              _errorText == null ? loginFunction() : null,
                          child: Text('Next',
                              style: AppTheme.themeFilledButtonTextStyle),
                        ),
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

  loginFunction() {
    return number.value.text.isNotEmpty
        ? () async {
            if (_errorText == null) {
              // String signCode = await SmsAutoFill().getAppSignature;
              // showDialog(
              //   context: context,
              //   barrierDismissible: false,
              //   builder: (BuildContext context) {
              //     return WillPopScope(
              //       onWillPop: () async => false,
              //       child: AlertDialog(
              //         content: new Row(
              //           children: [
              //             CircularProgressIndicator(
              //               color: AppTheme.primaryColor,
              //             ),
              //             Container(
              //                 margin: EdgeInsets.only(left: 7.w),
              //                 child: Text(LoginStrings.loadingText)),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // );
              // controllerObject.fetchOtp(number.text, signCode, context);
            } else {
              return null;
            }
          }
        : null;
  }

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );
}
