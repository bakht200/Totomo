import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const appBarColor = Color(0xFFFFFFFF);
const appFooterColor = Color(0xFFFFFFFF);
const white = Color(0xFFFFFFFF);
const black = Color(0xFF000000);

final storyBorderColor = [
  Color(AppTheme.primaryColor),
  Color(AppTheme.secondaryColor)
];

class AppTheme {
  static var secondaryColor = 0xFF39B58B;
  static var primaryColor = 0xFF03766E;

  static var toggleTrackColor = Color.fromARGB(255, 216, 153, 146);

  static var inventoryExpandColor = Color(0xFFFCEFE2);
  static var backgroundColor = Colors.white;

  static var dropDownColor = Colors.grey[600];

  static var inventoryBarTitleStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 17.sp, color: Color(0xFF555555));

  static var inventoryBarPercentStyle = TextStyle(
      fontWeight: FontWeight.w400, fontSize: 15.sp, color: Color(0xFF77838F));

  static var headingStyle =
      TextStyle(fontSize: 21.sp, color: Color(0xFF555555));

  static var settingListTileHeadingStyle = TextStyle(
    color: Color.fromARGB(255, 49, 40, 40),
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static var inventoryHeadingStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 18.sp,
  );

  static var accountSettingHeadingStyle = TextStyle(
    color: Color(0xFF555555),
    fontWeight: FontWeight.bold,
    fontSize: 19.sp,
  );

  static var mediumTextStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 20.sp,
  );

  static var categoriesCardTextStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 18.sp,
  );
  static var orderTitle = TextStyle(
    color: Color(AppTheme.primaryColor),
    fontSize: 21.sp,
  );

  static var alertDialogueButtonStyle = TextStyle(
    color: Colors.blue,
    fontSize: 16.sp,
  );

  static var inventoryTileHeadingStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 28.sp,
  );

  static var subHeadingStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 22.sp,
  );

  static var tabBarHeadingStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 16.sp,
  );

  static var inventorySheetTextStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 14.sp,
  );

  static var cartListSectionHeaderStyle = TextStyle(
    color: Color(primaryColor),
    fontSize: 18.sp,
  );

  static var reasonHeadingTextStyle = TextStyle(
    color: Color(primaryColor),
    fontSize: 16.sp,
  );

  static var vendorNameHeadingStyle = TextStyle(
    color: Colors.grey[600],
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static var appBarSubHeadingStyle = TextStyle(
    color: Color(primaryColor),
    fontSize: 16.sp,
  );

  static var ordersCountTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 16.sp,
  );

  static var orderAppBarSubHeadingStyle = TextStyle(
    color: Color(primaryColor),
    fontSize: 14.sp,
  );

  static var resetButtonTextStyle = TextStyle(
    color: Colors.blue,
    fontSize: 14.sp,
  );

  static var orderAppBarSubHeadingStyling = TextStyle(
    color: Colors.grey,
    fontSize: 16.sp,
  );

  static var orderDateStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 16.sp,
  );

  static var appBarGreyHeadingStyle = TextStyle(
    color: Colors.grey,
    fontSize: 16.sp,
  );

  static var orderStatusesHeadingStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 16.sp,
  );

  static var expandedListtItalicSubTitle = TextStyle(
    color: Colors.grey,
    fontSize: 16.sp,
    fontStyle: FontStyle.italic,
  );

  static var expandedListTitle = TextStyle(
    color: Colors.grey,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static var inventoryTileSubHeadingStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 16.sp,
  );

  static var ingredientCardTitleStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 16.sp,
    fontWeight: FontWeight.w800,
  );

  static var homeScreenTextStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 16.sp,
  );

  static var bottomSheetHeadingStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
  );

  static var otpErrorMessageStyle = TextStyle(
    color: Colors.red,
    fontSize: 15.sp,
  );

  static var listSubHeadingStyle = TextStyle(
    color: Colors.grey[800],
    fontSize: 16.sp,
  );

  static var alertDialogueTextStyle = TextStyle(
    color: Colors.grey[800],
    fontSize: 15.sp,
  );

  static var seeAllTextStyle = TextStyle(
    color: Colors.grey[600],
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );

  static var commentedTextStyle = TextStyle(
    color: Colors.grey[600],
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  static var timeAgoTextStyle = TextStyle(fontSize: 12.sp, color: Colors.grey);

  static var itemFilledTextStyle = TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.bold, color: Color(0xFF555555));

  static var cardSubHeadingStyle = TextStyle(
    color: Colors.grey[600],
    fontSize: 16.sp,
    fontWeight: FontWeight.w800,
  );

  static var themeFilledButtonTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static var tasksStatusTextStyle = TextStyle(
    color: Color(0xFF555555),
    fontWeight: FontWeight.bold,
  );
  static var taskHeadingTextStyle = TextStyle(
      color: Color(0xFF555555), fontSize: 14.sp, fontWeight: FontWeight.bold);

  static var taskDateTextStyle = TextStyle(
    color: Color(AppTheme.primaryColor),
    fontSize: 14.sp,
  );

  static var unFilledButtonTextStyle = TextStyle(
    color: Color(0xFF555555),
    fontWeight: FontWeight.bold,
  );

  static var orderStatusTextStyle = TextStyle(
    color: Color(0xFF555555),
    fontSize: 16.sp,
  );

  static var orderStatusCountTextStyle = TextStyle(
      color: Color(0xFF555555), fontSize: 16.sp, fontWeight: FontWeight.bold);

  static var themeFilledButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(AppTheme.primaryColor)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
        side: BorderSide(
          color: Color(AppTheme.primaryColor),
        ),
      ),
    ),
  );

  static var greenButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.green),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
        side: BorderSide(
          color: Colors.green,
        ),
      ),
    ),
  );

  static var disableButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.grey),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
    ),
  );

  static var itemIssuanceButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color(0XFFC75E21)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
        side: BorderSide(
          color: Color(0XFFC75E21),
        ),
      ),
    ),
  );

  static var greyFilledButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.grey),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
    ),
  );

  static var unfilledButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.white),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.w),
        side: BorderSide(
          color: Color(AppTheme.primaryColor),
        ),
      ),
    ),
  );
}
