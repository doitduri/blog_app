import 'package:flutter/material.dart';

final theme = ThemeData(
    fontFamily: 'NotoSans',
    primaryColor: const Color(0xFF051038),
    accentColor: const Color(0xFF092060),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    backgroundColor: const Color(0xFFFFFFFF),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          gapPadding: 1
      ),
    ),
    // dividerColor: const Color(0xFFBFBFBF),
    dividerColor: Colors.transparent,
    textTheme: TextTheme(
      headline1: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
      headline2: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
      headline3: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
      headline4: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
      headline5: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
      headline6: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black),
      subtitle1: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400, fontSize: 16),
      subtitle2: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400, fontSize: 14),
      bodyText1: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400, fontSize: 16),
      bodyText2: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400, fontSize: 14),
      button: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.bold, fontSize: 14),
      caption: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400, fontSize: 12),
      overline: TextStyle(fontFamily: 'NotoSans', fontWeight: FontWeight.w400, fontSize: 10),
    ));