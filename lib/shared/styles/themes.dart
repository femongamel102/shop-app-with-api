import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app_with_api/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
    scaffoldBackgroundColor: HexColor('333739'),
    primarySwatch: defaultColor,
    appBarTheme: AppBarTheme(
        titleSpacing: 20,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('333739'),
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: HexColor('333739'),
        elevation: 0,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    iconTheme: const IconThemeData(color: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      elevation: 20,
      backgroundColor: HexColor('333739'),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(8),
      prefixIconColor: Colors.grey,
      labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ));

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
    appBarTheme: const AppBarTheme(
        titleSpacing: 20,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        elevation: 20,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white));
