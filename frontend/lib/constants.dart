// coverage:ignore-file
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sizer/sizer.dart';

final String url = dotenv.env['URI']!;
final String hashAuth = dotenv.env['HASH_AUTH']!;

// Progress Indicator
const circleProgressColor = CircularProgressIndicator(color: Color(0xFFFF9800));

// APPBAR
final kAppBarTextStyle = TextStyle(
  fontSize: 18.sp,
);

// BUTTON
final kButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all(
    const EdgeInsets.symmetric(vertical: 12.0),
  ),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
  textStyle: MaterialStateProperty.all(
    TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      fontFamily: 'ComicNeue',
    ),
  ),
  fixedSize: MaterialStateProperty.all(
    Size(70.w, 9.h),
  ),
);
final kSimpleButtonStyle = kButtonStyle.copyWith(
  backgroundColor: MaterialStateProperty.all(const Color(0xFFFF9800)),
  foregroundColor: MaterialStateProperty.all(const Color(0xDD000000)),
);
// BATH PAGE

// Bath Container - Bath Title - Bath Subtitle - Bath Field
const kBathTextStyle = TextStyle(
  color: Color(0x99FFFFFF),
  fontWeight: FontWeight.bold,
);
const kBathMargin = EdgeInsets.symmetric(
  horizontal: 10.0,
  vertical: 10.0,
);
const kBathTitlePadding = EdgeInsets.symmetric(vertical: 50.0);
final kBathTitleDecoration = BoxDecoration(
  color: const Color(0xFF232329),
  boxShadow: const [BoxShadow(blurRadius: 3.0)],
  borderRadius: BorderRadius.circular(10.0),
);
final kBathOpacTextStyle = TextStyle(
  color: const Color(0x8AFFFFFF),
  fontSize: 16.sp,
);
const kV30Padding = EdgeInsets.symmetric(vertical: 30.0);
// ----------------------------------------------------

// NEW/EDIT BATH PAGE
const kH20Padding = EdgeInsets.symmetric(horizontal: 20.0);

// BATH LIST PAGE
final kTitleListStyle = TextStyle(
  fontSize: 20.sp,
  fontWeight: FontWeight.bold,
);
const kBathCardLeadingIcon = Icon(
  Icons.beach_access,
  color: Color(0xFF4CAF50),
);
const kBathCardMargin = EdgeInsets.symmetric(
  horizontal: 10.0,
  vertical: 4.0,
);
final kMessageStyle = TextStyle(
  color: const Color(0xB3FFFFFF),
  fontSize: 18.sp,
);
// ----------------------------------------------------

// HOME PAGE

// Login Button
final kLogInOutButtonStyle = kButtonStyle.copyWith(
  foregroundColor: MaterialStateProperty.all(const Color(0x99FFFFFF)),
);
const kH30Padding = EdgeInsets.symmetric(horizontal: 30.0);

// Google Button
final kGoogleButtonStyle = kButtonStyle.copyWith(
  foregroundColor: MaterialStateProperty.all(const Color(0xFFF44336)),
);

// Facebook Button
final kFacebookButtonStyle = kButtonStyle.copyWith(
  foregroundColor: MaterialStateProperty.all(const Color(0xFF2196F3)),
);

// SnackBar
const kSnackBarTextStyle = TextStyle(
  color: Color(0xFF000000),
  fontWeight: FontWeight.bold,
);
const kSnackbarPadding = EdgeInsets.symmetric(
  vertical: 5.0,
  horizontal: 10.0,
);
// ----------------------------------------------------

// REGISTRATION / LOGIN PAGE
const paddingEdgeValues = EdgeInsets.symmetric(
  vertical: 10.0,
  horizontal: 20.0,
);
// ----------------------------------------------------

// MAIN PAGE

// Locales
const kListLocales = [
  Locale('en', 'US'),
  Locale('it', 'IT'),
];

// Font Family
final kFontFamily = ThemeData.dark().textTheme.apply(
      fontFamily: 'ComicNeue',
    );

// AppBar Theme
const kAppBarTheme = AppBarTheme(
  backgroundColor: Color(0xFF232329),
  foregroundColor: Color(0x99FFFFFF),
);

// Dark Theme
final kDarkTheme = ThemeData.dark().copyWith(
  textTheme: kFontFamily,
  primaryTextTheme: kFontFamily,
  primaryColor: const Color(0xFFFF9800),
  appBarTheme: kAppBarTheme,
);
// ----------------------------------------------------