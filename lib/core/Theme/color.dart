import 'package:flutter/material.dart';

class Themes {
  //light theme
  static final light = ThemeData.light().copyWith(
      primaryColor: Colors.yellow,
      primaryColorLight: Colors.yellow[400],
      primaryColorDark: Colors.yellow[700],
      iconTheme: const IconThemeData(color: Colors.black54),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: Colors.amber.shade500,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.yellow),
      splashColor: Colors.white);

//dark theme
  static final dark = ThemeData.dark().copyWith(
      //buttonColor: Colors.red,
      primaryColor: Colors.yellow,
      primaryColorDark: Colors.yellow[700],
      secondaryHeaderColor: Colors.yellow,
      iconTheme: const IconThemeData(color: Colors.white),
      bannerTheme: MaterialBannerThemeData(
        backgroundColor: Colors.amber.shade900.withAlpha(200),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.grey[900],
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[800],
      ),
      floatingActionButtonTheme:
          const FloatingActionButtonThemeData(backgroundColor: Colors.yellow),
      scaffoldBackgroundColor: Colors.grey[800],
      splashColor: Colors.grey[900]);
}
