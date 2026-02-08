import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
class CustomForm extends StatelessWidget {
  final String title;
  final String requiredStar;
  final TextEditingController controller;
  const CustomForm({super.key, required this.title, required this.requiredStar, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            KText(
              text: title.toString().tr,
              color: black54,
            ),
            KText(
              text: ' $requiredStar',
              color: primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: grey.shade300,
                  width: .5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: grey.shade300,
                  width: .5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
