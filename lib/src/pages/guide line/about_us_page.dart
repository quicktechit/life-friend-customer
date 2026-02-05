import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/guide%20line/aboutus_controller.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import '../../widgets/text/kText.dart';

class AboutUs extends StatefulWidget {
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final AboutUsController aboutUsController = Get.put(AboutUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appbarTitle: 'aboutUs'.tr,
      ),
      body: Obx(() {
        if (aboutUsController.isLoading.value) {
          return Center(child: loader());
        } else {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 125.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 166.h,
                      ),
                      KText(
                        text: "aboutUs",
                        fontWeight: FontWeight.bold,
                        fontSize: 18.h,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        aboutUsController.aboutUsText.toString(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
