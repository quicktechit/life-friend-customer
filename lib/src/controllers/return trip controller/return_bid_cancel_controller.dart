import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/components/bottom%20navbar/bottom.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';

class ReturnTripBidCancelController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> cancelBid({
    required int bidId,

  }) async {
    try {
      isLoading.value = true;

      SharedPreferencesManager _prefsManager =
          await SharedPreferencesManager.getInstance();
      String? token = _prefsManager.getToken();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.returnBidCancel),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['bid_id'] = bidId.toString();


      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);

        if (responseBody != null) {
          if (responseBody['status'] == 'success') {
            Get.snackbar('Success', 'Bid Cancel',
                colorText: white, backgroundColor: Colors.black);
            Get.offAll(()=> DashboardView());
          } else {
            throw 'Failed: ${responseBody['message']}';
          }
        } else {
          throw 'Failed!';
        }
      } else {
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      log('Error $e');
      Get.snackbar('Error', 'Trip Request Failed $e',
          colorText: white, backgroundColor: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }
}
