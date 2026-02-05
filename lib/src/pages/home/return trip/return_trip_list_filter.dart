import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/components/drawer/sidebarComponent.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/empty_box_widget.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/return%20trip%20controller/return_filter_controller.dart';
import 'package:pickup_load_update/src/pages/home/return%20trip/bid_now_page.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/car_container_widget.dart';
import 'package:pickup_load_update/src/widgets/custom%20app%20bar/app_bar_widget.dart';
import 'package:pickup_load_update/src/widgets/history_time_widget.dart';
import 'package:pickup_load_update/src/widgets/partner_bid_area_details_widget.dart';
import 'package:pickup_load_update/src/widgets/status_widget.dart';

import '../../Trip History/trip_history_page.dart';


class ReturnTripListFilterPage extends StatefulWidget {
  const ReturnTripListFilterPage({super.key});

  @override
  State<ReturnTripListFilterPage> createState() =>
      _ReturnTripListFilterPageState();
}

class _ReturnTripListFilterPageState extends State<ReturnTripListFilterPage> {
  final ReturnTripFilter returnTripFilter = Get.put(ReturnTripFilter());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AllTripHistoryController controller =
  Get.put(AllTripHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // returnTripFilter.returnTripFilter();
    returnTripFilter.returnTripFilterList() ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ExampleSidebarX(
          controller: controller.sidebarController,
        ),
      ),
      backgroundColor: bgColor,
      appBar: CustomCommonAppBar(
        title: 'Return Trip Filter'.tr,
        isReturn: true,
        scaffoldKey: _scaffoldKey,
      ),
      body: Obx(() {
        if (returnTripFilter.isLoading.value) {
          return loader(); // Show loader when loading
        }

        final trips = returnTripFilter.filterReturnTripModel.value.data;

        if (trips == null || trips.isEmpty) {
          return Center(
            child: EmptyBoxWidget(
              title: 'Oops! No Return Trip Available Now', truckImage: 'assets/images/pickup-truck-svgrepo-com.png',
            ),
          );
        }

        return ListView.builder(
          itemCount: trips.length,
          itemBuilder: (BuildContext context, int index) {
            final trip = trips[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (trip.timedate != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatusWidget(
                          iconColor: Colors.black,
                          icon: Icons.watch_later_outlined,
                          statusTitle: 'Trip Time'.tr,
                          textColor: Colors.black,
                        ),
                        HistoryTimeWidget(
                          date: trip.timedate ?? '',
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),

                if (trip.location != null && trip.destination != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: PartnerBidAreaDetails(
                          areaOne: trip.location!,
                          areaTwo: trip.destination!,
                          feeOfPartner: trip.amount ?? 'N/A',
                        ),
                      ),
                    ),
                  const SizedBox(height: 10),



                  // Vehicle Details Section
                  if (trip.getvehicle != null)
                    CarContainerWidget(
                      img: trip.getvehicle!.image != null
                          ? Urls.getImageURL(endPoint: trip.getvehicle!.image!)
                          : 'default_image_url',
                      carName: trip.getvehicle!.name ?? '',
                      capacity: trip.getvehicle!.capacity != null
                          ? '${trip.getvehicle!.capacity!} Seats Capacity'
                          : '',
                    ),
                  const SizedBox(height: 20),

                  // Bid Button Section
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: primaryButton(
                      icon: Icons.arrow_circle_right_outlined,
                      buttonName: 'Bid Your Fare'.tr,
                      onTap: () {
                        Get.to(() => ReturnTripBidNowPage(
                          partnerId: trip.partnerId?.toString() ?? '',
                          pickDivision: trip.location ?? '',
                          dropDivision: trip.destination ?? '',
                          partnerBidId: trip.id?.toString() ?? '',
                          partnerFare: trip.amount ?? '',
                          carName: trip.getvehicle?.name ?? '',
                          carImg: trip.getvehicle?.image ?? '',
                          capacity: trip.getvehicle?.capacity?.toString() ?? '',
                          tripTime: trip.timedate?.toString() ?? '',
                        ));
                        debugPrint("Trip Id: ${trip.id}");
                        debugPrint("Partner Id: ${trip.partnerId}");
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
