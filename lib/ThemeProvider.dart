import 'package:flutter/material.dart';

class ThemeProvider {
  TextTheme _defaultTextTheme() {
    return TextTheme(
      headline1: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: "SF Pro Text"),
      headline2: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: "SF Pro Text"),
      headline3: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: "SF Pro Display"),
      bodyText1: TextStyle(
          fontSize: 17,
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontFamily: "SF Pro Text"),
    );
  }

  Color lightBlue() {
    return Color(0xFF3F456A);
  }

  Color darkBlue() {
    return Color(0xFF262C48);
  }

  Color gold() {
    return Color(0xFFFFBF00);
  }

  Color teal() {
    return Color(0xFF2EC1AC);
  }

  Color blueBorder() {
    return Color(0xFF2B4767);
  }

  Color red() {
    return Color(0xFFEB4B58);
  }

  Color pink() {
    return Color(0xFFE95C6D);
  }

  Color green() {
    return Color(0xFF5BC39D);
  }

  Color inactiveColor() {
    return Colors.grey;
  }

  Color lightGrey() {
    return Color(0xFFE8EAED);
  }

  Color darkGrey() {
    return Color(0xFF747373);
  }

  LinearGradient primaryGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [const Color(0xFFE95C6D), const Color(0xFFC768B2)],
      tileMode: TileMode.repeated,
    );
  }

  ThemeData theme() {
    return ThemeData(
        fontFamily: 'SF Pro Text',
        scaffoldBackgroundColor: darkBlue(),
        textTheme: _defaultTextTheme()
        // colorScheme: ColorScheme.light(primary: Colors.black),
        // dividerColor: Color(0x803C3C43),
        // buttonTheme: ButtonThemeData(
        //   buttonColor: Color(0xFFE6535D),
        //   textTheme: ButtonTextTheme.primary,
        // ),
        // indicatorColor: Color(0xFFE6535D),
        // appBarTheme: AppBarTheme(color: Colors.white, textTheme: TextTheme()),
        // tabBarTheme: TabBarTheme(
        //   unselectedLabelColor: Colors.grey,
        // ),
        // textTheme: _defaultTextTheme(),
        // primaryTextTheme: _defaultTextTheme(),
        // accentTextTheme: _defaultTextTheme(),
        // primaryColor: activeColor(),
        // primaryIconTheme: const IconThemeData.fallback().copyWith(
        //   color: Colors.black,
        // ),
        );
  }
}
