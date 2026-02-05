import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class DriverInformationWidget extends StatelessWidget {
  final String driverName;
  final String driverCall;
  final String driverImg;
  final String email;

  final VoidCallback onTap;
  final String title;

  const DriverInformationWidget(
      {super.key,
        required this.driverName,
        required this.driverCall,
        required this.driverImg,
        required this.onTap,
        required this.title, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              driverImg,
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
                  text: driverName,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 3),
                KText(
                  text: driverCall,
                  fontSize: 15,
                  color: black45,
                ),
                KText(
                  text: email,
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
