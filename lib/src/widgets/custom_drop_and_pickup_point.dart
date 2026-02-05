import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/status_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class DropAndPickupWidget extends StatefulWidget {
  final String dropPoint;
  final String pickPoint;
  final String? viaPoint;

  const DropAndPickupWidget(
      {super.key,
      required this.dropPoint,
      required this.pickPoint,
      this.viaPoint});

  @override
  State<DropAndPickupWidget> createState() => _DropAndPickupWidgetState();
}

class _DropAndPickupWidgetState extends State<DropAndPickupWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 155,
      width: Get.width,
      color: white,
      child: Padding(
        padding: paddingH10V20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 10,
                ),
                sizeH5,
                Container(
                  height: 80,
                  width: .5,
                  color: black,
                ),
                sizeH5,
                Container(
                  height: 18,
                  width: 18,
                  color: Colors.green,
                ),
              ],
            ),
            sizeW20,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: 'pickUpPoint',
                    fontSize: 14,
                    color: black45,
                  ),
                  KText(
                    text: widget.pickPoint,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  sizeH5,
                  Container(
                    height: .5,
                    width: Get.width,
                    color: grey.shade300,
                  ),
                  sizeH5,
                  KText(
                    text: 'Via Point',
                    fontSize: 14,
                    color: black45,
                  ),
                  sizeH5,
                  KText(
                    text: widget.viaPoint!,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  Container(
                    height: .5,
                    width: Get.width,
                    color: grey.shade300,
                  ),
                  KText(
                    text: 'dropOffPoint',
                    fontSize: 14,
                    color: black45,
                  ),
                  KText(
                    text: widget.dropPoint,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
