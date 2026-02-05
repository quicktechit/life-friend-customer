import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/pages/home/exclusiveMenu/notificationsPage.dart';
import 'package:pickup_load_update/src/pages/home/exclusiveMenu/offerPage.dart';
import 'package:pickup_load_update/src/pages/home/exclusiveMenu/promoOfferPage.dart';
import 'package:pickup_load_update/src/pages/notification%20page/notification_page.dart';
import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';

import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/widgets/exclusive_button_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class ExclusiveWidget extends StatefulWidget {
  const ExclusiveWidget({super.key});

  @override
  State<ExclusiveWidget> createState() => _ExclusiveWidgetState();
}

class _ExclusiveWidgetState extends State<ExclusiveWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomCardWidget(
      elevation: 5,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizeH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ExclusiveButtonWidget(
                  title: 'notifications',
                  icons: Icons.notifications,
                  onTap: () => Get.to(NotificationsPage()),
                ),
                ExclusiveButtonWidget(
                  title: 'offer',
                  icons: Icons.discount,
                  onTap: () => Get.to(OfferPage()),
                ),
                ExclusiveButtonWidget(
                  title: 'promoCode',
                  icons: Icons.percent,
                  onTap: () => Get.to(PromoOfferPage()),
                ),
              ],
            ),
            sizeH20,
          ],
        ),
      ),
    );
  }
}
