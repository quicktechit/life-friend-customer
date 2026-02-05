import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pickup_load_update/src/widgets/text/kText.dart';

class BriefDescriptionVehchile extends StatelessWidget {
  final String airCondition;
  final String metroType;
  final String brandName;

  const BriefDescriptionVehchile({
    super.key,
    required this.airCondition,
    required this.metroType, required this.brandName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(
              text: "Vehicle Brief Info:",
              fontWeight: FontWeight.bold,
              fontSize: 14.h,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Metro No : $metroType",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black54),
                ),

              ],
            ),
            Text(
              "Air-Condition No : $airCondition",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black54),
            ),
            Text(
              "Brand Name : $brandName",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
