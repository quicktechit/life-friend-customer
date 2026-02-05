import 'dart:developer';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/promo_code_model.dart';

class PromoController extends GetxController {
  var isLoading = false.obs;
  var promoData = <PromoCodeData>[].obs;

  @override
  void onInit() {
    getPromo();
    super.onInit();
  }

  void getPromo() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.promoCode),
      );

      if (responseBody != null) {
        final PromoCodeModel offerModel = PromoCodeModel.fromJson(responseBody);

        if (offerModel.data != null && offerModel.data!.isNotEmpty) {
          promoData.assignAll(offerModel.data!);
        } else {
          throw 'Promo data is empty!';
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
