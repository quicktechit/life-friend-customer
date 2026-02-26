import 'dart:developer';

import 'package:get/get.dart';
import 'package:pickup_load_update/src/models/new_all_trip_history_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../configs/appBaseUrls.dart';
import '../../configs/base_client.dart';
import '../../models/cancel_model.dart';

class NewAllTripHistoryController extends GetxController{
  var isLoading = false.obs;
  var allConfirmTripHistory = <SortedTrips>[].obs;
  var allCancelTripHistory = <SortedTrips>[].obs;
  var allCompleteTripHistory = <SortedTrips>[].obs;
  var allOngoingTripHistory = <SortedTrips>[].obs;
  var beforeCancelList=<CustomerBoforeData>[].obs;
  var afterCancelList=<CustomerAfterData>[].obs;

  void getConfirmTrip() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: '${Urls.allConfirmTripHistory}'),
      );

      if (responseBody != null) {
        final NewAllTripHistoryModel rentalTrip = NewAllTripHistoryModel.fromJson(responseBody);
        allConfirmTripHistory.clear();
        if (rentalTrip.sortedTrips != null && rentalTrip.sortedTrips!.isNotEmpty) {

          allConfirmTripHistory.assignAll(rentalTrip.sortedTrips!);
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

  void getCancelTrip() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: '${Urls.allCancelTripHistory}'),
      );

      if (responseBody != null) {
        final NewAllTripHistoryModel rentalTrip =
            NewAllTripHistoryModel.fromJson(responseBody);
        allCancelTripHistory.clear();
        if (rentalTrip.sortedTrips != null &&
            rentalTrip.sortedTrips!.isNotEmpty) {
          allCancelTripHistory.assignAll(rentalTrip.sortedTrips!);
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

  void getCompleteTrip() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: '${Urls.allCompleteTripHistory}'),
      );

      if (responseBody != null) {
        final NewAllTripHistoryModel rentalTrip =
            NewAllTripHistoryModel.fromJson(responseBody);
        allCompleteTripHistory.clear();
        if (rentalTrip.sortedTrips != null &&
            rentalTrip.sortedTrips!.isNotEmpty) {
          allCompleteTripHistory.assignAll(rentalTrip.sortedTrips!);
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

  void getOngoingTrip() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: '${Urls.allOngoingTripHistory}'),
      );

      if (responseBody != null) {
        final NewAllTripHistoryModel rentalTrip =
            NewAllTripHistoryModel.fromJson(responseBody);
        allOngoingTripHistory.clear();
        if (rentalTrip.sortedTrips != null &&
            rentalTrip.sortedTrips!.isNotEmpty) {
          allOngoingTripHistory.assignAll(rentalTrip.sortedTrips!);
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

  void getCancelList() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.cancelList),
      );

      if (responseBody != null) {
        beforeCancelList.clear();
        afterCancelList.clear();
        final  cancelModel =
        CancelModel.fromJson(responseBody);

        if (cancelModel.data != null && cancelModel.data!.isNotEmpty) {
          beforeCancelList.assignAll(cancelModel.customerBoforeData!);
          afterCancelList.assignAll(cancelModel.customerAfterData!);
        } else {
          throw 'Cancel data is empty!';
        }
      } else {
        throw 'Unable to load cancel data!';
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> openMapWithDirections(
      double pickupLat,
      double pickupLng,
      double dropoffLat,
      double dropoffLng,
      ) async {
    try {
      // Using geo: scheme (Android native)
      // final geoUrl = 'geo:0,0?q=$pickupLat,$pickupLng($pickupLng,$pickupLat)&destination=$dropoffLat,$dropoffLng';

      // Better approach - use Google Maps URL
      final googleMapsUrl = 'https://www.google.com/maps/dir/$pickupLat,$pickupLng/$dropoffLat,$dropoffLng';

      // if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(
          Uri.parse(googleMapsUrl),
          mode: LaunchMode.externalApplication,
        );
      // } else {
      //   print('Could not launch maps');
      // }
    } catch (e) {
      print('Error: $e');
    }
  }
}