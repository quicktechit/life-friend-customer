import 'dart:developer';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/guide_lines_model.dart';

class AboutUsController extends GetxController {
  var isLoading = false.obs;
  var aboutUS = GuideLinesModel().obs;
  var aboutUsText = ''.obs;
  var terms = ''.obs;
  var call = ''.obs;
  var website = ''.obs;
  var mail = ''.obs;
  var videoOne = ''.obs;
  var videoTwo = ''.obs;

  var faq = <Faq>[].obs;

  @override
  void onInit() {
    getAboutUS();
    super.onInit();
  }

  void getAboutUS() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.guideLine),
      );

      if (responseBody != null) {
        final GuideLinesModel guideLinesModel =
            GuideLinesModel.fromJson(responseBody);

        if (guideLinesModel.data != null &&
            guideLinesModel.data!.guide != null) {
          aboutUsText.value = guideLinesModel.data!.guide!.privacyPolicy ?? "";
          terms.value = guideLinesModel.data!.guide!.terms ?? "";
          website.value = guideLinesModel.data!.guide!.terms ?? "";
          call.value = guideLinesModel.data!.guide!.terms ?? "";
          mail.value = guideLinesModel.data!.guide!.terms ?? "";



          videoOne.value = guideLinesModel.data!.guide!.rentalVideoLink ?? "";
          videoTwo.value = guideLinesModel.data!.guide!.returnVideoLink ?? "";



          log("Video One URL: ${videoOne.value}");
          log("Video Two URL: ${videoTwo.value}");

          if (guideLinesModel.data?.faqs != null) {
            faq.assignAll(guideLinesModel.data!.faqs!);
          } else {
            faq.clear();
          }
        } else {
          throw 'Privacy policy data is null!';
        }
      } else {
        throw 'Unable to load guide lines data!';
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
