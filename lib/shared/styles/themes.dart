import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('#121212'),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backwardsCompatibility: false, // to control status bar
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('#121212'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('#121212'),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 30,
    backgroundColor: HexColor('#121212'),
  ),
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      )
  ),
);
ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backwardsCompatibility: false, // to control status bar
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 30,
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      )
  ),
);