import 'package:client/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    unselectedWidgetColor: Colors.grey.shade400,
    scaffoldBackgroundColor: AppLightColors.appBackgroundColor,
    primaryColor: AppLightColors.primaryColor,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: AppLightColors.textColor,
      ),
    ),
    colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: AppLightColors.primaryColor,
        secondary: AppLightColors.secondaryColor,
        background: AppLightColors.appBackgroundColor,
        onBackground: AppLightColors.whiteColor,
        primaryContainer: AppLightColors.grayColor,
        secondaryContainer: AppLightColors.lightGrayColor,
        error: AppLightColors.redColor,
        surface: AppLightColors.yellowColor,
        onSurface: AppLightColors.blueColor,
        tertiary: AppLightColors.greenColor,
        inverseSurface: Color(0xffFBF1FF), //check later with ali "Yazan"

        shadow: Color(0x0fff4f4f),
        onInverseSurface: AppLightColors.blackColor,

        //fonts
        onPrimary: AppLightColors.textColor,
        onSecondary: AppLightColors.textLightColor,

        //Cards
        onPrimaryContainer: AppLightColors.cardHeaderColor,
        onSecondaryContainer: AppLightColors.cardBackgroundColor,
        onTertiaryContainer: AppLightColors.cardWhiteColor,

        //scaffoldBackground
        tertiaryContainer: AppLightColors.scaffoldBackground,
        //settingCardColor
        inversePrimary: AppLightColors.settingCardBackground),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    shadowColor: AppLightColors.grayColor,
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontFamily: "Almarai",
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppLightColors.grayTextColor,
        height: 0.0,
        letterSpacing: 0,
      ),
      displaySmall: TextStyle(
        fontFamily: "Almarai",
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppLightColors.grayTextColor,
        height: 0.0,
      ),
      displayMedium: TextStyle(
        fontFamily: "Almarai",
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppLightColors.textColor,
        height: 0,
      ),
      displayLarge: TextStyle(
        fontFamily: "Almarai",
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppLightColors.textColor,
        height: 0.0,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Almarai",
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppLightColors.textColor,
        height: 0.0,
      ),
      headlineMedium: TextStyle(
        fontFamily: "Almarai",
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppLightColors.textColor,
        height: 0.0,
      ),
      headlineLarge: TextStyle(
        fontFamily: "Almarai",
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: AppLightColors.textColor,
        height: 0.0,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppDarkColors.backgroundColor,
    primaryColor: AppDarkColors.primaryColor,
    colorScheme: const ColorScheme.dark(
        brightness: Brightness.light,
        primary: AppDarkColors.primaryColor,
        secondary: AppDarkColors.secondaryColor,
        background: AppDarkColors.backgroundColor,
        onBackground: AppDarkColors.onBackgroundColor,
        primaryContainer: AppDarkColors.grayColor,
        secondaryContainer: AppDarkColors.lightGrayColor,
        //temp dark gray
        shadow: AppDarkColors.darkGrayColor,
        // onSecondary: AppDarkColors.whiteColor,
        error: AppDarkColors.redColor,
        surface: AppDarkColors.yellowColor,
        onSurface: AppDarkColors.blueColor,
        tertiary: AppDarkColors.greenColor,

        //fonts
        onPrimary: AppDarkColors.textColor,
        onSecondary: AppDarkColors.textLightColor,
        onInverseSurface: AppDarkColors.whiteColor,

        //Cards
        onPrimaryContainer: AppDarkColors.cardHeaderColor,
        onSecondaryContainer: AppDarkColors.cardBackgroundColor,
        onTertiaryContainer: AppDarkColors.cardWhiteColor,

        //scaffoldBackground
        tertiaryContainer: AppDarkColors.backgroundColor,

        //settingCardColor
        inversePrimary: AppDarkColors.settingCardBackground),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppDarkColors.backgroundColor,
    ),
    primaryTextTheme: TextTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppDarkColors.backgroundColor,
      selectedItemColor: AppDarkColors.primaryColor,
      unselectedItemColor: AppDarkColors.textLightColor,
      selectedIconTheme: const IconThemeData(
        color: AppDarkColors.secondaryColor,
      ),
      unselectedIconTheme: const IconThemeData(
        color: AppDarkColors.lightGrayColor,
      ),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontFamily: "Almarai",
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: AppDarkColors.secondaryColor,
        height: 0.0,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: "Almarai",
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppDarkColors.grayColor,
        height: 0.0,
      ),
      elevation: 8.0,
      type: BottomNavigationBarType.fixed,
    ),
    iconTheme: const IconThemeData(color: AppDarkColors.grayColor),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(AppDarkColors.grayColor),
      ),
    ),
    shadowColor: AppDarkColors.grayColor,
    textTheme: TextTheme(
      displaySmall: TextStyle(
        fontFamily: "Almarai",
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppDarkColors.darkGrayColor,
        height: 0.0,
      ),
      displayMedium: TextStyle(
        fontFamily: "Almarai",
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppDarkColors.grayColor,
        height: 0.0,
      ),
      displayLarge: TextStyle(
        fontFamily: "Almarai",
        fontSize: 18.sp,
        fontWeight: FontWeight.w800,
        color: AppDarkColors.textColor,
        height: 0.0,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Almarai",
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppLightColors.grayColor,
        height: 0.0,
      ),
      headlineMedium: TextStyle(
        fontFamily: "Almarai",
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppLightColors.grayColor,
        height: 0.0,
      ),
      headlineLarge: TextStyle(
        fontFamily: "Almarai",
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: AppLightColors.grayColor,
        height: 0.0,
      ),
    ),
  );
}
