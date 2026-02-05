// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';

class CustomTextFieldWithIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final String hinttext;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged; // Added onChanged option

  const CustomTextFieldWithIcon({
    key,
    required this.label,
    required this.icon,
    required this.controller,
    required this.hinttext,
    this.keyboardType = TextInputType.text,
    this.maxLines,
    this.validator,
    this.inputFormatters,
    this.onChanged, // Added onChanged option
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width,
          child: Text(
            label,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            maxLines: maxLines,
            controller: controller,
            onChanged: onChanged, // Added onChanged option
            validator: validator,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.black),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
              hintText: hinttext,
            ),
          ),
        ),
      ],
    );
  }
}
