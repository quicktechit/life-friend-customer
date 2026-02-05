import 'dart:developer';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/rental_trip_history_model.dart';

class AirportTripHistoryController extends GetxController {
  var isLoading = false.obs;
  var rentalTripHistory = <Data>[].obs;

  @override
  void onInit() async {
    getAirportTrip();
    super.onInit();
  }

  void getAirportTrip() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: '${Urls.rentalTripHistory}/1/airport'),
      );

      if (responseBody != null) {
        final RentalHistory rentalTrip = RentalHistory.fromJson(responseBody);

        if (rentalTrip.data != null && rentalTrip.data!.isNotEmpty) {
          rentalTripHistory.assignAll(rentalTrip.data!);
        } else {
          throw 'Trip History data is empty!';
        }
      } else {
        throw 'Unable to load slider data!';
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
