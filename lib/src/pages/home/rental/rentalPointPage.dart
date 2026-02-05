// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/airport/quick_tech_airport_cotnroller.dart';
import 'package:pickup_load_update/src/controllers/live%20location%20controller/live_location_controller.dart';
import 'package:pickup_load_update/src/controllers/rental%20trip%20request%20controllers/rental_trip_request_check_controller.dart';
import 'package:pickup_load_update/src/pages/home/rental/tripDetailsPage.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/car%20selected%20option/car_selected_option_widget.dart';
import 'package:pickup_load_update/src/widgets/date%20and%20time%20widget/date_time_widget.dart';
import 'package:pickup_load_update/src/widgets/date%20and%20time%20widget/return_date_and_time_widget.dart';
import 'package:pickup_load_update/src/widgets/drop_point_widget.dart';
import 'package:pickup_load_update/src/widgets/note_controller.dart';
import 'package:pickup_load_update/src/widgets/pick_up_location_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:pickup_load_update/src/widgets/via_location_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/division controller/division_controller.dart';
import '../../../models/division_model.dart';
import '../../../models/suggestion_model.dart';
import '../../map_page/MapSinglePickerScreen.dart';
import '../../map_page/controller/LocationPickerController.dart';

class RentalPointPage extends StatefulWidget {
  final String carImg;
  final String carName;
  final String capacity;
  final String carId;
  final bool? isAirport;
  final String tripType;

  RentalPointPage(
      {required this.carImg,
      required this.carName,
      required this.capacity,
      this.isAirport,
      required this.tripType,
      required this.carId});

  @override
  State<RentalPointPage> createState() => _RentalPointPageState();
}

class _RentalPointPageState extends State<RentalPointPage> {
  final noteController = TextEditingController();
  final LocationPickerController locationMapController =
      Get.put(LocationPickerController());
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
  final RentalFormCheckController _controller =
      Get.put(RentalFormCheckController());
  final airportController = Get.put(QuickTechAirportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          widget.isAirport == true ? 'airportTrip'.tr : "requestTrip".tr,
          style: TextStyle(color: Colors.white, fontSize: 17.h),
        ),
      ),
      body: ListView(
        children: [
          /// car selected
          widget.tripType == '4' || widget.tripType == '6' || widget.tripType == "truck"
              ? SizedBox()
              : CarSelectedOption(
                  carImg: widget.carImg,
                  carName: widget.carName,
                  capacity: "${widget.capacity} Seats Capacity",
                ),
          sizeH5,
          widget.isAirport == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: KText(
                        text: 'pickUpFrom',
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => RadioListTile<String>(
                                title: Text('fromAirport'.tr),
                                value: 'Airport',
                                groupValue:
                                    airportController.selectedLocation.value,
                                onChanged: (value) {
                                  if (value != null)
                                    airportController.setLocation(value);
                                },
                              )),
                        ),
                        Expanded(
                          child: Obx(() => RadioListTile<String>(
                                title: Text('fromHome'.tr),
                                value: 'Home',
                                groupValue:
                                    airportController.selectedLocation.value,
                                onChanged: (value) {
                                  if (value != null)
                                    airportController.setLocation(value);
                                },
                              )),
                        ),
                      ],
                    )
                  ],
                )
              : SizedBox(),
          SizedBox(height: 20),
          sizeH5,

          /// for location track
          Container(
            width: Get.width,
            color: white,
            child: Padding(
              padding: paddingH10V20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (widget.isAirport != true) {
                            pickupLocation =
                                await Get.to(() => MapSinglePickerScreen(
                                      lat: double.tryParse(locationController.selectedPickUpLat.value) ?? null,
                                      lng: double.tryParse(locationController.selectedPickUpLng.value) ?? null,
                                    ));
                            if (pickupLocation != null) {
                              Get.snackbar("Single Location",
                                  "${pickupLocation['address']}\n(${pickupLocation['lat']}, ${pickupLocation['lng']})");

                              locationController.selectedPickUpLat.value=pickupLocation['lat'].toString();
                              locationController.selectedPickUpLng.value=pickupLocation['lng'].toString();
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
                          } else {
                            if (airportController.selectedLocation.value ==
                                'Home') {
                              pickupLocation =
                                  await Get.to(() => MapSinglePickerScreen(
                                    lat: double.tryParse(locationController.selectedPickUpLat.value) ?? null,
                                    lng: double.tryParse(locationController.selectedPickUpLng.value) ?? null,
                                      ));

                              if (pickupLocation != null) {
                                Get.snackbar("Single Location",
                                    "${pickupLocation['address']}\n(${pickupLocation['lat']}, ${pickupLocation['lng']})");

                                locationController.selectedPickUpLat.value=pickupLocation['lat'].toString();
                                locationController.selectedPickUpLng.value=pickupLocation['lng'].toString();
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
                            }
                          }
                        },
                        child: Image.asset(
                          "assets/images/pick.png",
                          scale: 12,
                        ),
                      ),
                      sizeH5,
                      Container(
                        height: 80,
                        width: .9,
                        color: black,
                      ),
                      sizeH5,
                      GestureDetector(
                        onTap: () async {
                          if (widget.isAirport != true) {
                            dropOffLocation =
                                await Get.to(() => MapSinglePickerScreen(
                                  lat: double.tryParse(locationController.selectedDropUpLat.value) ?? null,
                                  lng: double.tryParse(locationController.selectedDropUpLng.value) ?? null,
                                    ));

                            if (dropOffLocation != null) {
                              Get.snackbar("Single Location",
                                  "${dropOffLocation['address']}\n(${dropOffLocation['lat']}, ${dropOffLocation['lng']})");

                              dropLat = dropOffLocation['lat'];
                              dropLng = dropOffLocation['lng'];
                              locationController.selectedDropUpLat.value=dropOffLocation['lat'].toString();
                              locationController.selectedDropUpLng.value=dropOffLocation['lng'].toString();
                              locationController.dropC.text =
                                  dropOffLocation['address'].toString();
                              locationController.dropLocation.value =
                                  dropOffLocation['address'].toString();
                              log(locationController.dropC.text);
                            }
                          } else {
                            if (airportController.selectedLocation.value !=
                                'Home') {
                              dropOffLocation =
                                  await Get.to(() => MapSinglePickerScreen(
                                    lat: double.tryParse(locationController.selectedDropUpLat.value) ?? null,
                                    lng: double.tryParse(locationController.selectedDropUpLng.value) ?? null,
                                      ));

                              if (dropOffLocation != null) {
                                Get.snackbar("Single Location",
                                    "${dropOffLocation['address']}\n(${dropOffLocation['lat']}, ${dropOffLocation['lng']})");
                                dropLat = dropOffLocation['lat'];
                                dropLng = dropOffLocation['lng'];
                                locationController.selectedDropUpLat.value=dropOffLocation['lat'];
                                locationController.selectedDropUpLng.value=dropOffLocation['lng'];
                                locationController.dropC.text =
                                    dropOffLocation['address'];
                                locationController.dropLocation.value =
                                    dropOffLocation['address'];
                              }
                            }
                          }
                        },
                        child: Image.asset(
                          "assets/images/map.png",
                          scale: 12,
                        ),
                      ),
                    ],
                  ),
                  sizeW20,
                  widget.isAirport == true
                      ? Expanded(
                          child: Obx(() => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  airportController.selectedLocation.value ==
                                          'Home'
                                      ? Column(
                                          children: [
                                            KText(
                                              text: 'pickUpPoint',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            sizeH5,

                                            /// pick up point
                                            PickUp(),
                                            sizeH5,

                                            /// via location
                                            Visibility(
                                              visible: showViaLocation,
                                              child: ViaLocation(),
                                            ),

                                            /// drop point
                                            sizeH10,

                                            KText(
                                              text: 'dropOffPoint',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            sizeH5,
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            KText(
                                              text: 'pickUpPoint',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),

                                            /// via location

                                            Container(
                                              width: 290.w,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.grey
                                                      .withOpacity(0.2)),
                                              child: DropdownButton<String>(
                                                value: airportController
                                                    .selectedAirport.value,
                                                dropdownColor:
                                                    Colors.blueGrey[50],
                                                underline: SizedBox(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                ),
                                                onChanged:
                                                    (String? newAirport) {
                                                  // Update the selected airport in the controller
                                                  airportController
                                                      .selectedAirport
                                                      .value = newAirport!;
                                                  locationController
                                                      .pickUpLocation
                                                      .value = newAirport;
                                                  debugPrint(
                                                      'Testing :::${locationController.pickUpLocation.value}');

                                                  airportController
                                                      .updateSelectedCoordinates(
                                                          newAirport);


                                                },
                                                items: airportController
                                                    .airports
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String airport) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: airport,
                                                    child: SizedBox(
                                                        width: 210.w,
                                                        child: Text(
                                                          airport,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            sizeH10,
                                            Visibility(
                                              visible: showViaLocation,
                                              child: ViaLocation(),
                                            ),
                                          ],
                                        ),

                                  /// drop pont
                                  airportController.selectedLocation.value ==
                                          'Home'
                                      ? Container(
                                    width: 290.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        color: Colors.grey
                                            .withOpacity(0.2)),
                                        child: DropdownButton<String>(
                                            value: airportController
                                                .selectedAirport.value,
                                            onChanged: (String? newAirport) {
                                              airportController.selectedAirport
                                                  .value = newAirport!;
                                              locationController.dropLocation
                                                  .value = newAirport;
                                              airportController
                                                  .updateSelectedCoordinates(
                                                      newAirport);
                                            },
                                          dropdownColor:
                                          Colors.blueGrey[50],
                                          underline: SizedBox(),
                                          style: TextStyle(fontSize: 16,color: Colors.black),
                                            items: airportController.airports
                                                .map<DropdownMenuItem<String>>(
                                                    (String airport) {
                                              return DropdownMenuItem<String>(
                                                value: airport,
                                                child: SizedBox(
                                                    width: 210.w,
                                                    child: Text(
                                                      airport,
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    )),
                                              );
                                            }).toList(),
                                          ),
                                      )
                                      : DropWidget()
                                ],
                              )),
                        )
                      : Expanded(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                KText(
                                  text: 'pickUpPoint',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                sizeH5,

                                /// pick up point
                                PickUp(),
                                sizeH5,

                                /// via location
                                Visibility(
                                  visible: showViaLocation,
                                  child: ViaLocation(),
                                ),

                                /// drop point
                                sizeH10,

                                KText(
                                  text: 'dropOffPoint',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                sizeH5,
                              ],
                            ),

                            /// drop pont
                            DropWidget()
                          ],
                        )),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showViaLocation = !showViaLocation;
                      });
                    },
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: grey.shade300,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: white,
                        child: Icon(
                          showViaLocation ? Icons.close : Icons.add,
                          color: black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          sizeH5,
          widget.tripType == '4' || widget.tripType == '6'
              ? SizedBox()
              : DateAndTime(
                  onDateTimeSelected: (date, time) {
                    selectedDate = date;
                    selectedTime = time;
                  },
                ),
          sizeH5,

          /*widget.tripType == '4' || widget.tripType == '6'
              ? SizedBox()
              : widget.isAirport == true
                  ? SizedBox()
                  : Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: RadioListTile<String>(
                                title: Text('singleTrip'.tr),
                                value: 'round',
                                groupValue:
                                    airportController.selectedTripType.value,
                                onChanged: (value) {
                                  if (value != null)
                                    airportController.setTripType(value);
                                },
                              )),
                              Expanded(
                                  child: RadioListTile<String>(
                                title: Text('hourly'.tr),
                                value: 'hourly',
                                groupValue:
                                    airportController.selectedTripType.value,
                                onChanged: (value) {
                                  if (value != null)
                                    airportController.setTripType(value);
                                },
                              )),
                            ],
                          ),
                          sizeH10,

                        ],
                      ),
                    ),*/
          if(widget.tripType!='4')
          airportController.selectedTripType.value == 'round'
              ? Column(
            children: [
              Container(
                width: Get.width,
                color: white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 15,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: black,
                        child: CircleAvatar(
                          radius: 11,
                          backgroundColor: white,
                          child: Icon(
                            Ionicons.repeat_outline,
                            size: 17,
                            color: black,
                          ),
                        ),
                      ),
                      sizeW10,

                      /// round trip
                      KText(
                        text: 'roundTrips',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: isRoundTrip,
                        activeColor: primaryColor,
                        thumbColor: white,
                        onChanged: (val) {
                          setState(() {
                            isRoundTrip = val;
                            roundTripValue =
                            isRoundTrip ? 1 : 0;
                            print(
                                "selected round trip $roundTripValue");
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              isRoundTrip != true ? Container() : sizeH5,
              isRoundTrip != true
                  ? Container()
                  : ReturnDateAndTime(
                onReturnDateTimeSelected:
                    (date, time) {
                  selectedReturnDate = date;
                  selectedReturnTime = time;
                },
              ),
            ],
          )
              : Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
                color: primaryColor.withOpacity(0.2)),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        if (airportController.hour.value >
                            2) {
                          airportController.hour.value =
                              airportController
                                  .hour.value -
                                  1;
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor),
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.remove,
                            size: 18,
                            color: Colors.white,
                          )),
                    )),
                Expanded(
                    flex: 3,
                    child: Center(
                        child: KText(
                            text:
                            '${airportController.hour.value} Hour'))),
                Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        airportController.hour.value =
                            airportController.hour.value +
                                1;
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor),
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.add,
                            size: 18,
                            color: Colors.white,
                          )),
                    ))
              ],
            ),
          ),

          NoteTextFiled(
            controller: noteController,
          ),
          sizeH5,
          Obx(
            () => _controller.isLoading.value
                ? loader()
                : Container(
                    color: white,
                    child: Padding(
                      padding: paddingH20V20,
                      child: primaryButton(
                        buttonName: 'tripForm',
                        onTap: () {
                         /* if (locationController
                                      .selectedDropOffDistrict.value ==
                                  locationController
                                      .selectedPickUpDistrict.value &&
                              airportController.selectedTripType.value !=
                                  'hourly' &&
                              widget.isAirport != true &&
                              widget.tripType != '4' &&
                              widget.tripType != '6') {
                            debugPrint('Same District ::');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('hourlyService'.tr),
                                  content: Text('hourlyMessage'.tr),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('no'.tr),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        airportController
                                            .selectedTripType.value = 'hourly';
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('yes'.tr),
                                    ),
                                  ],
                                );
                              },
                            );
                            return;
                          } else {*/
                            String hour = selectedTime.hourOfPeriod == 0
                                ? '12'
                                : '${selectedTime.hourOfPeriod}';
                            String minute =
                                '${selectedTime.minute}'.padLeft(2, '0');
                            String period = selectedTime.period == DayPeriod.am
                                ? 'AM'
                                : 'PM';

                            String returnHour = selectedTime.hourOfPeriod == 0
                                ? '12'
                                : '${selectedTime.hourOfPeriod}';
                            String returnMinute =
                                '${selectedTime.minute}'.padLeft(2, '0');
                            String returnPeriod =
                                selectedTime.period == DayPeriod.am
                                    ? 'AM'
                                    : 'PM';

                            String journeyTimeAndDate =
                                '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')} ${hour}:${minute} $period'
                                    .toString();

                            /// return journey time
                            String returnJourneyTimeAndDate =
                                '${selectedReturnDate.year}-${selectedReturnDate.month.toString().padLeft(2, '0')}-${selectedReturnDate.day.toString().padLeft(2, '0')} ${returnHour}:${returnMinute} $returnPeriod'
                                    .toString();

                            /// pick up lat and lang
                            String pickLatAndLang =  widget.isAirport==true&&airportController.selectedLocation.value == 'Airport'?airportController.selectedCoordinates.value.toString():
                                '${locationController.selectedPickUpLat} ${locationController.selectedPickUpLng}';

                            /// drop off lat and lang

                            String dropOfLatAndLang = widget.isAirport==true&&airportController.selectedLocation.value == 'Home'?airportController.selectedCoordinates.value.toString().replaceAll(' ', ','):
                                '${locationController.selectedDropUpLat},${locationController.selectedDropUpLng}';


                            if (widget.isAirport == true &&
                                locationController.pickUpLocation.isEmpty) {
                              locationController.pickUpLocation.value =
                                  'Hazrat Shahjalal International Airport';
                            } else if (widget.isAirport == true &&
                                locationController.dropLocation.isEmpty) {
                              locationController.dropLocation.value =
                                  'Hazrat Shahjalal International Airport';
                            }
                            if (locationController.pickUpLocation.isEmpty ||
                                locationController.dropLocation.isEmpty) {
                              Get.snackbar(
                                  'Sorry', "Pick & Drop Point Cannot be Empty",
                                  colorText: white,
                                  backgroundColor: Colors.redAccent);
                              return;
                            } else
                              RentalFormCheckController().rentalForm(
                                pickUpLocation: widget.isAirport == true &&
                                        airportController
                                                .selectedLocation.value ==
                                            'Airport'
                                    ? airportController.selectedAirport.value
                                    : locationController.pickUpLocation
                                        .toString(),
                                viaLocation:
                                    locationController.viaLocation.toString(),
                                dropLocation: widget.isAirport == true &&
                                        airportController
                                                .selectedLocation.value ==
                                            'Home'
                                    ? airportController.selectedAirport.value
                                    : locationController.dropLocation
                                        .toString(),
                                dateTime: journeyTimeAndDate,
                                map: pickLatAndLang,
                                roundTrip: roundTripValue.toString(),
                                roundTripTimeDate: returnJourneyTimeAndDate,
                                vehicleId: widget.carId,
                                dropMap: dropOfLatAndLang,
                              );
                            debugPrint('Category id ::: ${widget.tripType}');
                            Get.to(() => TripDetailsPage(
                                  carImg: widget.carImg,
                                  carName: widget.carName,
                                  capacity: widget.capacity,
                                  carId: widget.carId,
                                  pickUpPoint: widget.isAirport == true &&
                                          airportController
                                                  .selectedLocation.value ==
                                              'Airport'
                                      ? airportController.selectedAirport.value
                                      : locationController.pickUpLocation
                                          .toString(),
                                  dropPoint: widget.isAirport == true &&
                                          airportController
                                                  .selectedLocation.value ==
                                              'Home'
                                      ? airportController.selectedAirport.value
                                      : locationController.dropLocation
                                          .toString(),
                                  viaPoint:
                                      locationController.viaLocation.toString(),
                                  note: noteController.text,
                                  tripDetailsJourney: journeyTimeAndDate,
                                  roundTrip: roundTripValue.toString(),
                                  map: pickLatAndLang.toString(),
                                  roundTripDetailsJourney:
                                      returnJourneyTimeAndDate,
                                  pickupDivision: locationController.pickupDivision.value,
                                  // dropOfDivision: "${divisionController.selectedDropDivision.value?.id}",
                                  isAirport:
                                      widget.isAirport == true ? true : false,
                                  dropOffMap: dropOfLatAndLang.toString(),
                                  categoryID: widget.tripType,
                                ));

                          }
                       /* },*/
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
