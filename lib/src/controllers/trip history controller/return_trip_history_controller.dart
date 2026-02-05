import 'dart:developer';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/return_history_model.dart';

class ReturnHistoryController extends GetxController {
  var isLoading = false.obs;
  var returnData = <ReturnData>[].obs;

  @override
  void onInit() async {
    getReturnHistory();
    super.onInit();
  }

  void getReturnHistory() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.returnTripHistory),
      );

      if (responseBody != null) {
        final ReturnHistory returnHistory =
            ReturnHistory.fromJson(responseBody);

        if (returnHistory.data != null && returnHistory.data!.isNotEmpty) {
          returnData.assignAll(returnHistory.data!);
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
