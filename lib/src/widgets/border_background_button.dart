import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

primaryBorderButton({
  required buttonName,
  final IconData? icon,
  required void Function()? onTap,
}) =>
    ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          Colors.white,
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
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                width: 10.h,
              ),
              Icon(
                icon,
                color: Colors.black,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
