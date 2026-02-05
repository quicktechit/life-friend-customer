import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';
import 'package:pickup_load_update/src/models/filter_return_trip_model.dart';

class ReturnTripFilter extends GetxController {
  RxBool isLoading = RxBool(false);
  var filterReturnTripModel = FilterReturnTripModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> returnTripFilter({
    required String pickUpLocation,
    required String carId,
    required String dropLocation,
  }) async {
    try {
      isLoading.value = true;

      SharedPreferencesManager _prefsManager =
          await SharedPreferencesManager.getInstance();
      String? token = _prefsManager.getToken();
      log(Urls.returnFilter);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.returnFilter),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['pickup_division'] = pickUpLocation;
      request.fields['dropoff_division'] = dropLocation;
      request.fields['vehicle_id'] = carId;

      var response = await http.Response.fromStream(await request.send());
      print(response.body);

      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);

        if (responseBody != null) {
          if (responseBody['status'] == 'success') {
            filterReturnTripModel.value =
                FilterReturnTripModel.fromJson(responseBody);

           debugPrint("Getting Data :: ${filterReturnTripModel.value.data?.length}");
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

  Future<void> returnTripFilterList() async {
    try {
      isLoading.value = true;

      SharedPreferencesManager _prefsManager =
      await SharedPreferencesManager.getInstance();
      String? token = _prefsManager.getToken();

      log(Urls.returnAllTrip);
      var headers = {
        'Authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse(Urls.returnAllTrip));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseBody);

        filterReturnTripModel.value = FilterReturnTripModel.fromJson(jsonData);
      }
      else {
        print(response.reasonPhrase);
      }
      filterReturnTripModel.refresh();
    } catch (e) {
      log('Error $e');
      Get.snackbar('Error', 'Trip Request Failed $e',
          colorText: white, backgroundColor: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<FilterReturnTrip>> fetchReturnTrips({required String pickUpLocation, required String carID, required String dropOff}) async {
    try {
      await returnTripFilter(
        pickUpLocation: pickUpLocation,
        carId: carID,
        dropLocation: dropOff,
      );

      return filterReturnTripModel.value.data ?? [];
    } catch (e) {
      print('Error fetching return trips: $e');
      return [];
    }
  }
}
