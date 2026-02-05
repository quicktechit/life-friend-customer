import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

import '../splash page/splash_page.dart';
import 'onboard_page.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    _checkForUpdateAndProceed();
  }

  Future<void> _loadData() async {
    Timer(Duration(seconds: 2), () {
      Get.offAll(() => SplashScreen());
    });
  }

  Future<void> _checkForUpdateAndProceed() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable &&
          updateInfo.immediateUpdateAllowed) {
        await InAppUpdate.performImmediateUpdate();
      } else {
        _loadData();
      }
    } catch (e) {
      debugPrint("Update check failed: $e");

      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: KText(
              text: 'গ্রাম কিংবা শহরে\nসারা বাংলাদেশ জুড়ে!',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
