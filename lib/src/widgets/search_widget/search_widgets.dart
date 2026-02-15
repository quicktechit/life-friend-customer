import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/widgets/border_background_button.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/search_widget/service_category.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../configs/appColors.dart';
import '../../configs/appUtils.dart';
import '../../controllers/live location controller/live_location_controller.dart';
import '../../models/suggestion_model.dart';
import '../../pages/home/truck/select_location.dart';
import '../../pages/map_page/MapSinglePickerScreen.dart';
import '../../pages/map_page/controller/LocationPickerController.dart';
import '../drop_point_widget.dart';
import '../pick_up_location_widget.dart';
import '../text/kText.dart';

class SearchWidgets extends StatefulWidget {
  const SearchWidgets({super.key});

  @override
  State<SearchWidgets> createState() => _SearchWidgetsState();
}

class _SearchWidgetsState extends State<SearchWidgets> {
  final LocationPickerController locationMapController = Get.put(
    LocationPickerController(),
  );

  final LocationController locationController = Get.put(LocationController());

  bool showViaLocation = false;

  var pickupLocation;

  var pickLat;

  var pickLng;

  var dropLat;

  var dropLng;

  var dropOffLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: KText(text: 'Search Locations',color: Colors.white,fontSize: 17,),),
      body: SafeArea(
        child: Column(
          children: [
            sizeH30,
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
                                pickLat =
                                    locationController.selectedPickUpLat.value;
                                pickLng =
                                    locationController.selectedPickUpLng.value;
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
                            Column(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            primaryButton(
              buttonName: "Next",
              icon: Icons.navigate_next_outlined,
              onTap: () {
                Get.to(() => ServiceCategory());
              },
            ).p8(),
            sizeH30,
          ],
        ),
      ),
    );
  }
}
