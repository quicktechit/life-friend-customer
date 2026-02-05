import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class SingleTripHistoryWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const SingleTripHistoryWidget({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KText(
            text: title,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: 10.h,
          ),
          KText(
            text: subTitle,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
