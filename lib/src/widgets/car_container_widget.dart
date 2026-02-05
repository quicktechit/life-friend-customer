import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

import '../configs/appColors.dart';

class CarContainerWidget extends StatelessWidget {
  final String img;
  final String carName;
  final String capacity;
  const CarContainerWidget(
      {super.key,
      required this.img,
      required this.carName,
      required this.capacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.network(
              img,
              scale: 2,
            ),
            sizeW20,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: carName,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 3),
                KText(
                  text: capacity,
                  fontSize: 14,
                  color: black45,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
