import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class ExclusiveButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icons;
  final String title;
  ExclusiveButtonWidget(
      {super.key,
      required this.onTap,
      required this.icons,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: paddingH10,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: primaryColor50,
              radius: 30,
              child: Icon(
                icons,
                size: 30,
                color: Colors.black,
              ),
            ),
            sizeH5,
            KText(
              text: title,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );

  }
}
