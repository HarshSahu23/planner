import 'package:flutter/material.dart';

class Themes {
  Themes._();
  static const Color bluishClr = Color(0xFF4e5ae8);
  static const Color yellowClr = Color(0xFFFFB746);
  static const Color pinkClr = Color(0xFFff4667);
  static const Color white = Colors.white;
  static const Color darkGreyClr = Color(0xFF121212);
  static const Color darkHeaderClr = Color(0xFF424242);

  static const Color primaryClr = Color(0xFF4e5ae8);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
        primary: primaryClr, brightness: Brightness.light),
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
        primary: darkGreyClr, brightness: Brightness.dark),
  );
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