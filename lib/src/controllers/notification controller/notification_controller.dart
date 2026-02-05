import 'dart:developer';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/base_client.dart';
import 'package:pickup_load_update/src/models/notifications_model.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var notificationData = <NotificationData>[].obs;

  @override
  void onInit() async {
    getNotification();
    super.onInit();
  }

   getNotification() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.notificationList),
      );

      if (responseBody != null) {
        final NotificationsModel notifiactionModel =
            NotificationsModel.fromJson(responseBody);
        notificationData.clear();
        if (notifiactionModel.data != null &&
            notifiactionModel.data!.isNotEmpty) {
          notificationData.assignAll(notifiactionModel.data!);
        } else {
          throw 'Notification data is empty!';
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

  Future deleteNotification() async {
    try {
      isLoading(true);
       await BaseClient.handleResponse(
        await BaseClient.getRequest(api: Urls.notificationDelete),
      );
      getNotification();
    } catch (e) {
      log("Delete Error: $e");
    } finally {
      isLoading(false);
    }
  }

}
