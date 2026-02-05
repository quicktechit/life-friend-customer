import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';

class RentalTripSubmitController extends GetxController {
  var isLoading = false.obs;
  RxInt tripBid = RxInt(0);
  var id = 0.obs;
  var liveBidStart=false.obs;
  var liveBidTruckStart=false.obs;
  var box=GetStorage();

  @override
  void onInit() {
    super.onInit();
    liveBidStart.value=box.read("liveBidStart")==true?true:false;
    liveBidTruckStart.value=box.read("liveBidTruckStart")==true?true:false;
  }

  Future<void> rentalFormSubmit({
    required String pickUpLocation,
    required String viaLocation,
    required String dropLocation,
    required String dateTime,
    required String map,
    required String dropMap,
    required String roundTrip,
    required String roundTripTimeDate,
    required String vehicleId,
    required String promoCode,
    required String pickupDivision,
    // required String dropOfDivision,
    required bool isHour,
    required String hour,
    required String note,
    required String categoryID,
    required bool isAirport,
  }) async {
    try {
      isLoading.value = true;

      /// token access
      SharedPreferencesManager _prefsManager =
          await SharedPreferencesManager.getInstance();
      String? token = _prefsManager.getToken();
      var headers = {
        'Authorization': 'Bearer $token',
      };

      var request =
          http.MultipartRequest('POST', Uri.parse(Urls.rentalTripSubmit));
// Add common fields
      request.fields.addAll({
        'category_id': '$categoryID',
        'pickup_location': '$pickUpLocation',
        'via_location': '$viaLocation',
        "pickup_division": pickupDivision,
        // "dropoff_division": dropOfDivision,
        'dropoff_location': '$dropLocation',
        'datetime': '$dateTime',
        'round_trip': '$roundTrip',
        'round_datetime': '$roundTripTimeDate',
        'note': '$note',
        'map': map,
        'dropoff_map':dropMap,
        'is_hourly':isHour==true?"1":"0" ,
        'hours': '3',
        'is_airport': '${isAirport == true ? '1' : '0'}',
      });

      if (vehicleId.isNotEmpty && vehicleId != '0') {
        request.fields['vehicle_id'] = '$vehicleId';
      }
      debugPrint('Request Fields:: ${request.fields}');
      request.headers.addAll(headers);

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);

        if (responseBody != null) {
          if (responseBody['status'] == 'success') {
            Get.snackbar('Congress', 'Trip Request Submit',
                colorText: white, backgroundColor: Colors.black);
            tripBid.value = responseBody['data']['id'];
            final responseId = responseBody['data']['id'];
            if (responseId != null) {
              tripBid(responseId);
              box.write("ID", responseId);
              id(responseId);

              log('Successfully set ID: $responseId');
              box.write("liveBidStart", true);
              log(box.read('liveBidStart').toString(),name: "LiveBid value====>>>");
              liveBidStart.value=true;
            }else{
              throw 'ID not found in response';
            }
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
          colorText: white, backgroundColor: Colors.redAccent,);
    } finally {
      isLoading.value = false;
    }
  }
}
