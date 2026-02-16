import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/pages/single%20history%20trip%20details/single_history_trip_details.dart';

class CustomForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderRadius;
  final Widget? sufIcon;
 final  onChange;

  const CustomForm({
    super.key,
    required this.hintText,
    required this.controller,
    this.onChange,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = primaryColor,
    this.borderRadius = 8,
    this.sufIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        onChanged: onChange,
        controller: controller,
        style: TextStyle(fontSize: 16, color: black54),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: black54),
          suffix: sufIcon,
          // 👇 Default Border
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: 1),
          ),

          // 👇 Focused Border
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: focusedBorderColor, width: 1.5),
          ),

          // 👇 Error Border (optional but recommended)
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
        ),
      ),
    );
  }
}
