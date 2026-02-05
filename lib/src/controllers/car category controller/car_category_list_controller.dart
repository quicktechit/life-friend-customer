import 'dart:developer';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/car_category_list_model.dart';

class CarCategoryController extends GetxController {
  var isLoading = false.obs;
  var carListData = <CarData>[].obs;

  @override
  void onInit() async {
    getCarList();
    super.onInit();
  }

  void getCarList() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.carList),
      );

      if (responseBody != null) {
        final CarCategoryListModel carModel =
            CarCategoryListModel.fromJson(responseBody);

        if (carModel.data != null && carModel.data!.isNotEmpty) {
          carListData.assignAll(carModel.data!);
        } else {
          throw 'Car data is empty!';
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
