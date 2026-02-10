import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/components/bottom%20navbar/bottom.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/controllers/profile%20controllers/profile_get_controller.dart';

import '../../configs/appColors.dart';
import '../../configs/local_storage.dart';
import '../rental trip request controllers/rental_trip_req_submit_controller.dart';
class CancelController extends GetxController{
  final ProfileController profileController=Get.put(ProfileController());
  RentalTripSubmitController rentalTripSubmitController = Get.find();
  var box=GetStorage();
  Future<void> sendBeforeCancel(String tripId, String cancelReasonId,
      {String type = 'n'}) async {
    SharedPreferencesManager _prefsManager =
    await SharedPreferencesManager.getInstance();
    String? token = _prefsManager.getToken();
    // API endpoint URL
    String url = Urls.tripCancel;


    log(tripId);
    // Headers with the Bearer token
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Map<String, dynamic> body = {
      'trip_id': tripId,

      'cancelreason_id': cancelReasonId,
    };

    String bodyJson = jsonEncode(body);

    try {

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: bodyJson,
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        Get.snackbar('Success', 'Trip Request cancel',
            colorText: white, backgroundColor: Colors.black);
        if(type=='n'){
          box.write("liveBidStart", false);
          rentalTripSubmitController.liveBidStart.value = false;
        }else{
          log("truck_cancel");
            box.write("liveBidTruckStart", false);
            rentalTripSubmitController
                .liveBidTruckStart.value = false;
        }



        Get.offAll(()=>DashboardView());
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Error: ${response.body}');
        Get.offAll(DashboardView());
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  Future<void> cancelTripConfirmation(String tripId, String cancelReasonId) async {

    SharedPreferencesManager _prefsManager =
    await SharedPreferencesManager.getInstance();
    String? token = _prefsManager.getToken();

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.tripConfirmCancel),
    );

    request.fields.addAll({
      'tripconfirm_id':tripId ,
     'customer_id':profileController.id.value,
      'cancelreason_id':cancelReasonId ,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {

        print('Cancel Successful: $responseBody');
        Get.offAll(()=>DashboardView());
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        print('Cancel Successful: $responseBody');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  Future<void> cancelReturnTripConfirmation(String tripId, String cancelReasonId) async {

    SharedPreferencesManager _prefsManager =
    await SharedPreferencesManager.getInstance();
    String? token = _prefsManager.getToken();

    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls.returnTripConfirmCancel),
    );

    request.fields.addAll({
      'tripconfirm_id':tripId ,
     'customer_id':profileController.id.value,
      'cancelreason_id':cancelReasonId ,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print('Cancel Successful: $responseBody');
        Get.offAll(()=>DashboardView());
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

}