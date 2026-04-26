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
  HelpPage({super.key});

  final AboutUsController _aboutUsController = Get.put(AboutUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: 'help'.tr),
      backgroundColor: greyBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _HelpSection(
            title: 'Contact Support'.tr,
            icon: Icons.support_agent,
            items: [
              HelpItem(
                title: 'callCenter'.tr,
                icon: Icons.phone_in_talk,
                iconColor: Colors.green,
                onTap: () => _makePhoneCall(
                  _aboutUsController
                          .aboutUS
                          .value
                          .data
                          ?.guide
                          ?.emergencyHelpline ??
                      '',
                ),
              ),
              HelpItem(
                title: 'call999'.tr,
                icon: Icons.emergency,
                iconColor: Colors.red,
                onTap: () => _makePhoneCall('999'),
              ),
              HelpItem(
                title: 'emailUs'.tr,
                icon: Icons.email,
                iconColor: Colors.blue,
                onTap: () => _sendEmail(_aboutUsController.mail.toString()),
              ),
              HelpItem(
                title: 'visitUS'.tr,
                icon: Icons.public,
                iconColor: Colors.purple,
                onTap: () =>
                    _openWebsite(_aboutUsController.website.toString()),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _HelpSection(
            title: 'Information'.tr,
            icon: Icons.info_outline,
            items: [
              HelpItem(
                title: 'faq'.tr,
                icon: Icons.help_outline,
                iconColor: Colors.orange,
                onTap: () => Get.to(() => FaqPage()),
              ),
              HelpItem(
                title: 'howToUse'.tr,
                icon: Icons.smartphone,
                iconColor: Colors.teal,
                onTap: () => Get.to(() => HowToUseAppPage()),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _HelpSection(
            title: 'Legal'.tr,
            icon: Icons.gavel,
            items: [
              HelpItem(
                title: 'terms'.tr,
                icon: Icons.description,
                iconColor: Colors.indigo,
                onTap: () => Get.to(() => TermsAndCondition()),
              ),
              HelpItem(
                title: 'privacy'.tr,
                icon: Icons.privacy_tip,
                iconColor: Colors.deepPurple,
                onTap: () => Get.to(() => PrivacyPolicy()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    // if (await canLaunchUrl(url)) {
    await launchUrl(url);
    // } else {
    //   Get.snackbar('Error'.tr, 'Could not launch $number'.tr);
    // }
  }

  Future<void> _sendEmail(String email) async {
    final Uri url = Uri(scheme: 'mailto', path: email);
    // if (await canLaunchUrl(url)) {
      await launchUrl(url);
    // } else {
    //   Get.snackbar('Error'.tr, 'Could not send email'.tr);
    // }
  }

  Future<void> _openWebsite(String website) async {
    final Uri url = Uri(scheme: 'https', path: website);
    // if (await canLaunchUrl(url)) {
      await launchUrl(url);
    // } else {
    //   Get.snackbar('Error'.tr, 'Could not open website'.tr);
    // }
  }
}

class _HelpSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<HelpItem> items;

  const _HelpSection({
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Row(
            children: [
              Icon(icon, size: 20, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Column(
                  children: [
                    _HelpTile(item: item),
                    if (index != items.length - 1)
                      Divider(
                        height: 0,
                        indent: 56,
                        color: Colors.grey.shade200,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _HelpTile extends StatelessWidget {
  final HelpItem item;

  const _HelpTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: item.iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: item.iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  HelpItem({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });
}
