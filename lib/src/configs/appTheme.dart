import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    scaffoldBackgroundColor: white,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: white,
      ),
    ),
  );
}
