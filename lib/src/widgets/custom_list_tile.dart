import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
class CustomListTile extends StatelessWidget {
  final IconData icons;
  final String title;
  final String content;

  const CustomListTile({super.key, required this.icons, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return  CustomCardWidget(
      width: Get.width,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 1,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: primaryColor,
            child: Icon(
              icons,
              size: 20,
              color: white,
            ),
          ),
          title: KText(
            text: title,
            color: black45,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          subtitle: KText(
            text: content,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
