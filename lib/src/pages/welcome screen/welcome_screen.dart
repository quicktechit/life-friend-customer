import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../components/bottom navbar/bottom.dart';
import '../../configs/local_storage.dart';
import 'onboard_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
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
    SharedPreferencesManager prefsManager =
        await SharedPreferencesManager.getInstance();
    token = prefsManager.getToken();

    log(token.toString());
    Timer(Duration(seconds: 2), () {
      if (token == null) {
        Get.to(() => OnboardPage());
      } else {
        Get.offAll(() => DashboardView());
      }
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
      backgroundColor: white,
      body: Center(child: Image(image: AssetImage('assets/images/logo.png'),width: context.screenWidth/1.5,)),
    );
  }
}
