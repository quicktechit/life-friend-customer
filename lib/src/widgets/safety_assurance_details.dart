// custom_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';

import 'package:pickup_load_update/src/widgets/divider_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class CustomBottomSheetInsuranceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height / 1.7,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.h, 5, 12.h, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            DividerWidget(title: 'Insurance Details'),
            SizedBox(height: 20.h),
            KText(text: "Safety Car Ride With Safety"),
            Row(children: [
              Text(
                "\u2022",
                style: TextStyle(fontSize: 30),
              ), //bullet text
              SizedBox(
                width: 10,
              ), //space between bullet and text
              Expanded(
                child: Text(
                  "Upcoming",
                  style: TextStyle(fontSize: 12),
                ), //text
              )
            ]), //one
            Row(children: [
              Text(
                "\u2022",
                style: TextStyle(fontSize: 30),
              ), //bullet text
              SizedBox(
                width: 10,
              ), //space between bullet and text
              Expanded(
                child: Text(
                  "Upcoming",
                  style: TextStyle(fontSize: 12),
                ), //text
              )
            ]),
            SizedBox(
              height: 160.h,
            ),
            Container(
              color: white,
              child: primaryButton(
                  icon: Icons.recommend,
                  buttonName: 'Okay ',
                  onTap: () {
                    Get.back();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
