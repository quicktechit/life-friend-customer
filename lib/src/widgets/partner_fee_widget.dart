import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
class PartnerFeeWidget extends StatelessWidget {
  final String partnerFee;
  const PartnerFeeWidget({super.key, required this.partnerFee});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KText(
            text: 'Partner Asking Fare :',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          KText(
            text: partnerFee,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
