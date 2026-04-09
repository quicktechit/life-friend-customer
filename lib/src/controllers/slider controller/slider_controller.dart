import 'dart:developer';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/slider_model.dart';

class SliderController extends GetxController {
  var isLoading = false.obs;
  var sliderData = <SliderData>[].obs;

  @override
  void onInit() {
    getSlider();
    super.onInit();
  }

  void getSlider() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.sliders),
      );

      if (responseBody != null) {
        final SliderModel sliderModel = SliderModel.fromJson(responseBody);

        if (sliderModel.data.isNotEmpty) {
          sliderData.assignAll(sliderModel.data);
        } else {
          throw 'Slider data is empty!';
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
