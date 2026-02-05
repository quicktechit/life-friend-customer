import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/pages/home/homePage.dart';
import 'package:pickup_load_update/src/pages/profile/profilePage.dart';

class CommonController extends GetxController {
  //bottom-nav
  List page = [
    HomePage(),
    // AllTripHistoryPage(),
    ProfilePage()
  ];
  var selectedPageIndex = 0.obs;

  //bottom-action
  void chanageBottomPageIndex(int seletedPage) {
    selectedPageIndex.value = seletedPage;
    debugPrint(selectedPageIndex.value.toString());
  }
}
