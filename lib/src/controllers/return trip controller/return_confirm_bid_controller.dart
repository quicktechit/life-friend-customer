import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/components/bottom%20navbar/bottom.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';
import 'package:pickup_load_update/src/models/customer_return_bid_model.dart';

import '../../widgets/loader_util.dart';

class ReturnTripConfirmController extends GetxController {
  var isLoading = false.obs;
  var customerBid = CustomerReturnBidModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> returnTripConfirm({
    required String pickUpLocation,
    required String price,
    required String map,
    required List<String> multipleDropoffLocation,
    required List<String> multipleDropoffMap,
    required String partnerId,
    required String note,
    required String partnerBidId,
    required String returnTripId,
  }) async {
      isLoading.value = true;

      SharedPreferencesManager _prefsManager =
        await SharedPreferencesManager.getInstance();
    String? token = _prefsManager.getToken();

    var body = {
      "partner_trip_id": partnerBidId,
      "return_trip_id": partnerBidId,
      "note":note,
      "partner_id": partnerId,
        "pickup_location": pickUpLocation,
        "price": price,
        "token": token.toString(),
        "map": map,
      "multiple_dropoff_location": multipleDropoffLocation,
      "multiple_dropoff_map": multipleDropoffMap
    };

    // Make the POST request
    try {
      LoaderUtils().showLoading();
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(Urls.returnBidConfirm),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['status'] == 'success') {
            isLoading.value = false;
            LoaderUtils().hideGetLoading();
            Get.snackbar('Congress', 'Trip Request Submit',
                colorText: white, backgroundColor: Colors.black);
          Get.offAll(DashboardView());
        } else {
          isLoading.value = false;
          LoaderUtils().hideGetLoading();
          log('Request failed with message: ${responseData['message']}');
          Get.snackbar('Error', '${responseData['message']}',
              colorText: white, backgroundColor: Colors.black);
        }
        } else {
        isLoading.value = false;
        LoaderUtils().hideGetLoading();
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      LoaderUtils().hideGetLoading();

      isLoading.value = false;
      print('trip submit: $e');
    }
  }
}
