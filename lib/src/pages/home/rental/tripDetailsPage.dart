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

import '../../../widgets/yes_no_ambulance_button.dart';

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
  final bool isAmbulance;
  final String roundTripDetailsJourney;
  final String pickupDivision;

  const TripDetailsPage({super.key,
    required this.carImg,
    required this.carName,
    required this.capacity,
    required this.carId,
    required this.pickUpPoint,
    required this.dropPoint,
    required this.viaPoint,
    required this.categoryID,
    required this.isAmbulance,
    required this.tripDetailsJourney,
    required this.roundTrip,
    required this.note,
    required this.map,
    required this.roundTripDetailsJourney,
    required this.dropOffMap,
    required this.pickupDivision,
  });

  @override
  State<TripDetailsPage> createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  final TextEditingController addPromoController = TextEditingController();
  final RentalTripSubmitController _controller = Get.put(RentalTripSubmitController());
  final airportController = Get.put(QuickTechAirportController());
  String promoCode = '';
  var box = GetStorage();

  @override
  void initState() {
    Future.delayed(Duration(hours: 1), () {
      RentalTripExpireController().expireTripMethod(tripId: _controller.tripBid.toInt());
    });
    super.initState();
    log(" pick uf map ${widget.map}----- drop of map ${widget.dropOffMap}");
  }

  Widget _buildInfoRow(String label, String value, {Color valueColor = Colors.black87}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: KText(
              text: label,
              fontSize: 13,
              color: Colors.grey[600]!,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: KText(
              text: value,
              fontSize: 14,
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
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
                  isAirport: widget.isAmbulance,
                  dropMap: widget.dropOffMap,
                  pickupDivision: widget.pickupDivision,
                  isHour: airportController.selectedTripType.value == 'round' ? false : true,
                  hour: airportController.selectedTripType.value == 'round' ? '0' : airportController.hour.value.toString(),
                  note: widget.note
              ).then((value) {
                log(_controller.id.toString(), name: 'Debug ID');
                box.write("type", widget.categoryID == '4' ? 'Bike' : '');
                Get.to(() => LiveBiddingPage(
                  createdAt: DateTime.now().toLocal().toString(),
                  type: widget.categoryID == '4' ? 'Bike' : '',
                ));
              });
            },
          ),
        ),
      ),
      backgroundColor: bgColor,
      appBar: AppBar(

        elevation: 0,
        title: Text(
          widget.categoryID == '4' ? "rideShare".tr : "rentalTripDetails".tr,
          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 80),
        children: [
          // Vehicle Card
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: CarSelectedOption(
              carImg: widget.carImg,
              carName: widget.carName,
              capacity: "${widget.capacity} Seats Capacity",
            ),
          ),



          // Trip Route Card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: DropAndPickupWidget(
              dropPoint: widget.dropPoint,
              viaPoint: widget.viaPoint,
              pickPoint: widget.pickUpPoint,
            ),
          ),
          if(widget.isAmbulance)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor,
                      ),
                      child: const Icon(
                        Icons.medical_services,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'মেডিকেল প্রয়োজনীয়তা',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                YesNoRadioRow(
                  title:
                  "পিকআপ লোকেশন কি হাসপাতাল/ডায়াগনস্টিক সেন্টার/ক্লিনিক?",
                  value: true,
                  onChanged: (val) {
                    setState(() {});
                  },
                ),

                YesNoRadioRow(
                  title: "যানবাহনের ধরন?",
                  option1: "রোগী",
                  option2: "লাশ",
                  value: true,
                  onChanged: (val) {
                    setState(() {});
                  },
                ),

                YesNoRadioRow(
                  title:
                  "কতটি অক্সিজেন সিলিন্ডার প্রয়োজন হবে? (১টি সিলিন্ডার সবসময় থাকে)",
                  option1: "২",
                  value: true,
                  onChanged: (val) {
                    setState(() {});
                  },
                ),

                YesNoRadioRow(
                  title:
                  "মৃতদেহ অপসারণের জন্য অতিরিক্ত ফি প্রযোজ্য (বিড মূল্যের অন্তর্ভুক্ত নয়)",
                  value: true,
                  onChanged: (val) {
                    setState(() {});
                  },
                ),

                YesNoRadioRow(
                  title:
                  "রোগীর ওঠানামার জন্য কি হুইলচেয়ার প্রয়োজন? (সবসময় ৪ জন সহকারী থাকে)",
                  value: true,
                  onChanged: (val) {
                    setState(() {});
                  },
                ),

                YesNoRadioRow(
                  title: "আইসিইউ বা অ্যাম্বুলেন্সে কি ডাক্তার প্রয়োজন?",
                  value: true,
                  shodDivider: false,
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          // Trip Details Card
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow('roundTrip'.tr, widget.roundTrip == "0" ? 'No' : 'Yes',
                      valueColor: widget.roundTrip == "0" ? Colors.grey : Colors.green),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildInfoRow('TRIPDATETIME'.tr, widget.tripDetailsJourney),
                  if (widget.roundTrip != "0") ...[
                    Divider(height: 1, color: Colors.grey[200]),
                    _buildInfoRow('Return'.tr, widget.roundTripDetailsJourney),
                  ],
                ],
              ),
            ),
          ),

          // Promo Code Card
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: 'promoCode'.tr,
                          fontSize: 13,
                          color: Colors.grey[600]!,
                          fontWeight: FontWeight.w500,
                        ),
                        sizeH5,
                        KText(
                          text: promoCode.isEmpty ? 'noPromoAdded'.tr : promoCode,
                          fontSize: 15,
                          color: promoCode.isEmpty ? Colors.grey : Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('addPromoCode'.tr),
                            content: SizedBox(
                              width: 300,
                              child: CustomTextFieldWithIcon(
                                label: 'add code'.tr,
                                icon: Icons.card_giftcard,
                                controller: addPromoController,
                                hinttext: "promoCode".tr,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('close'.tr),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    promoCode = addPromoController.text;
                                  });
                                  Navigator.pop(context);
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
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.blue.shade700],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add, size: 18, color: Colors.white),
                            SizedBox(width: 4),
                            KText(
                              text: 'addPromoCode',
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.white,
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
          sizeH20
        ],
      ),
    );
  }
}
