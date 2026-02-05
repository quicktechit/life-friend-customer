import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RentalTripTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const RentalTripTitle(
      {super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Text(
            title,
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.0.h,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            subTitle,
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.0.h,
              ),
            ),
          ),
        ]);
  }
}
