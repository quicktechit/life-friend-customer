import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class CarSelectedOption extends StatefulWidget {
  final String carImg;
  final String carName;
  final String capacity;

  const CarSelectedOption({
    super.key,
    required this.carImg,
    required this.carName,
    required this.capacity,
  });

  @override
  State<CarSelectedOption> createState() => _CarSelectedOptionState();
}

class _CarSelectedOptionState extends State<CarSelectedOption> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 70,
      width: Get.width,
      color: white,
      child: Padding(
        padding: paddingH10,
        child: Row(
          children: [
            Image.network(
              widget.carImg,
              height: 50,
            ),
            sizeW20,
            SizedBox(
              width: Get.width / 2.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: widget.carName,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 3),
                  KText(
                    text: widget.capacity,
                    fontSize: 14,
                    color: black45,
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
