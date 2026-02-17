import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/car%20category%20controller/car_category_list_controller.dart';
import 'package:pickup_load_update/src/controllers/live%20location%20controller/live_location_controller.dart';
import 'package:pickup_load_update/src/controllers/vehicles%20categoris/quick_tech_vehicles_controller.dart';
import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

import '../../../controllers/airport/quick_tech_airport_cotnroller.dart';
import '../../../controllers/rental trip request controllers/rental_trip_req_submit_controller.dart';
import '../../live bidding/live_bidding_page.dart';

class TruckListPage extends StatefulWidget {
  final bool isAirport;
  final bool? isTrac;
  final String tripType;
  final String carImg;
  final String carName;
  final String capacity;
  final String carId;
  final String pickUpPoint;
  final String dropPoint;
  final String viaPoint;
  final String roundTrip;
  final String tripDetailsJourney;
  final String map;
  final String dropOffMap;
  final String note;
  final String categoryID;
  final String promoCode;
  final String roundTripDetailsJourney;
  final String pickupDivision;
  final String dropOfDivision;

  const TruckListPage(
      {super.key, required this.isAirport,
      this.isTrac,
      required this.tripType,
      required this.carImg,
      required this.carName,
      required this.capacity,
      required this.carId,
      required this.pickUpPoint,
      required this.dropPoint,
      required this.viaPoint,
      required this.roundTrip,
      required this.tripDetailsJourney,
      required this.map,
      required this.dropOffMap,
      required this.note,
      required this.categoryID,
        required this.promoCode,
    required this.roundTripDetailsJourney,
    required this.pickupDivision,
    required this.dropOfDivision,
  });

  @override
  State<TruckListPage> createState() => _TruckListPageState();
}

class _TruckListPageState extends State<TruckListPage> {
  final CarCategoryController carCategoryController =
      Get.put(CarCategoryController());

  final vehicleController = Get.put(QuickTechVehiclesController());

  // Variable to store the selected item
  final Rxn<dynamic> selectedItem = Rxn<dynamic>();
  final airportController = Get.put(QuickTechAirportController());
  final locationController = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          widget.isTrac == true
              ? 'truckTrip'.tr
              : widget.isAirport == true
                  ? "airportTrip".tr
                  : "carTrip".tr,
          style: TextStyle(color: Colors.white, fontSize: 17.h),
        ),
      ),
      body: Obx(
        () {
          if (carCategoryController.isLoading.value) {
            return Center(
              child: loader(),
            );
          } else {
            return Padding(
              padding: paddingH10,
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: vehicleController
                            .vehicleCategories.value.data?.length,
                        itemBuilder: (c, i) {
                          final item = vehicleController
                              .vehicleCategories.value.data
                              ?.elementAt(i);
                          return Obx(
                            () => CustomCardWidget(
                              onTap: () {
                                selectedItem.value = item;
                              },
                              elevation: 1,
                              color: selectedItem.value == item
                                  ? primaryColor
                                  : Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                     /*   item?.image != null ?Image.network(
                                          Urls.getImageURL(
                                              endPoint: item!.image.toString()),
                                          scale: 1,
                                        ):SizedBox(),*/
                                      /*  Spacer(),*/
                                        KText(
                                          text: item!.name.toString(),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        sizeW5,
                                        KText(
                                          text: "Seats Capacity",
                                          fontSize: 14,
                                          color: black54,
                                        ),
                                        KText(
                                          text: "  ${item.capacity}",
                                          fontSize: 14,
                                          color: black54,
                                        ),
                                        sizeW5,
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        KText(text: 'Price : ${((double.parse(locationController.distance.value)*21)+(50*(i+1))).toStringAsFixed(0)} BDT',fontSize: 18,),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      KText(text: 'Distance : ${double.parse(locationController.distance.value)} km',fontSize: 18,),
                                      KText(text: 'Time : ${locationController.reachTime.value}',fontSize: 18,),
                                    ],)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: selectedItem.value != null
                            ? () {
                          debugPrint('Car id :: ${selectedItem.value!.id.toString()}');
                          debugPrint('latitute ${widget.map}');
                          debugPrint('latitute  ${widget.dropOffMap}');
                                RentalTripSubmitController().rentalFormSubmit(
                                    pickUpLocation: widget.pickUpPoint,
                                    viaLocation: widget.viaPoint,
                                    dropLocation: widget.dropPoint,
                                    dateTime: widget.tripDetailsJourney,
                                    map: widget.map,
                                    categoryID:'2',
                                    roundTrip: widget.roundTrip,
                                    promoCode: '',
                                    roundTripTimeDate:
                                        widget.roundTripDetailsJourney,
                                    vehicleId: selectedItem.value!.id.toString(),
                                    isAirport: widget.isAirport,
                                    dropMap: widget.dropOffMap,
                                    isHour: airportController
                                                .selectedTripType.value ==
                                            'round'
                                        ? false
                                        : true,
                                    hour: airportController
                                                .selectedTripType.value ==
                                            'round'
                                        ? '0'
                                        : airportController.hour.value
                                            .toString(),
                                    note: widget.note,
                                    pickupDivision:locationController.pickupDivision.value,
                                    // dropOfDivision: widget.dropOfDivision
                                );
                                Get.to(() => LiveBiddingPage(
                                      createdAt:
                                          DateTime.now().toLocal().toString(), type: 'Truck',
                                    ));
                              }
                            : null, // Disable if no item selected
                        child: Text(
                          "submit".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedItem.value != null
                              ? primaryColor
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
