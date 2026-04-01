import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/widgets/new%20all%20trip%20history/cancel_trip_history.dart';
import 'package:pickup_load_update/src/widgets/new%20all%20trip%20history/complete_trip_history.dart';

import '../../../controllers/new all trip history/all_trip_history_controller.dart';
import '../../../controllers/rental trip request controllers/rental_trip_req_submit_controller.dart';
import '../../../widgets/new all trip history/confirm_trip_history.dart';
import '../../../widgets/new all trip history/ongoing_trip_history.dart';

class QuickTechAllTripScreen extends StatelessWidget {
   QuickTechAllTripScreen({super.key});
  final NewAllTripHistoryController _controller =
  Get.put(NewAllTripHistoryController());
  final controllers= Get.put(RentalTripSubmitController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'tripHistory'.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            labelColor: Colors.white,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'ongoing'.tr),
              Tab(text: 'confirm'.tr),
              Tab(text: 'complete'.tr),
              Tab(text: 'cancel'.tr),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OngoingTripHistory(),
            AllConfirmTripHistory(),
            CompleteTripHistory(),
            CancelTripHistory(),
          ],
        ),
      ),
    );
  }
}
