import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class StatusWidget extends StatelessWidget {
  final String statusTitle;
  final Color textColor;
  final Color? bgColors;
  final Color? iconColor;
  final IconData? icon;

  const StatusWidget(
      {super.key,
      required this.statusTitle,
      required this.textColor,
      this.bgColors,
      this.iconColor,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: bgColors ?? primaryColor50,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            sizeW10,
            Icon(
              icon,
              color: iconColor,
              size: 18,
            ),
            SizedBox(width: 5),
            KText(
              text: statusTitle,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: textColor,
            )
          ],
        ),
      ),
    );
  }
}
