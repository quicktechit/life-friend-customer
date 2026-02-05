import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/models/single_return_trip_details_model.dart';

class SingleReturnTripDetailsController extends GetxController {
  var isLoading = false.obs;
  var returnTrip = SingleReturnTripDetailsModel().obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getReturnSingeHistory(
    String tripId,
  ) async {
    try {
      isLoading.value = true;

      SharedPreferencesManager _prefsManager =
          await SharedPreferencesManager.getInstance();
      String? token = _prefsManager.getToken();

      var body = {
        "trip_id": tripId,
      };

      var response = await http.post(
        Uri.parse(Urls.singleReturnTripDetails),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );
      print(response.body);
      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);
        returnTrip.value = SingleReturnTripDetailsModel.fromJson(responseBody);

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

  dynamic calculateDistance(String map, String dropOffMap) {
    List<String> mapCoordinates = map.split(' ');
    List<String> dropOffMapCoordinates = dropOffMap.split(' ');

    dynamic lat1 = double.parse(mapCoordinates[0]);
    dynamic lon1 = double.parse(mapCoordinates[1]);
    dynamic lat2 = double.parse(dropOffMapCoordinates[0]);
    dynamic lon2 = double.parse(dropOffMapCoordinates[1]);

    const dynamic earthRadius = 6371.0;

    dynamic dLat = (lat2 - lat1) * (pi / 180.0);
    dynamic dLon = (lon2 - lon1) * (pi / 180.0);

    // Haversine formula
    dynamic a = pow(sin(dLat / 2), 2) +
        cos(lat1 * (pi / 180.0)) *
            cos(lat2 * (pi / 180.0)) *
            pow(sin(dLon / 2), 2);
    dynamic c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    dynamic distance = earthRadius * c;

    return distance;
  }
}
