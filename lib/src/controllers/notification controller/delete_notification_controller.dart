import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';

class DeleteNotificationController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() async {
    getNotificationDelete();
    super.onInit();
  }

  void getNotificationDelete() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.notificationListDelete),
      );

      if (responseBody != null) {
        if (responseBody['status'] == 'success') {
          Get.snackbar('Success', 'All Notification Delete',
              colorText: white, backgroundColor: Colors.black);
          print('Notifications cleared successfully.');
        } else {
          throw 'Failed to clear notifications!';
        }
      } else {
        throw 'Unable to load slider data!';
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
