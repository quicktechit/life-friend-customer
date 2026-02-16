import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';
import 'package:pickup_load_update/src/controllers/profile%20controllers/profile_get_controller.dart';
import 'package:pickup_load_update/src/pages/auth/AuthStartVerifyPage.dart';
import 'package:pickup_load_update/src/pages/guide%20line/about_us_page.dart';
import 'package:pickup_load_update/src/pages/help/helpPage.dart';
import 'package:pickup_load_update/src/pages/home/exclusiveMenu/offerPage.dart';
import 'package:pickup_load_update/src/pages/home/exclusiveMenu/promoOfferPage.dart';
import 'package:pickup_load_update/src/pages/notification%20page/notification_page.dart';
import 'package:pickup_load_update/src/pages/profile/profilePage.dart';
import 'package:pickup_load_update/src/widgets/lang/langWidget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:sidebarx/sidebarx.dart';

class ExampleSidebarX extends StatefulWidget {
  const ExampleSidebarX({
    super.key,
    required SidebarXController controller,
  })  : _controller = controller;

  final SidebarXController _controller;

  @override
  State<ExampleSidebarX> createState() => _ExampleSidebarXState();
}

class _ExampleSidebarXState extends State<ExampleSidebarX> {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      headerDivider: Divider(),

      controller: widget._controller,
      theme: SidebarXTheme(
        width: 12,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Colors.grey,
        textStyle: TextStyle(color: Colors.black),
        selectedTextStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      headerBuilder: (context, extended) {
        return Column(
          children: [
            SizedBox(height: 60.h),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 60,
                backgroundImage: NetworkImage(
                  Urls.getImageURL(
                    endPoint: _profileController.image.toString(),
                  ),
                ),
              ),
            ),
            sizeH10,
            KText(
              text: _profileController.customerName.toString(),
              color: Colors.black,
              fontSize: 18.h,
              fontWeight: FontWeight.bold,
            ),
            sizeH5,
            KText(
              text: _profileController.phone.toString(),
              color: Colors.black,
              fontSize: 16,
            ),
          ],
        );
      },
      items: [
        SidebarXItem(
          iconWidget: Image.asset(
            "assets/images/pro.png",
            scale: 19,
          ),
          label: 'profile'.tr,
          onTap: () {
            Get.to(() => ProfilePage());
          },
        ),
        SidebarXItem(
          iconWidget: Image.asset(
            "assets/images/information.png",
            scale: 19,
          ),
          label: 'aboutUs'.tr,
          onTap: () {
            Get.to(() => AboutUs());
          },
        ),
        // SidebarXItem(
        //   iconWidget: Icon(Icons.access_time,size: 22,),
        //   label: 'all trip'.tr,
        //   onTap: () {
        //     Get.to(() => QuickTechAllTripScreen());
        //   },
        // ),
        SidebarXItem(
          iconWidget: Image.asset(
            "assets/images/world.png",
            scale: 19,
          ),
          label: 'language'.tr,
          onTap: () {
            Get.to(() => LanguagesWidget());
          },
        ),
        SidebarXItem(
          iconWidget: Image.asset(
            "assets/images/help-web-button.png",
            scale: 19,
          ),
          label: 'help'.tr,
          onTap: () {
            Get.to(() => HelpPage());
          },
        ),
        SidebarXItem(
          iconWidget: Image.asset(
            "assets/images/notification.png",
            scale: 19,
          ),
          label: 'notifications'.tr,
          onTap: () {
            Get.to(() => NotificationsPage());
          },
        ),
        SidebarXItem(
          iconWidget: Image.asset(
            "assets/images/discount.png",
            scale: 19,
          ),
          label: 'offer'.tr,
          onTap: () {
            Get.to(() => OfferPage());
          },
        ),
        SidebarXItem(
          iconWidget: Image.asset(
            "assets/images/promo.png",
            scale: 19,
          ),
          label: 'promoCode'.tr,
          onTap: () {
            Get.to(() => PromoOfferPage());
          },
        ),
        SidebarXItem(
          iconWidget: Image.asset(
            "assets/images/logout.png",
            scale: 19,
          ),
          label: 'logOUt'.tr,
          onTap: () {
            _showLogoutConfirmationDialog(context);
          },
        ),
      ],
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('logOUt'.tr),
          content: Text('logOutMessage'.tr),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'no'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                _handleLogout();
              },
              child: Text(
                'yes'.tr,
                style: TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleLogout() {
    SharedPreferencesManager.getInstance().then((manager) {
      manager.clearAll();
    });
    Get.offAll(() => AuthStartPage());
  }
}
