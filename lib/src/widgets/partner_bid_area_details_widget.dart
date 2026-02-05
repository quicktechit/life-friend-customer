import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'partner_fee_widget.dart';

class PartnerBidAreaDetails extends StatelessWidget {
  final String areaOne;
  final String areaTwo;
  final String feeOfPartner;

  const PartnerBidAreaDetails({
    super.key,
    required this.areaOne,
    required this.areaTwo,
    required this.feeOfPartner,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KText(
          text: "pickUpPoint",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        sizeH5,
        KText(
          text: areaOne,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        sizeH10,
        Container(
          height: .5,
          width: Get.width,
          color: grey.shade300,
        ),
        sizeH10,
        KText(
          text: "dropOffPoint",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        sizeH5,
        KText(
          text: areaTwo,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        sizeH5,
        const Divider(),
        PartnerFeeWidget(
          partnerFee: feeOfPartner,
        ),
      ],
    );
  }
}
