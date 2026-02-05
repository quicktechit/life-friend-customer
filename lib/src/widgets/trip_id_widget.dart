import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class TripIDWidget extends StatelessWidget {
  final String tripId;
  const TripIDWidget({super.key, required this.tripId});

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
            Text("Trip ID:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: tripId,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.h,
                    ),
                  ],
                ),
                InkWell(
                    onTap: () {
                      final textToCopy = tripId;
                      Clipboard.setData(ClipboardData(text: textToCopy));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Trip ID copied: $textToCopy')),
                      );
                    },
                    child: Icon(
                      Icons.copy_sharp,
                      color: Colors.grey,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
