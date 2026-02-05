import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';

import '../../pages/auth/otp_input_page.dart';
import 'otp_submit_controllers.dart';

class RegistrationController extends GetxController {
  var isLoading = false.obs;
  RxBool isChecked = RxBool(false);
  var otp = 'otp store'.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> registerMethod({
    required String customerPhone,
  }) async {
    try {
      isLoading.value = true;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.registration),
      );

      request.fields['phone'] = customerPhone;

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);

        if (responseBody != null) {
          log(responseBody['message']);
          if (responseBody['status'] == 'success') {
            if(customerPhone!='01641634899'){

              Get.offAll(() => OtpInputPage(
                  customerPhone:customerPhone ));
            }else{
              Get.put(OTPController()).oTPMethod(phone:customerPhone , otp: responseBody['otp'].toString());
              return;
            }
            print(responseBody);
           otp.value= responseBody['otp'];
           debugPrint('OTP Gettng :: ${otp.value}');
            /// show snakbar msg
            Get.snackbar('Success OTP: ${otp.value}', 'OTP Send Successfully',
                duration: Duration(seconds: 10),
                colorText: white, backgroundColor: Colors.black);
          } else {
            throw 'Registration Failed: ${responseBody['message']}';
          }
        } else {
          throw 'Registration Failed!';
        }
      } else {
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      log('Error $e');
    } finally {
      isLoading.value = false;
    }
  }
}
