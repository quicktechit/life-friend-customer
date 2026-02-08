import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';

import '../../configs/local_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/vehicle_categories/quick_tech_get_vehicle_categories.dart';

class QuickTechVehiclesController extends GetxController {
  var isLoading = false.obs;
  var vehicleCategories = QuickTechGetVehicleCategories().obs;
  var data = <Data>[].obs;

  Future<void> getVehicles({required String id}) async {
    SharedPreferencesManager _prefsManager =
        await SharedPreferencesManager.getInstance();
    String? token = _prefsManager.getToken();

    var headers = {'Authorization': 'Bearer $token'};
    debugPrint('Testing ::: $token');
    var request = http.Request(
      'GET',
      Uri.parse('${Urls.domain}/api/v1/customer/category/$id'),
    );

    request.headers.addAll(headers);
    isLoading.value = true;
    http.StreamedResponse response = await request.send();
    isLoading.value = false;
    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      data.clear();
      vehicleCategories.value = QuickTechGetVehicleCategories.fromJson(
        jsonResponse,
      );
      data.value = vehicleCategories.value.data!;
      debugPrint('Fetched Categoris :: ${vehicleCategories.value.data}');
    } else {
      print("Testing Error :: ${response.reasonPhrase}");
    }
  }
}
