import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/components/bottom%20navbar/bottom.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';
import 'package:pickup_load_update/src/pages/auth/AuthStartVerifyPage.dart';

import '../welcome screen/onboard_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   String? token;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferencesManager _prefsManager =
    await SharedPreferencesManager.getInstance();
    token = _prefsManager.getToken();

    log(token.toString());
    Timer(Duration(seconds: 2), () {
      if (token == null) {
        Get.to(() => OnboardPage());
      } else {

        Get.offAll(() => DashboardView());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(image: AssetImage('assets/images/logo.png')),
      ),
    );
  }
}

