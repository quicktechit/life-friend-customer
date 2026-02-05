import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/airport/quick_tech_airport_cotnroller.dart';
import 'package:pickup_load_update/src/controllers/rental%20trip%20request%20controllers/rental_trip__expire_controller.dart';
import 'package:pickup_load_update/src/controllers/rental%20trip%20request%20controllers/rental_trip_req_submit_controller.dart';
import 'package:pickup_load_update/src/pages/live%20bidding/live_bidding_page.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/car%20selected%20option/car_selected_option_widget.dart';
import 'package:pickup_load_update/src/widgets/custom_drop_and_pickup_point.dart';
import 'package:pickup_load_update/src/widgets/rental_trip_title.dart';
import 'package:pickup_load_update/src/widgets/text/custom_text_filed_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class TripDetailsPage extends StatefulWidget {
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
  final bool isAirport;
  final String roundTripDetailsJourney;
  final String pickupDivision;
  // final String dropOfDivision;
  TripDetailsPage(
      {required this.carImg,
        required this.carName,
        required this.capacity,
        required this.carId,
        required this.pickUpPoint,
        required this.dropPoint,
        required this.viaPoint,
        required this.categoryID,
        required this.isAirport,
        required this.tripDetailsJourney,
        required this.roundTrip,
        required this.note,
        required this.map,

        required this.roundTripDetailsJourney,
        required this.dropOffMap, required this.pickupDivision,});

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  final TextEditingController addPromoController = TextEditingController();
  final RentalTripSubmitController _controller =
  Get.put(RentalTripSubmitController());
  final airportController = Get.put(QuickTechAirportController());
  String promoCode = '';
  var box=GetStorage();

  @override
  void initState() {
    Future.delayed(Duration(hours: 1), () {
      RentalTripExpireController()
          .expireTripMethod(tripId: _controller.tripBid.toInt());
    });
    super.initState();

    log(" pick uf map ${widget.map}----- drop of map ${widget.dropOffMap}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: white,
        child: Padding(
          padding: paddingH20V20,
          child: primaryButton(
            buttonName: 'requestTripRequest',
            onTap: () async {
              debugPrint('Category id ::: ${widget.categoryID}');
             await _controller.rentalFormSubmit(
                  pickUpLocation: widget.pickUpPoint,
                  viaLocation: widget.viaPoint,
                  dropLocation: widget.dropPoint,
                  dateTime: widget.tripDetailsJourney,
                  map: widget.map,
                  categoryID: widget.categoryID,
                  roundTrip: widget.roundTrip,
                  promoCode: promoCode,
                  roundTripTimeDate: widget.roundTripDetailsJourney,
                  vehicleId: widget.carId,
                  isAirport: widget.isAirport,
                  dropMap: widget.dropOffMap,
                 pickupDivision: widget.pickupDivision,
                 // dropOfDivision: widget.dropOfDivision,
                  isHour: airportController.selectedTripType.value == 'round'? false:true,
                  hour: airportController.selectedTripType.value == 'round'? '0':airportController.hour.value.toString(), note: widget.note
              ).then((value){
                log(_controller.id.toString(),name: 'Debug ID');
                box.write("type", widget.categoryID=='4'?'Bike':'');
                Get.to(() => LiveBiddingPage(createdAt: DateTime.now().toLocal().toString(), type: widget.categoryID=='4'?'Bike':'',));

              });

            },
          ),
        ),
      ),
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.categoryID=='4'?"rideShare".tr:"rentalTripDetails".tr,style: TextStyle(color: Colors.white,fontSize: 17.h),),
      ),
      body: ListView(
        children: [
          CarSelectedOption(
              carImg: widget.carImg,
              carName: widget.carName,
              capacity: "${widget.capacity} Seats Capacity"),
          sizeH5,
          DropAndPickupWidget(
            dropPoint: widget.dropPoint,
            viaPoint: widget.viaPoint,
            pickPoint: widget.pickUpPoint,
          ),
          Container(
            width: Get.width,
            color: white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: 'roundTrip',
                    fontSize: 12,
                    color: black45,
                    fontWeight: FontWeight.w600,
                  ),
                  sizeH5,
                  KText(
                    text: widget.roundTrip == "0" ? 'No' : 'Yes',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
            ),
          ),
          sizeH5,
          Container(
            width: Get.width,
            color: white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: 'TRIPDATETIME',
                    fontSize: 12,
                    color: black45,
                    fontWeight: FontWeight.w600,
                  ),
                  sizeH5,
                  KText(
                    text: widget.tripDetailsJourney,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
          sizeH5,
          Container(
            color: white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 15,
              ),
              child: Row(
                children: [
                  KText(
                    text: 'noPromoAdded',
                    fontSize: 12,
                    color: black54,
                    fontWeight: FontWeight.w600,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('addPromoCode'.tr),
                            content: Container(
                              width: 300.w,
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomTextFieldWithIcon(
                                    label: 'add code'.tr,
                                    icon: Icons.password,
                                    controller: addPromoController,
                                    hinttext: "promoCode".tr,
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('close'.tr),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    promoCode = addPromoController.text;
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('Apply'.tr),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.blue,
                            ),
                            KText(
                              text: 'addPromoCode',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
