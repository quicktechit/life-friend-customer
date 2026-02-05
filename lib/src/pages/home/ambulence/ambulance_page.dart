import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../configs/appColors.dart';
import '../../../configs/appUtils.dart';
import '../../../configs/loader.dart';
import '../../../controllers/airport/quick_tech_airport_cotnroller.dart';
import '../../../controllers/division controller/division_controller.dart';
import '../../../controllers/live location controller/live_location_controller.dart';
import '../../../controllers/rental trip request controllers/rental_trip_request_check_controller.dart';
import '../../../models/suggestion_model.dart';
import '../../../widgets/button/primaryButton.dart';
import '../../../widgets/car selected option/car_selected_option_widget.dart';
import '../../../widgets/date and time widget/date_time_widget.dart';
import '../../../widgets/date and time widget/return_date_and_time_widget.dart';
import '../../../widgets/drop_point_widget.dart';
import '../../../widgets/note_controller.dart';
import '../../../widgets/pick_up_location_widget.dart';
import '../../../widgets/text/kText.dart';
import '../../../widgets/via_location_widget.dart';
import '../../map_page/MapSinglePickerScreen.dart';
import '../../map_page/controller/LocationPickerController.dart';
import '../rental/tripDetailsPage.dart';

class AmbulancePage extends StatefulWidget {
  final String carImg;
  final String carName;
  final String capacity;
  final String carId;

  final String tripType;

  const AmbulancePage({
    super.key,
    required this.carImg,
    required this.carName,
    required this.capacity,
    required this.carId,

    required this.tripType,
  });

  @override
  State<AmbulancePage> createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  final noteController = TextEditingController();
  final LocationPickerController locationMapController = Get.put(
    LocationPickerController(),
  );
  final DivisionController divisionController = Get.put(DivisionController());
  var isRoundTrip = false;
  int roundTripValue = 0;
  bool showViaLocation = false;
  var pickupLocation;
  var pickLat;
  var pickLng;
  var dropLat;
  var dropLng;
  var dropOffLocation;

  /// for time and date
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedReturnDate = DateTime.now();
  TimeOfDay selectedReturnTime = TimeOfDay.now();
  final LocationController locationController = Get.put(LocationController());
  final RentalFormCheckController _controller = Get.put(
    RentalFormCheckController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "requestTrip".tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Car info card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(widget.carImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.carName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${widget.capacity} Seats Capacity",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Ambulance",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Location section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                children: [
                  Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: AlignmentGeometry.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor,
                        ),
                        child: const Icon(
                          Icons.map_outlined,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Location Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  sizeH10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Vertical timeline with icons
                      Column(
                        children: [
                          // Pickup icon with timeline
                          GestureDetector(
                            onTap: () async {
                              pickupLocation = await Get.to(
                                    () => MapSinglePickerScreen(
                                  lat: double.tryParse(
                                    locationController.selectedPickUpLat.value,
                                  ),
                                  lng: double.tryParse(
                                    locationController.selectedPickUpLng.value,
                                  ),
                                ),
                              );

                              if (pickupLocation != null) {
                                Get.snackbar(
                                  "Single Location",
                                  "${pickupLocation['address']}\n(${pickupLocation['lat']}, ${pickupLocation['lng']})",
                                );

                                locationController.selectedPickUpLat.value =
                                    pickupLocation['lat'].toString();
                                locationController.selectedPickUpLng.value =
                                    pickupLocation['lng'].toString();
                                pickLat = locationController.selectedPickUpLat.value;
                                pickLng = locationController.selectedPickUpLng.value;
                                locationController.pickUpC.text =
                                    pickupLocation['address'].toString();
                                locationController.pickUpLocation.value =
                                    pickupLocation['address'].toString();
                                if (pickupLocation['place_id'] != null) {
                                  locationController.selectPikUpAddress(
                                    Suggestion(
                                      placeId: pickupLocation['place_id'],
                                      description: pickupLocation['address'],
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: primaryColor.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.location_on_outlined,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                          sizeH5,

                          // Vertical timeline connector
                          Container(
                            height: 70,
                            width: 1.5,
                            color: Colors.grey.withOpacity(0.4),
                          ),

                          // Via point indicator (conditional)
                          if (showViaLocation) ...[
                            sizeH5,
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.orange.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.route_outlined,
                                color: Colors.orange,
                                size: 18,
                              ),
                            ),
                            sizeH5,
                            Container(
                              height: 40,
                              width: 1.5,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                          ],

                          sizeH5,

                          // Dropoff icon
                          GestureDetector(
                            onTap: () async {
                              dropOffLocation = await Get.to(
                                    () => MapSinglePickerScreen(
                                  lat: double.tryParse(
                                    locationController.selectedDropUpLat.value,
                                  ),
                                  lng: double.tryParse(
                                    locationController.selectedDropUpLng.value,
                                  ),
                                ),
                              );

                              if (dropOffLocation != null) {
                                Get.snackbar(
                                  "Single Location",
                                  "${dropOffLocation['address']}\n(${dropOffLocation['lat']}, ${dropOffLocation['lng']})",
                                );
                                dropLat = dropOffLocation['lat'];
                                dropLng = dropOffLocation['lng'];
                                locationController.selectedDropUpLat.value =
                                dropOffLocation['lat'];
                                locationController.selectedDropUpLng.value =
                                dropOffLocation['lng'];
                                locationController.dropC.text =
                                dropOffLocation['address'];
                                locationController.dropLocation.value =
                                dropOffLocation['address'];
                              }
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.red.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(
                                Icons.flag_outlined,
                                color: Colors.red,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),

                      sizeW20,

                      // Location input fields
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Pickup section
                            Container(
                              margin: EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      KText(
                                        text: 'pickUpPoint'.tr,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  PickUp(),
                                ],
                              ),
                            ),
                            // // Add/Remove via point button
                            // Align(
                            //   alignment: AlignmentGeometry.centerRight,
                            //   child: InkWell(
                            //     onTap: () {
                            //       setState(() {
                            //         showViaLocation = !showViaLocation;
                            //       });
                            //     },
                            //     borderRadius: BorderRadius.circular(20),
                            //     child: Container(
                            //       width: 100,
                            //       height: 35,
                            //       decoration: BoxDecoration(
                            //         color: showViaLocation ? Colors.red[50] : Colors.green[50],
                            //         border: Border.all(
                            //           color: showViaLocation ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3),
                            //           width: 1.5,
                            //         ),
                            //       ),
                            //       child: Row(
                            //         children: [
                            //           KText(text: "Add Via Locations"),
                            //           Icon(
                            //             showViaLocation ? Icons.remove : Icons.add,
                            //             color: showViaLocation ? Colors.red : Colors.green,
                            //             size: 20,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // // Via location (conditional)
                            if (showViaLocation)
                              Container(
                                margin: EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        KText(
                                          text: 'Via Point'.tr,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    ViaLocation(),
                                  ],
                                ),
                              ),

                            // Dropoff section
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      KText(
                                        text: 'dropOffPoint'.tr,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  DropWidget(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Ambulance specific questions
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                        'Medical Requirements',
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
                    title: "Is PickUp Locations Hospital/Diagnostic Center/Clinic?",
                    value: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),


                  YesNoRadioRow(
                    title: "Vehicle Type?",
                    option1: "Patient",
                    option2: "Corpse",
                    value: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),


                  YesNoRadioRow(
                    title: "How many oxygen cylinders will be needed (1 cylinder is always there)?",
                    option1: "2",
                    value: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),


                  YesNoRadioRow(
                    title: "Fees will be charged for the removal of the deceased/dead body (not included in the bid price)",
                    value: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),


                  YesNoRadioRow(
                    title: "Will the patient need a wheelchair to get up and down (there are always four)?",
                    value: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),


                  YesNoRadioRow(
                    title: "Do you need a doctor in the ICU or ambulance?",
                    value: true,
                    onChanged: (val) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Date & Time section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          Icons.access_time,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Schedule Trip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  /// Date and Time Picker
                  DateAndTime(
                    onDateTimeSelected: (date, time) {
                      selectedDate = date;
                      selectedTime = time;
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Additional Notes
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
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
                  Text(
                    'Additional Notes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 12),
                  NoteTextFiled(controller: noteController),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// Submit Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Obx(
                    () => _controller.isLoading.value
                    ? Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 3,
                    ),
                  ),
                )
                    : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitTripRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      'Submit Trip Request',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _buildLocationField({
    required String title,
    required String hint,
    required TextEditingController controller,
    required VoidCallback onTap,
    bool isOptional = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            if (isOptional)
              Text(
                ' (Optional)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.text.isNotEmpty
                        ? controller.text
                        : hint,
                    style: TextStyle(
                      fontSize: 14,
                      color: controller.text.isNotEmpty
                          ? Colors.black87
                          : Colors.grey[500],
                      fontWeight: controller.text.isNotEmpty
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Location picker method
  Future<void> _pickLocation({required bool isPickup}) async {
    var location = await Get.to(
          () => MapSinglePickerScreen(
        lat: double.tryParse(
          isPickup
              ? locationController.selectedPickUpLat.value
              : locationController.selectedDropUpLat.value,
        ),
        lng: double.tryParse(
          isPickup
              ? locationController.selectedPickUpLng.value
              : locationController.selectedDropUpLng.value,
        ),
      ),
    );

    if (location != null) {
      if (isPickup) {
        locationController.selectedPickUpLat.value = location['lat'].toString();
        locationController.selectedPickUpLng.value = location['lng'].toString();
        locationController.pickUpC.text = location['address'].toString();
        locationController.pickUpLocation.value = location['address'].toString();
      } else {
        locationController.selectedDropUpLat.value = location['lat'].toString();
        locationController.selectedDropUpLng.value = location['lng'].toString();
        locationController.dropC.text = location['address'].toString();
        locationController.dropLocation.value = location['address'].toString();
      }

      // Show success snackbar
      Get.snackbar(
        'Success',
        'Location selected successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
    }
  }

  /// Submit trip request method
  void _submitTripRequest() {
    String hour = selectedTime.hourOfPeriod == 0
        ? '12'
        : '${selectedTime.hourOfPeriod}';
    String minute = '${selectedTime.minute}'.padLeft(2, '0');
    String period = selectedTime.period == DayPeriod.am ? 'AM' : 'PM';

    String journeyTimeAndDate =
        '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')} ${hour}:${minute} $period';

    if (locationController.pickUpLocation.isEmpty ||
        locationController.dropLocation.isEmpty) {
      Get.snackbar(
        'Missing Information',
        "Pick & Drop locations are required",
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    RentalFormCheckController().rentalForm(
      pickUpLocation: locationController.pickUpLocation.toString(),
      viaLocation: locationController.viaLocation.toString(),
      dropLocation: locationController.dropLocation.toString(),
      dateTime: journeyTimeAndDate,
      map: '${locationController.selectedPickUpLat.value},${locationController.selectedPickUpLng.value}',
      roundTrip: roundTripValue.toString(),
      roundTripTimeDate: '',
      vehicleId: widget.carId,
      dropMap: '${locationController.selectedDropUpLat.value},${locationController.selectedDropUpLng.value}',
    );

    Get.to(
          () => TripDetailsPage(
        carImg: widget.carImg,
        carName: widget.carName,
        capacity: widget.capacity,
        carId: widget.carId,
        pickUpPoint: locationController.pickUpLocation.toString(),
        dropPoint: locationController.dropLocation.toString(),
        viaPoint: locationController.viaLocation.toString(),
        note: noteController.text,
        tripDetailsJourney: journeyTimeAndDate,
        roundTrip: roundTripValue.toString(),
        map: '${locationController.selectedPickUpLat.value},${locationController.selectedPickUpLng.value}',
        roundTripDetailsJourney: '',
        pickupDivision: locationController.pickupDivision.value,
        isAirport: false,
        dropOffMap: '${locationController.selectedDropUpLat.value},${locationController.selectedDropUpLng.value}',
        categoryID: widget.tripType,
      ),
    );
  }

}


class YesNoRadioRow extends StatelessWidget {
  final String title;
  final String? option1;
  final String? option2;
  final bool? value;
  final ValueChanged<bool?> onChanged;

  const YesNoRadioRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.option1,
    this.option2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 12),

          /// Segmented control style options
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                /// Yes Option
                Expanded(
                  child: _buildSegmentedOption(
                    context: context,
                    optionValue: true,
                    label: option1 ?? "Yes",
                    isFirst: true,
                  ),
                ),

                /// No Option
                Expanded(
                  child: _buildSegmentedOption(
                    context: context,
                    optionValue: false,
                    label: option2 ?? "No",
                    isFirst: false,
                  ),
                ),
              ],
            ),
          ),
          sizeH20,
          Divider(color: titleColor.withAlpha(100),height: 2,thickness: 1.3,),
        ],
      ),
    );
  }

  Widget _buildSegmentedOption({
    required BuildContext context,
    required bool optionValue,
    required String label,
    required bool isFirst,
  }) {
    final isSelected = value == optionValue;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onChanged(optionValue),
      child: AnimatedContainer(
        duration:  Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: isFirst
              ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
              : const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontSize: 13,
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
