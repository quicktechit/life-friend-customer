// ignore_for_file: unnecessary_null_comparison
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/components/drawer/sidebarComponent.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/live%20location%20controller/live_location_controller.dart';
import 'package:pickup_load_update/src/controllers/return%20trip%20controller/return_confirm_bid_controller.dart';
import 'package:pickup_load_update/src/pages/Trip%20History/trip_history_page.dart';
import 'package:pickup_load_update/src/pages/home/rental/tripHistoryPage.dart';
import 'package:pickup_load_update/src/pages/home/return%20trip/return_bid_confirm.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/car_container_widget.dart';
import 'package:pickup_load_update/src/widgets/custom%20app%20bar/app_bar_widget.dart';
import 'package:pickup_load_update/src/widgets/history_time_widget.dart';
import 'package:pickup_load_update/src/widgets/pick_up_location_widget.dart';
import 'package:pickup_load_update/src/widgets/status_widget.dart';
import 'package:pickup_load_update/src/widgets/text/custom_text_filed_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/truck/truck_controller.dart';
import '../../map_page/MapMultiPickerScreen.dart';
import '../../map_page/MapSinglePickerScreen.dart';
import '../truck/custome_drop_down_widget.dart';

class ReturnTripBidNowPage extends StatefulWidget {
  final String pickDivision;
  final String dropDivision;
  final String partnerBidId;
  final String partnerFare;
  final String carName;
  final String carImg;
  final String capacity;
  final String tripTime;
  final dynamic partnerId;

  ReturnTripBidNowPage({
    Key? key,
    required this.pickDivision,
    required this.dropDivision,
    required this.partnerBidId,
    required this.partnerFare,
    required this.carName,
    required this.carImg,
    required this.capacity,
    required this.tripTime,
    this.partnerId,
  }) : super(key: key);

  @override
  State<ReturnTripBidNowPage> createState() => ReturnTripBidNowPageState();
}

class ReturnTripBidNowPageState extends State<ReturnTripBidNowPage> {
  final divisionController = TextEditingController();
  final locationController = TextEditingController();
  final customerFareController = TextEditingController();
  final customerNoteController = TextEditingController();
  final RxString totalFare = ''.obs;
  int maxWords = 6;
  final List<TextEditingController> dropControllers = [TextEditingController()];
  final List<Widget> dropWidgets = [];
  final TruckController truckController = Get.put(TruckController());
  final ReturnTripConfirmController _controller =
      Get.put(ReturnTripConfirmController());

  final LocationController _locationController = Get.put(LocationController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AllTripHistoryController controller =
      Get.put(AllTripHistoryController());
  var pickupLocation;
  var pickLat;
  var pickLng;
  @override
  void initState() {
    super.initState();
    truckController.dropLatLngList.clear();
    updateTotalFare();
    dropWidgets.add(
      CustomDropWidget(
        controller: dropControllers[0],
        onLocationSelected: (String lat, String lng) {
          // Store lat/lng for the first widget
          truckController.dropLatLngList.add({'lat': lat, 'lng': lng});

        },
      ),
    );
  }
  void validateInput(String value) {
    log("message");

    final enRegex = RegExp(r'[0-9]{7,}');
    final bnRegex = RegExp(r'[০-৯]{7,}');

    final enMatches = enRegex.allMatches(value).toList();
    final bnMatches = bnRegex.allMatches(value).toList();

    // If either Bengali or English matches exceed limit, show warning and clear
    if (enMatches.isNotEmpty || bnMatches.isNotEmpty) {
      String newText = value;

      // Combine all matches and remove them in reverse
      final allMatches = [...enMatches, ...bnMatches]..sort((a, b) => b.start.compareTo(a.start));

      for (final match in allMatches) {
        newText = newText.replaceRange(match.start, match.end, '');
      }

      // Show warning
      Get.snackbar(
        'Warning',
        'Cannot enter more than 6 digits in a row (English or Bengali)',
        colorText: Colors.white,
        backgroundColor: Colors.black,
      );

      // Update text and move cursor
      customerNoteController.text = newText;
      customerNoteController.selection = TextSelection.fromPosition(
        TextPosition(offset: newText.length),
      );
    }
  }


  void printDropLocations() {
    for (int i = 0; i < dropControllers.length; i++) {
      String locationName = dropControllers[i].text;
      truckController.locationNames.add(locationName);
      print("Drop Location ${i + 1}: ${dropControllers[i].text}");
      if (i < truckController.dropLatLngList.length) {
        final latLng = truckController.dropLatLngList[i];
        String latLngString = '${latLng['lat']},${latLng['lng']}';
        truckController.multipleDropoffMap.add(latLngString);
        print(" ${i + 1}: Latitude: ${latLng['lat']}, Longitude: ${latLng['lng']}");
      }
    }
  }

  void updateTotalFare() {
    double totalFareValue = double.tryParse(customerFareController.text) ?? 0;
    totalFare.value = totalFareValue.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      drawer: Drawer(
        child: ExampleSidebarX(
          controller: controller.sidebarController,
        ),
      ),
      appBar: CustomCommonAppBar(
        scaffoldKey: _scaffoldKey,
        title: 'Bid Now'.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Your Location and Destination:'.tr,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  StatusWidget(
                    icon: Icons.watch_later_outlined,
                    statusTitle: 'Trip Time'.tr,
                    textColor: Colors.black,
                  ),
                  Spacer(),
                  HistoryTimeWidget(
                    date: widget.tripTime,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: CustomPaint(
                  painter: DrawDottedHorizontalLine(),
                ),
              ),
              Container(
                width: Get.width,
                color: white,
                child: Padding(
                  padding: paddingH10V20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              pickupLocation =
                              await Get.to(() => MapSinglePickerScreen(
                                lat: double.tryParse( _locationController.selectedPickUpLat.value) ?? null,
                                lng: double.tryParse( _locationController.selectedPickUpLng.value) ?? null,
                              ));
                              if (pickupLocation != null) {
                                Get.snackbar("Single Location",
                                    "${pickupLocation['address']}\n(${pickupLocation['lat']}, ${pickupLocation['lng']})");
                                pickLat = pickupLocation['lat'];
                                pickLng = pickupLocation['lng'];
                                _locationController.selectedPickUpLat.value=pickupLocation['lat'].toString();
                                _locationController.selectedPickUpLng.value=pickupLocation['lng'].toString();
                                _locationController.pickUpC.text =
                                pickupLocation['address'].toString();
                                _locationController.pickUpLocation.value =
                                pickupLocation['address'].toString();
                              }
                            },
                            child: Image.asset(
                              "assets/images/pick.png",
                              scale: 15,
                            ),
                          ),
                          sizeH5,
                          Container(
                            height: 120,
                            width: .5,
                            color: black,
                          ),
                          sizeH5,
                          GestureDetector(
                            onTap: () async {
                              debugPrint('Testing ::: ');
                              final selectedLocations = await Get.to(() => MapMultiPickerScreen(
                                initialLocations: truckController.dropLatLngList.map((loc) => {
                                  'lat': double.tryParse(loc['lat'] ?? '0') ?? 0.0,
                                  'lng': double.tryParse(loc['lng'] ?? '0') ?? 0.0,
                                  'address': '', // If you have address info, include it here
                                }).toList(),
                              ));

                              if (selectedLocations != null && selectedLocations is List) {
                                setState(() {
                                  // If first widget is empty and unused, remove it
                                  if (dropWidgets.length == 1 && dropControllers[0].text.isEmpty) {
                                    dropWidgets.clear();
                                    dropControllers.clear();
                                    truckController.dropLatLngList.clear(); // Optional: reset stored lat/lng
                                  }

                                  for (var loc in selectedLocations) {
                                    if (dropWidgets.length >= 5) break;

                                    final controller = TextEditingController(text: loc['address'] ?? '');
                                    dropControllers.add(controller);

                                    truckController.dropLatLngList.add({
                                      'lat': loc['lat'].toString(),
                                      'lng': loc['lng'].toString(),
                                    });

                                    dropWidgets.add(
                                      CustomDropWidget(
                                        controller: controller,
                                        onLocationSelected: (lat, lng) {
                                          truckController.dropLatLngList.add({'lat': lat, 'lng': lng});
                                        },
                                      ),
                                    );
                                  }
                                });
                              }
                            },
                            child: Image.asset(
                              "assets/images/map.png",
                              scale: 15,
                            ),
                          ),
                        ],
                      ),
                      sizeW20,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: 'pickUpPoint',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            sizeH5,
                            // Pass divisionController to PickUp widget
                            PickUp(),
                            sizeH10,
                            // Pass locationController to DropWidget widget
                            KText(
                              text: 'dropOffPoint',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            sizeH5,

                            // Display all drop widgets with a remove button
                            ...dropWidgets.asMap().entries.map((entry) {
                              final index = entry.key;
                              final widget = entry.value;

                              return Row(
                                children: [
                                  Expanded(child: widget),
                                  if (dropWidgets.length > 1)
                                    IconButton(
                                      icon: Icon(Icons.remove_circle, color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          // Remove the DropWidget and its corresponding controller and lat/lng
                                          dropWidgets.removeAt(index);
                                          dropControllers[index].dispose();
                                          dropControllers.removeAt(index);
                                          // dropLatLngList.removeAt(index);
                                        });
                                      },
                                    ),
                                ],
                              );
                            }).toList(),
                            if (dropWidgets.length < 5)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    if (dropWidgets.length < 5) {
                                      final newController = TextEditingController();
                                      dropControllers.add(newController);
                                      dropWidgets.add(
                                        CustomDropWidget(
                                          controller: newController,
                                          onLocationSelected: (lat, lng) {
                                            // Store lat/lng for the new widget
                                            truckController.dropLatLngList
                                                .add({'lat': lat, 'lng': lng});
                                          },
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.add, color: Colors.blue),
                                    sizeW5,
                                    Text(
                                      "Add More Drop-Off Location".tr,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 20.h),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/pick.png",
                        scale: 15,
                      ),
                      KText(
                        text:
                            truncateTextIfNeeded(widget.pickDivision, maxWords),
                      ).w(context.screenWidth/1.3)
                    ],
                  ),
                  sizeH5,
                  sizeH5,
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/map.png",
                        scale: 15,
                      ),
                      KText(
                        text:
                            truncateTextIfNeeded(widget.dropDivision, maxWords),
                      ).w(context.screenWidth/1.3)
                    ],
                  ),
                ],
              ),
              sizeH10,
              CustomTextFieldWithIcon(

                label: "adnots".tr,
                icon: Icons.note,
                controller: customerNoteController,

                onChanged: (v){
                  validateInput(v);
                },

                hinttext: "info".tr,

               maxLines: 2,
              ),
              sizeH5,
              sizeH5,
              CustomTextFieldWithIcon(
                label: "Your Fare:".tr,
                icon: Icons.business,
                controller: customerFareController,
                keyboardType:TextInputType.number,
                hinttext: "Enter Your Fare".tr,
                onChanged: (value) {
                  validateInput(value);
                  updateTotalFare();
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(
                    text: 'Total Fare'.tr,
                    fontWeight: FontWeight.bold,
                  ),
                  Obx(() => KText(
                    text: "${totalFare.value} Tk",
                    fontWeight: FontWeight.bold,
                  )),
                ],
              ),


              SizedBox(height: 10),
              CarContainerWidget(
                img: Urls.getImageURL(endPoint: widget.carImg),
                carName: widget.carName,
                capacity: "${widget.capacity} Seats Capacity".tr,
              ),

              SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: primaryButton(
                  icon: Icons.arrow_circle_right_outlined,
                  buttonName: 'Bid Now'.tr,
                  onTap: () async {
                    printDropLocations();
                    String pickupLatAndLang =
                        '${_locationController.selectedPickUpLat} ${_locationController.selectedPickUpLng}';
                    // String dropOffLocation =
                    //     '${_locationController.selectedDropUpLat} ${_locationController.selectedDropUpLng}';




                    if (truckController.locationNames.isEmpty ||
                        _locationController.pickUpLocation.value.isEmpty ||
                        customerFareController.text.isEmpty||customerFareController.text.length>6) {
                      Get.snackbar(
                        'Sorry',
                        'Fare cannot be more then 6 or enmity & Location Are Required',
                        colorText: Colors.white,
                        backgroundColor: Colors.redAccent,
                      );

                    } else {
                      await _controller.returnTripConfirm(
                        pickUpLocation:
                            _locationController.pickUpLocation.toString(),
                        price: customerFareController.text,
                        partnerBidId: widget.partnerBidId,
                        map: pickupLatAndLang,
                        partnerId: widget.partnerId,
                        multipleDropoffLocation: truckController.locationNames,
                        multipleDropoffMap: truckController.multipleDropoffMap,
                        returnTripId: widget.partnerId, note: customerNoteController.text,
                      );
                      if (_controller.customerBid.value.status == "success") {
                        Get.to(() => ReturnBidConfirm(
                              carImg: widget.carImg,
                              capacity: widget.capacity,
                              carName: widget.carName,
                              pickup:
                                  _locationController.pickUpLocation.toString(),
                              drop: _locationController.dropLocation.toString(),
                              partnerFare: widget.partnerFare,
                              tripTime: widget.tripTime,
                              bidId: _controller.customerBid.value.data!.id
                                  .toString(),
                            ));
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String truncateTextIfNeeded(String text, int maxWords) {
    if (text == null || text.isEmpty) {
      return "N/A";
    }

    List<String> words = text.split(RegExp(r'\s+'));
    int wordCount = words.length;

    return wordCount > maxWords ? '${words.take(maxWords).join(" ")}...' : text;
  }
}
