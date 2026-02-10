import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';

import '../text/kText.dart';

ElevatedButton primaryButton({
  required buttonName,
  final IconData? icon,
  double? radius,
  required void Function()? onTap,
}) =>
    ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius??25),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          primaryColor,
        ),
      ),
      child: SizedBox(
        height: 50,
        width: Get.width,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KText(
                text: buttonName,
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                width: 10.h,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
