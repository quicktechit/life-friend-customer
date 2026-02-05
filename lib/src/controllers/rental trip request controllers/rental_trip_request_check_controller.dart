import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';

class RentalFormCheckController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> rentalForm({
    required String pickUpLocation,
    required String viaLocation,
    required String dropLocation,
    required String dateTime,
    required String map,
    required String roundTrip,
    required String roundTripTimeDate,
    required String vehicleId,
    required String dropMap,

  }) async {
    try {
      isLoading.value = true;

      /// token access
      SharedPreferencesManager _prefsManager =
          await SharedPreferencesManager.getInstance();
      String? token = _prefsManager.getToken();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.rentalTripFormCheckSubmit),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['pickup_location'] = pickUpLocation;
      request.fields['via_location'] = viaLocation;
      request.fields['dropoff_location'] = dropLocation;
      request.fields['datetime'] = dateTime;
      request.fields['map'] = map;
      request.fields['round_trip'] = roundTrip;
      request.fields['round_datetime'] = roundTripTimeDate;
      request.fields['vehicle_id'] = vehicleId;
      request.fields['dropoff_map']=dropMap;


      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);

        if (responseBody != null) {
          if (responseBody['status'] == 'success') {
            Get.snackbar('Success', 'Rental Trip Request Form Checkout',
                colorText: white, backgroundColor: Colors.black);
          } else {
            throw 'Registration Failed: ${responseBody['message']}';
          }
        } else {
          throw 'Registration Failed!';
        }
      } else {
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      log('Error $e');
      Get.snackbar('Error', 'Rental Trip Request Form $e',
          colorText: white, backgroundColor: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }


}
