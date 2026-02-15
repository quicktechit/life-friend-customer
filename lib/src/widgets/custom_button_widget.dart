import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomCommonButton extends StatefulWidget {
  final IconData icons;
  final String title;
  final Color? color;
  const CustomCommonButton(
      {super.key, required this.icons, required this.title,this.color });

  @override
  State<CustomCommonButton> createState() => _CustomCommonButtonState();
}

class _CustomCommonButtonState extends State<CustomCommonButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
        color: widget.color?? bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icons),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
