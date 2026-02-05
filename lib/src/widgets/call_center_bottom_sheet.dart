// custom_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';

import 'package:pickup_load_update/src/widgets/divider_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class CustomBottomSheetCallCenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height / 2,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.h, 5, 12.h, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            DividerWidget(title: 'Helpline Details'),
            SizedBox(height: 20.h),
            KText(text: "Safety Car Ride With Safety"),
            SizedBox(height: 160.h),

          ],
        ),
      ),
    );
  }
}
