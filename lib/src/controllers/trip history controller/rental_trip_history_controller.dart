import 'dart:developer';

import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/rental_trip_history_model.dart';

class RentalTripHistoryController extends GetxController {
  var isLoading = false.obs;
  var truckTripHistory = <Data>[].obs;
  var rentalTripHistory = <Data>[].obs;

  @override
  void onInit() async {
    getRentalTrip();
    getTruckTrip();
    super.onInit();
  }

  void getTruckTrip() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: '${Urls.rentalTripHistory}/1'),
      );

      if (responseBody != null) {
        final RentalHistory rentalTrip = RentalHistory.fromJson(responseBody);

        truckTripHistory.clear();
        if (rentalTrip.data != null && rentalTrip.data!.isNotEmpty) {
          truckTripHistory.assignAll(rentalTrip.data!);
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

  void getRentalTrip() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: '${Urls.rentalTripHistory}/2'),
      );

      if (responseBody != null) {
        final RentalHistory rentalTrip = RentalHistory.fromJson(responseBody);
        rentalTripHistory.clear();
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
