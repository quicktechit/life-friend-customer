import 'dart:developer';

import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/customer_model.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var customerData = CustomerDatas().obs;
  var customerName = ''.obs;
  var profileModel=CustomerProfileModel().obs;
  var email = ''.obs;
  var id = ''.obs;
  var phone = ''.obs;
  var dob = ''.obs;
  var gender = ''.obs;
  var city = ''.obs;
  var address = ''.obs;
  var image = ''.obs;

  @override
  void onInit() {
    getProfileData(
        token:
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2NhcmJvb2suY3V0aWFpZGNvcnBvcmF0aW9uLmNvbS9hcGkvdjEvY3VzdG9tZXIvbG9naW4iLCJpYXQiOjE3MDk0NjEwNzcsImV4cCI6MTcwOTQ2NDY3NywibmJmIjoxNzA5NDYxMDc3LCJqdGkiOiIzYXFIbUFBc1BCZDZtanBHIiwic3ViIjoiMzUiLCJwcnYiOiIxZDBhMDIwYWNmNWM0YjZjNDk3OTg5ZGYxYWJmMGZiZDRlOGM4ZDYzIn0.jjLvB_KCooG_e3jUYWX66AkFQ_jwyRZYMXQk3lbFr7I");
    super.onInit();
  }

  void getProfileData({String? token}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
            api: Urls.profile()),
      );

      if (responseBody != null) {
         profileModel.value =
            CustomerProfileModel.fromJson(responseBody);
        id.value = profileModel.value.data?.id.toString() ?? '';
        customerName.value = profileModel.value.data?.name ?? '';
        email.value = profileModel.value.data?.email ?? '';
        phone.value = profileModel.value.data?.phone ?? '';
        dob.value = profileModel.value.data?.birthday ?? '';
        gender.value = profileModel.value.data?.gender ?? '';
        city.value = profileModel.value.data?.district ?? '';
        address.value = profileModel.value.data?.address ?? '';
        image.value = profileModel.value.data?.image ?? '';
      } else {
        throw 'Unable to load profile data!';
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
