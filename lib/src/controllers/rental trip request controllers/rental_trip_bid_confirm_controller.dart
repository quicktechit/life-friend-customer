import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';
import 'package:pickup_load_update/src/models/rental_bid_confirm_model.dart';

class ReturnBidConfirmController extends GetxController {
  var isLoading = false.obs;
  var bidConfirmModel = RentalBidConfirmModel().obs;
  var trackingCode = ''.obs;
  var otp="".obs;
  var box=GetStorage();
  @override
  void onInit() {
    super.onInit();
    bidConfirm();
  }

  Future<void> bidConfirm({
     dynamic bidId,
     dynamic tripId,
  }) async {
    try {
      isLoading.value = true;

      SharedPreferencesManager _prefsManager =
          await SharedPreferencesManager.getInstance();
      String? token = _prefsManager.getToken();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.bidConfirm),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['bid_id'] = bidId.toString();
      request.fields['trip_id'] = tripId.toString();

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);

        if (responseBody != null) {
          if (responseBody['status'] == 'success') {
            bidConfirmModel.value =
                RentalBidConfirmModel.fromJson(responseBody);

            trackingCode.value =
                bidConfirmModel.value.data!.tripConfirm!.trackingId.toString();
            otp.value =
                bidConfirmModel.value.data!.tripConfirm!.otp.toString();
            box.write("liveBidStart",false);
            box.write("liveBidTruckStart",false);
            Get.snackbar('Success', 'Bid Confirm Successfully',
                colorText: white, backgroundColor: Colors.black);
            print(
                "Bid Confirm Data is============================$responseBody");


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
      Get.snackbar('Sorry', 'Trip Request Failed $e',
          colorText: white, backgroundColor: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }
}
