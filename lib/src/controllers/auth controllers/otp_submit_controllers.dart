import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/components/bottom%20navbar/bottom.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';

class OTPController extends GetxController {
  late SharedPreferencesManager _prefsManager;
  var isLoading = false.obs;

  Future<void> oTPMethod({
    required String phone,
    required String otp,
  }) async {
    try {
      isLoading.value = true;
      _prefsManager = await SharedPreferencesManager.getInstance();

      var response = await _loginRequest(phone, otp);

      var responseBody = json.decode(response.body);
      print('Response Body: $responseBody');
      if (responseBody != null) {
        if (responseBody['status'] == 'success' &&
            responseBody['token'] != null) {
          await _prefsManager.setToken(apiToken: responseBody['token']);

          print('Token  SharedPreferencesManager ${responseBody['token']}');
          Get.snackbar('Success', 'Verification Successfully',
              colorText: white, backgroundColor: Colors.black);
          Get.offAll(() => DashboardView());
        } else if (responseBody['status'] == 'failed') {
          Get.snackbar('Sorry', '${responseBody['message']}',
              colorText: white, backgroundColor: Colors.redAccent);

          print('Error: ${responseBody['message']}');
        }
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Sorry', 'Verification Failed, try again',
          colorText: white, backgroundColor: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }

  Future<http.Response> _loginRequest(String phone, String otp) async {
    final GetStorage _storage = GetStorage();

    String? fcmToken = _storage.read('fcm_token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.otpSubmit),
    );
    request.fields['phone'] = phone;
    request.fields['verify'] = otp;
    request.fields['device_token'] = fcmToken ?? " ";

    return await http.Response.fromStream(await request.send());
  }
}
