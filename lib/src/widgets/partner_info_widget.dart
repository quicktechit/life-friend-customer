import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class PartnerInfoWidget extends StatelessWidget {
  final String partnerName;
  final String partnerCall;
  final String partnerImg;
  final VoidCallback onTap;
  final String title;

  const PartnerInfoWidget(
      {super.key,
      required this.partnerName,
      required this.partnerCall,
      required this.partnerImg,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              partnerImg,
              scale: 30,
            ),
            sizeW20,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                KText(
                  text: partnerName,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 3),
                KText(
                  text: partnerCall,
                  fontSize: 15,
                  color: black45,
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.call,
                color: Colors.green,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
