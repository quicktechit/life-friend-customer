import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';


   ThemeData appTheme(context)=> ThemeData(
    scaffoldBackgroundColor: white,
    textTheme: GoogleFonts.robotoSlabTextTheme(Theme.of(context).textTheme,),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: white,
      ),
    ),
  );
