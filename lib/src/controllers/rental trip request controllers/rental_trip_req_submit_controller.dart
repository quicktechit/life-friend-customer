import 'dart:convert';
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
  var liveBidStart = false.obs;
  var liveBidTruckStart = false.obs;
  var box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    liveBidStart.value = box.read("liveBidStart") == true ? true : false;
    liveBidTruckStart.value = box.read("liveBidTruckStart") == true
        ? true
        : false;
  }

  var selectedAnswers = <int, String>{}.obs;

  void setAnswer(int questionId, String answer) {
    selectedAnswers[questionId] = answer;
  }

  /// convert to API format
  List<Map<String, dynamic>> get formattedQuestions {
    return selectedAnswers.entries.map((e) {
      return {"question_id": e.key, "answer": e.value};
    }).toList();
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

      log(Urls.rentalTripSubmit);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = jsonEncode({
        "category_id": int.parse(categoryID),
        "pickup_location": pickUpLocation,
        "via_location": viaLocation,
        "dropoff_location": dropLocation,
        "datetime": dateTime,
        "round_trip": roundTrip == "1" ? 1 : 0,
        "round_datetime": roundTripTimeDate,
        "note": note,
        "map": map,
        "dropoff_map": dropMap,
        "is_hourly": isHour ? 1 : 0,
        "hours": '1',
        "is_airport": isAirport ? 1 : 0,
        "vehicle_id": int.tryParse(vehicleId),
        'questions': formattedQuestions,
        // "pickup_division": int.parse(pickupDivision),
        // "dropoff_division": 1, // add properly
        "promo_key": promoCode,
      });

      print(body);
      var response = await http.post(
        Uri.parse(Urls.rentalTripSubmit),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);

        if (responseBody != null) {
          if (responseBody['status'] == 'success') {
            Get.snackbar(
              'Congress',
              'Trip Request Submit',
              colorText: white,
              backgroundColor: Colors.black,
            );
            tripBid.value = responseBody['data']['id'];
            final responseId = responseBody['data']['id'];
            if (responseId != null) {
              tripBid(responseId);
              box.write("ID", responseId);
              id(responseId);

              log('Successfully set ID: $responseId');
              box.write("liveBidStart", true);
              log(
                box.read('liveBidStart').toString(),
                name: "LiveBid value====>>>",
              );
              liveBidStart.value = true;
            } else {
              throw 'ID not found in response';
            }
          } else {
            throw 'Failed: ${responseBody['message']}';
          }
        } else {
          throw 'Failed!';
        }
      } else {
        print(response.statusCode);
        print(response.reasonPhrase);
        print(response.body);
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      log('Error $e');
      Get.snackbar(
        'Error',
        'Trip Request Failed $e',
        colorText: white,
        backgroundColor: Colors.redAccent,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
