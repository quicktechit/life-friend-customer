import 'dart:developer';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/cancel_model.dart';
import 'package:pickup_load_update/src/models/live_bidding_model.dart';

class LiveBiddingController extends GetxController {
  var isLoading = false.obs;
  var cancelModel=CancelModel().obs;
  var beforeCancelList=<CustomerBoforeData>[].obs;
  var afterCancelList=<CustomerAfterData>[].obs;
  var liveBidData = <TripList>[].obs;
  var filteredLiveBidData = <TripList>[].obs;
  var filteredLiveBidDataTruck = <TripList>[].obs;

  @override
  void onInit() async {
    getLiveBid();
    getCancelList();
    super.onInit();
  }

  void getLiveBid() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.liveBid),
      );

      if (responseBody != null) {
        final LiveBiddingModel rentalTrip =
            LiveBiddingModel.fromJson(responseBody);

        if (rentalTrip.tripList != null && rentalTrip.tripList!.isNotEmpty) {
          liveBidData.clear();
          // filteredLiveBidData.clear();

          liveBidData.assignAll(rentalTrip.tripList!);

          filteredLiveBidDataTruck.assignAll(
              rentalTrip.tripList!.where((trip) => trip.categoryId == 1).toList()
          );
          filteredLiveBidData.assignAll(
              rentalTrip.tripList!.where((trip) => trip.categoryId != 1).toList()
          );
        } else {
          throw 'Live Bid History data is empty!';
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
}
