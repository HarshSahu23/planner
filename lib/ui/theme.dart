import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class Themes {
  Themes._();
  static const Color bluishClr = Color(0xFF4e5ae8);
  static const Color yellowClr = Color(0xFFFFB746);
  static const Color pinkClr = Color(0xFFff4667);
  static const Color greenClr = Color.fromARGB(255, 39, 185, 3);
  static const Color white = Colors.white;
  static const Color darkGreyClr = Color(0xFF121212);
  static const Color darkHeaderClr = Color(0xFF424242);

  static const Color primaryClr = Color(0xFF4e5ae8);
  static const Color dialColorScheme = darkHeaderClr;

  static final ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        color: white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black)),
    colorScheme: const ColorScheme.light(
        primary: primaryClr,
        brightness: Brightness.light,
        background: Colors.white),
  );

  static final ThemeData darkTheme = ThemeData(
    backgroundColor: darkHeaderClr,
    timePickerTheme: const TimePickerThemeData(
        backgroundColor: dialColorScheme,
        dialBackgroundColor: dialColorScheme,
        dialHandColor: Colors.cyan,
        dialTextColor: Colors.white,
        hourMinuteColor: dialColorScheme,
        hourMinuteTextColor: Colors.white,
        dayPeriodTextColor: Colors.cyan),
    appBarTheme: const AppBarTheme(
        color: darkHeaderClr,
        iconTheme: IconThemeData(color: Colors.yellow),
        titleTextStyle: TextStyle(color: Colors.orange)),
    colorScheme: ColorScheme.dark(
        primary: darkGreyClr,
        onPrimary: Colors.cyan,
        // onSurface: Colors.cyan,
        secondary: Colors.grey.shade500,
        onSecondary: bluishClr,
        brightness: Brightness.dark,
        background: Colors.black),
  );
}

TextStyle get subHeadingStyleLight {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey));
}

TextStyle get subHeadingStyleDark {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.yellow));
}

TextStyle get headingStyleLight {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black));
}

TextStyle get headingStyleDark {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white));
}

TextStyle get headingStyleBoth {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700]));
}


// static final ThemeData lightTheme = ThemeData(
  //   // appBarTheme: AppBarTheme(
  //   //   titleTextStyle: TextStyle(color:_darkSecondaryColor,fontFamily: "Roboto",fontWeight: FontWeight.bold,fontSize: 26 ),
  //   //   color: _lightPrimaryVariantColor,
  //   //   iconTheme: IconThemeData(color: _lightOnPrimaryColor),
  //   // ),
  //   colorScheme: const ColorScheme.light(
  //     primary: primaryClr,
  //     // primaryVariant: _lightPrimaryVariantColor,
  //     // secondary: _lightSecondaryColor,
  //     // onPrimary: _lightOnPrimaryColor,
  //   ),
  //   // iconTheme: IconThemeData(
  //   //   color: _iconColor,
  //   // ),
  //   // textTheme: _lightTextTheme,
  //   //   dividerTheme: DividerThemeData(
  //   //     color: Colors.black12
  //   //   )
  // );