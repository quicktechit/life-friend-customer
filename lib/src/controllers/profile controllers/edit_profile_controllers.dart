import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/configs/local_storage.dart';


class EditProfileController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> editProfileMethod({
    required String name,
    required String email,
    required String address,
    required String city,
    required String gender,
    required String dob,
    required XFile? image,
  }) async {
    try {
      isLoading.value = true;

      SharedPreferencesManager _prefsManager =
          await SharedPreferencesManager.getInstance();
      String? token = _prefsManager.getToken();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.editProfile),
      );

      request.fields['token'] = token!;
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['district'] = city;
      request.fields['address'] = address;
      request.fields['gender'] = gender;
      request.fields['birthday'] = dob;

      // Convert XFile to File
     if(image != null){
       File imageFile = File(image.path);

       // Add the image file to the request
       var imageMultipartFile = http.MultipartFile.fromBytes(
         'image',
         await imageFile.readAsBytes(),
         filename: imageFile.path.split('/').last,
       );
       request.files.add(imageMultipartFile);
     }

      // Set content-type to multipart/form-data
      request.headers['content-type'] = 'multipart/form-data';

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        dynamic responseBody = await BaseClient.handleResponse(response);

        if (responseBody != null) {
          if (responseBody['status'] == 'success') {
            Get.snackbar(
              'Success',
              'Profile Update Successfully',
              colorText: white,
              backgroundColor: Colors.black,
            );
            // Get.offAll(() => BottomNavigationBarExample());
          } else {
            log(' ${responseBody['message']}');
            log('Request failed with status: ${response.statusCode}');
            throw 'Profile Update Failed: ${responseBody['message']}';
          }
        } else {
          throw 'Profile Update Failed!';
        }
      } else {
        throw 'Request failed with status: ${response.statusCode}';
      }
    } catch (e) {
      log('Error $e');
      Get.snackbar(
        'Failed',
        'Profile Update Failed',
        colorText: white,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
