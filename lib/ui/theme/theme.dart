import 'package:flutter/material.dart';
import 'package:ticket_sales/resources/app_fonts.dart';

class ThemeApp {
  const ThemeApp();
  static final appTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed, // Fixed
      backgroundColor: Color(0xFF0C0C0C),
      selectedItemColor: Color(0xFF2261BC),
      unselectedItemColor: Color(0xFF9F9F9F),
      selectedIconTheme: IconThemeData(size: 24),
      unselectedIconTheme: IconThemeData(size: 24),
      selectedLabelStyle: TextStyle(
        color: Color(0xFF2261BC),
        fontSize: 14,
      ),
      unselectedLabelStyle: TextStyle(
        color: Color(0xFF9F9F9F),
        fontSize: 14,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: AppFonts.sfProSemibold,
        fontSize: 22,
        height: 1.2,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: AppFonts.sfProSemibold,
        fontSize: 16,
        height: 1.3,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: AppFonts.sfProRegular,
        fontSize: 14,
        height: 1.2,
        color: Colors.white,
      ),
    ),
  );
  static const Color greyOne = Color(0xFF1D1E20);
  static const Color greyTwo = Color(0xFF242529);
  static const Color greyThree = Color(0xFF2F3035);
  static const Color greyFour = Color(0xFF3E3F43);
  static const Color greyFive = Color(0xFF5E5F61);
  static const Color greySix = Color(0xFF9F9F9F);
  static const Color greySeven = Color(0xFFDBDBDB);
  static const Color specialBlue = Color(0xFF4C95FE);
  static const Color specialDarkBlue = Color(0xFF00427D);
  static const Color specialPriceBlue = Color(0xFF2261BC);
  static const Color specialGreen = Color(0xFF4CB24E);
  static const Color specialDarkGreen = Color(0xFF015905);
  static const Color specialRed = Color(0xFFFF0000);
  static const Color specialOrange = Color(0xFFF36E36);
}
