import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';

class DividerWidget extends StatefulWidget {
  final String title;
  const DividerWidget({super.key, required this.title});

  @override
  State<DividerWidget> createState() => _DividerWidgetState();
}

class _DividerWidgetState extends State<DividerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${widget.title}".tr,
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 14.0.h,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Container(
            height: 1.7,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [secondaryColor, Colors.green],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0),
      ],
    );
  }
}
