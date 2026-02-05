import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/guide%20line/aboutus_controller.dart';
import 'package:pickup_load_update/src/pages/guide%20line/faq_page.dart';
import 'package:pickup_load_update/src/pages/guide%20line/how_use_app_page.dart';
import 'package:pickup_load_update/src/pages/guide%20line/privacy_policy_page.dart';
import 'package:pickup_load_update/src/pages/guide%20line/terms_condition_page.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  final AboutUsController aboutUsController = Get.put(AboutUsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: 'help'.tr),
      backgroundColor: greyBackgroundColor,
      body: Padding(
        padding: paddingH10,
        child: ListView(
          children: [
            sizeH10,
            customListtile(
              title: 'callCenter'.tr,
              onTap: () async {
                final Uri url =
                    Uri(scheme: 'tel', path: aboutUsController.call.toString());

                if (await launchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            sizeH5,
            customListtile(
              title: 'call999'.tr,
              onTap: () async {
                final Uri url = Uri(scheme: 'tel', path: '999');

                if (await launchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            sizeH5,
            customListtile(
              title: 'emailUs'.tr,
              onTap: () async {
                final Uri url = Uri(
                    scheme: 'mailto', path: aboutUsController.mail.toString());

                if (await launchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            sizeH5,
            customListtile(
              title: 'visitUS'.tr,
              onTap: () async {
                final Uri url = Uri(
                    scheme: 'https',
                    path: aboutUsController.website.toString());

                if (await launchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            sizeH5,
            customListtile(
              title: 'faq'.tr,
              onTap: () {
                Get.to(() => FaqPage());
              },
            ),
            sizeH5,
            customListtile(
              title: 'terms'.tr,
              onTap: () {
                Get.to(() => TermsAndCondition());
              },
            ),
            sizeH5,
            customListtile(
              title: 'privacy'.tr,
              onTap: () {
                Get.to(() => PrivacyPolicy());
              },
            ),
            sizeH5,
            customListtile(
              title: 'howToUse'.tr,
              onTap: () {
                Get.to(() => HowToUseAppPage());
              },
            ),
          ],
        ),
      ),
    );
  }

  customListtile({
    required title,
    required onTap,
  }) {
    return CustomCardWidget(
      onTap: onTap,
      elevation: 1,
      height: 60,
      width: Get.width,
      child: Padding(
        padding: paddingH20,
        child: Row(
          children: [
            KText(
              text: title,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: black45,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
