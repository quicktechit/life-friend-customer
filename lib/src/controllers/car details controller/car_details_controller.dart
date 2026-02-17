import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';
import 'package:pickup_load_update/src/models/car_details_model.dart';

class CarDetailsController extends GetxController {
  var isLoading = false.obs;
  var carDetailsModel = CarDetailsModel().obs;

  @override
  void onInit() {
    super.onInit();
    carDetails();
  }

  Future<void> carDetails({
    String? tripId,
    String? bidId,
  }) async {
    try {
      isLoading.value = true;

      SharedPreferencesManager prefsManager =
          await SharedPreferencesManager.getInstance();
      String? token = prefsManager.getToken();

      var request = http.Request(
        'POST',
        Uri.parse(Urls.carDetails),
      );
      request.headers['Content-Type'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      request.body = jsonEncode({"trip_id": tripId, "bid_id": bidId});

      var response = await http.Client().send(request);
      var responseBody = await response.stream.bytesToString();

      print(responseBody);

      if (response.statusCode == 200) {
        dynamic decodedResponse = jsonDecode(responseBody);

        if (decodedResponse != null) {
          if (decodedResponse['status'] == 'success') {
            carDetailsModel.value = CarDetailsModel.fromJson(decodedResponse);
          } else {
            throw 'Failed';
          }
        } else {
          throw 'Failed!';
        }
      } else {
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      log('Error $e');
    } finally {
      isLoading.value = false;
    }
  }
}
