import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';

class CustomForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomForm(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.sourceCodePro(
          fontSize: 16,
          color: black54,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              // color: primaryColor,
              color: grey.shade300,
              width: .4,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: grey.shade300,
              width: .4,
            ),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.sourceCodePro(
            fontSize: 12,
            color: black54,
          ),
        ),
      ),
    );
  }
}
