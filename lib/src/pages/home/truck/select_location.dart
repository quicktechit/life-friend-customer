import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/pages/home/truck/select_truck_screen.dart';
import 'package:pickup_load_update/src/pages/map_page/MapMultiPickerScreen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../configs/appColors.dart';
import '../../../configs/appUtils.dart';
import '../../../controllers/division controller/division_controller.dart';
import '../../../controllers/live location controller/live_location_controller.dart';
import '../../../controllers/truck/truck_controller.dart';
import '../../../models/suggestion_model.dart';
import '../../../widgets/pick_up_location_widget.dart';
import '../../../widgets/text/kText.dart';
import '../../../widgets/via_location_widget.dart';
import '../../map_page/MapSinglePickerScreen.dart';
import 'custome_drop_down_widget.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  bool showViaLocation = false;
  final LocationController locationController = Get.put(LocationController());
  final TruckController truckController = Get.put(TruckController());
  final List<TextEditingController> dropControllers = [TextEditingController()];
  final List<Widget> dropWidgets = [];
  final DivisionController divisionController = Get.put(DivisionController());

  var pickupLocation;
  var pickLat;
  var pickLng;

  @override
  void initState() {
    super.initState();
    truckController.getTruckCategory();
    truckController.productType();
    truckController.dropLatLngList.clear();
    truckController.productType();
    // Add the first CustomDropWidget with a callback for lat/lng
    dropWidgets.add(
      CustomDropWidget(
        controller: dropControllers[0],
        onLocationSelected: (String lat, String lng) {
         debugPrint('Drop Location ::: ${dropControllers[0]}');
         truckController.dropLatLngList.add({'lat': lat, 'lng': lng});
        },
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of all TextEditingControllers
    for (var controller in dropControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Method to print all drop locations (including lat/lng)
  void printDropLocations() {
    truckController.locationNames.clear();
    truckController.multipleDropoffMap.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: "selectlocation".tr.text.semiBold.white.make()),
      body: Column(
        children: [
          ListView(
            children: [
              Container(
                width: Get.width,
                color: Colors.white,
                child: Padding(
                  padding: paddingH10V20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          30.heightBox,

                          GestureDetector(
                              onTap: () async {
                                pickupLocation =
                                    await Get.to(() => MapSinglePickerScreen(
                                      lat: double.tryParse(
                                          locationController
                                              .selectedPickUpLat
                                              .value) ??
                                          null,
                                      lng: double.tryParse(
                                          locationController
                                              .selectedPickUpLng
                                              .value) ??
                                          null,
                                    ));

                                if (pickupLocation != null) {
                                  Get.snackbar("Single Location",
                                      "${pickupLocation['address']}\n(${pickupLocation['lat']}, ${pickupLocation['lng']})");

                                  pickLat = pickupLocation['lat'];
                                  pickLng = pickupLocation['lng'];
                                  locationController.selectedPickUpLat.value =
                                      pickLat.toString();
                                  locationController.selectedPickUpLng.value =
                                      pickLng.toString();
                                  locationController.pickUpC.text =
                                      pickupLocation['address'].toString();
                                  locationController.pickUpLocation.value =
                                      pickupLocation['address'].toString();

                                  // ✅ Optional: Call getDropDetailsAddress with place_id
                                  if (pickupLocation['place_id'] != null) {
                                    locationController.selectPikUpAddress(
                                      Suggestion(
                                        placeId: pickupLocation['place_id'],
                                        description: pickupLocation['address'],
                                      ),
                                    );
                                  }

                                  log(locationController.pickUpC.text);
                                }
                              },
                              child: Image.asset("assets/images/pick.png", scale: 12)),
                          sizeH5,
                          Container(height: 80,
                              width: .9, color: Colors.black),
                          sizeH5,
                          GestureDetector(
                            onTap: () async {
                              // Navigate to the map picker screen
                              final selectedLocations = await Get.to(() => MapMultiPickerScreen(
                                initialLocations: truckController.dropLatLngList.map((loc) => {
                                  'lat': double.tryParse(loc['lat'] ?? '0') ?? 0.0,
                                  'lng': double.tryParse(loc['lng'] ?? '0') ?? 0.0,
                                  'address': '', // If you have address info, include it here
                                }).toList(),
                              ));

                              // If user selects locations
                              if (selectedLocations != null && selectedLocations is List) {
                                setState(() {
                                  // Clear all if only one empty item exists
                                  if (dropWidgets.length == 1 && dropControllers[0].text.isEmpty) {
                                    dropWidgets.clear();
                                    dropControllers.clear();
                                    truckController.dropLatLngList.clear();
                                  }

                                  // Clear and re-add only if needed
                                  for (var loc in selectedLocations) {
                                    if (dropWidgets.length >= 5) break;

                                    final address = loc['address'] ?? '';
                                    final lat = loc['lat'].toString();
                                    final lng = loc['lng'].toString();

                                    final controller = TextEditingController(text: address);
                                    dropControllers.add(controller);

                                    truckController.dropLatLngList.add({'lat': lat, 'lng': lng});

                                    dropWidgets.add(
                                      CustomDropWidget(
                                        controller: controller,
                                        onLocationSelected: (newLat, newLng) {
                                          // Optional: Update lat/lng if changed inside CustomDropWidget
                                          truckController.dropLatLngList.add({'lat': newLat, 'lng': newLng});
                                        },
                                      ),
                                    );
                                  }
                                });
                              }
                            },
                            child: Image.asset("assets/images/map.png", scale: 12),
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
                            PickUp(),
                            sizeH5,
                            Visibility(visible: showViaLocation, child: ViaLocation()),
                            sizeH10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KText(
                                  text: 'dropOffPoint',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      showViaLocation = !showViaLocation;
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 13,
                                    backgroundColor: Colors.grey.shade300,
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        showViaLocation ? Icons.close : Icons.add,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                            debugPrint('Testing Drop ::::');
                                            truckController.dropLatLngList.add({'lat': lat, 'lng': lng});
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

            ],
          ).h(context.screenHeight/1.3),
          Spacer(),
          TextButton(
            onPressed: () {

              if (locationController.pickUpLocation.value.isEmpty) {
                VxToast.show(context, msg: "Pickup Location Needed");
                return;
              }

              printDropLocations();

              if (truckController.locationNames.isEmpty) {
                VxToast.show(context, msg: 'Drop of Location Needed');
                return;
              }

              Get.to(() => SelectTruckScreen());
            },
            child: "go next".tr.text.white.semiBold.size(15).make(),
          ).box.width(context.screenWidth/1.2).color(primaryColor).rounded.makeCentered(),
          30.heightBox,
        ],
      ),
    );
  }
}


