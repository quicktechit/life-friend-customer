import 'dart:developer';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/offers_model.dart';

class OfferController extends GetxController {
  var isLoading = false.obs;
  var offerModelData = <OfferData>[].obs;

  @override
  void onInit() {
    getOffers();
    super.onInit();
  }

  void getOffers() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.offers),
      );

      if (responseBody != null) {
        final OfferModel offerModel = OfferModel.fromJson(responseBody);

        if (offerModel.data != null && offerModel.data!.isNotEmpty) {
          offerModelData.assignAll(offerModel.data!);
        } else {
          throw 'Offers data is empty!';
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
