import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';
import 'package:pickup_load_update/src/models/single_trip_details_model.dart';
import '../../models/single_return_trip_model.dart';

class SingleTripDetailsController extends GetxController {
  var isLoading = false.obs;
  var singleTripDetailsModel = SingleTripDetailsModel().obs;
  var singleReturnTripDetailsModel = SingleReturnTripDetailsModelNew().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> singleTripDetails(
    String tripId,
    String type,
  ) async {
    try {
      isLoading.value = true;
print("==========>>>> trip id $tripId");
      SharedPreferencesManager _prefsManager =
          await SharedPreferencesManager.getInstance();
      String? token = _prefsManager.getToken();

      print(token);
      var body = {
        "trip_id": tripId,
        "trip_type": type,
      };

      var response = await http.post(
        Uri.parse(Urls.singleTripDetails),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);
        if(type=="normal"){
          singleTripDetailsModel.value =
              SingleTripDetailsModel.fromJson(responseBody);
        }else{
          singleReturnTripDetailsModel.value=SingleReturnTripDetailsModelNew.fromJson(responseBody);
        }
        singleTripDetailsModel.refresh();
        singleReturnTripDetailsModel.refresh();

        print(responseBody);
      } else {
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      print('Error $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// calculate  distance formula

  double calculateDistance(String map, String dropOffMap) {
    List<String> mapCoordinates = map.split(' ');
    List<String> dropOffMapCoordinates = dropOffMap.split(' ');

    double lat1 = double.parse(mapCoordinates[0]);
    double lon1 = double.parse(mapCoordinates[1]);
    double lat2 = double.parse(dropOffMapCoordinates[0]);
    double lon2 = double.parse(dropOffMapCoordinates[1]);

    const double earthRadius = 6371.0;

    double dLat = (lat2 - lat1) * (pi / 180.0);
    double dLon = (lon2 - lon1) * (pi / 180.0);

    // Haversine formula
    double a = pow(sin(dLat / 2), 2) +
        cos(lat1 * (pi / 180.0)) *
            cos(lat2 * (pi / 180.0)) *
            pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    double distance = earthRadius * c;

    return distance;
  }
}
