import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/pages/home/truck/select_truck_screen.dart';
import 'package:pickup_load_update/src/pages/map_page/MapMultiPickerScreen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../configs/appColors.dart';
import '../../../controllers/division controller/division_controller.dart';
import '../../../controllers/live location controller/live_location_controller.dart';
import '../../../controllers/truck/truck_controller.dart';
import '../../../models/suggestion_model.dart';
import '../../../widgets/pick_up_location_widget.dart';
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
  final DivisionController divisionController = Get.put(DivisionController());
  final List<TextEditingController> dropControllers = [TextEditingController()];
  final List<Widget> dropWidgets = [];

  var pickupLocation;
  var pickLat;
  var pickLng;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    truckController.locationNames.clear();
    truckController.getTruckCategory();
    truckController.productType();
    truckController.dropLatLngList.clear();

    // Add the first CustomDropWidget
    dropWidgets.add(
      CustomDropWidget(
        controller: dropControllers[0],
        onLocationSelected: (String lat, String lng) {
          truckController.dropLatLngList.add({'lat': lat, 'lng': lng});
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in dropControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _printDropLocations() {
    truckController.locationNames.clear();
    truckController.multipleDropoffMap.clear();
    print("dropControllers length: ${dropControllers.length}");
    for (int i = 0; i < dropControllers.length; i++) {
      String locationName = dropControllers[i].text;
      truckController.locationNames.add(locationName);
      print(truckController.hashCode);
      print("text value: '${dropControllers[i].text}'");



      print(truckController.locationNames);
      if (i < truckController.dropLatLngList.length) {
        final latLng = truckController.dropLatLngList[i];
        String latLngString = '${latLng['lat']},${latLng['lng']}';
        truckController.multipleDropoffMap.add(latLngString);
      }
    }
  }

  Future<void> _handlePickupLocationSelection() async {
    pickupLocation = await Get.to(
      () => MapSinglePickerScreen(
        lat:
            double.tryParse(locationController.selectedPickUpLat.value) ?? null,
        lng:
            double.tryParse(locationController.selectedPickUpLng.value) ?? null,
      ),
    );

    if (pickupLocation != null) {
      Get.snackbar(
        "Location Selected",
        "${pickupLocation['address']}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      pickLat = pickupLocation['lat'];
      pickLng = pickupLocation['lng'];
      locationController.selectedPickUpLat.value = pickLat.toString();
      locationController.selectedPickUpLng.value = pickLng.toString();
      locationController.pickUpC.text = pickupLocation['address'].toString();
      locationController.pickUpLocation.value = pickupLocation['address']
          .toString();

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

  Future<void> _handleDropLocationSelection() async {
    final selectedLocations = await Get.to(
      () => MapMultiPickerScreen(
        initialLocations: truckController.dropLatLngList
            .map(
              (loc) => {
                'lat': double.tryParse(loc['lat'] ?? '0') ?? 0.0,
                'lng': double.tryParse(loc['lng'] ?? '0') ?? 0.0,
                'address': '',
              },
            )
            .toList(),
      ),
    );

    if (selectedLocations != null && selectedLocations is List) {
      setState(() {
        if (dropWidgets.length == 1 && dropControllers[0].text.isEmpty) {
          dropWidgets.clear();
          dropControllers.clear();
          truckController.dropLatLngList.clear();
        }

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
                truckController.dropLatLngList.add({
                  'lat': newLat,
                  'lng': newLng,
                });
              },
            ),
          );
        }
      });
    }
  }

  Widget _buildLocationIndicator() {
    return Container(
      width: 2,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor50, Colors.green.shade500],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildLocationIcon({
    required String iconPath,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required Color backgroundColor,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(iconPath, width: 30, height: 30),
                  SizedBox(height: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    Color? iconColor,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: primaryColor50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor ?? primaryColor, size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title.tr,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Select Location".tr,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Column(
        children: [
          // Location Selection Cards
          Card(
            margin: EdgeInsets.all(8),
            color: white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Vertical Location Indicator with Icons
                      Column(
                        children: [
                          _buildLocationIcon(
                            iconPath: "assets/images/pick.png",
                            label: "Pickup",
                            color: primaryColor,
                            backgroundColor: primaryColor50,
                            onTap: _handlePickupLocationSelection,
                          ),
                          _buildLocationIndicator(),
                          _buildLocationIcon(
                            iconPath: "assets/images/map.png",
                            label: "Drop Off",
                            color: Colors.green.shade700,
                            backgroundColor: Colors.green.shade50,
                            onTap: _handleDropLocationSelection,
                          ),
                        ],
                      ),

                      SizedBox(width: 20),

                      // Location Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Pickup Section
                            _buildSectionHeader(
                              title: 'pickUpPoint',
                              icon: Icons.location_pin,
                              iconColor: primaryColor,
                            ),
                            SizedBox(height: 12),
                            PickUp(),

                            SizedBox(height: 24),

                            // Drop Off Section Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSectionHeader(
                                  title: 'dropOffPoint',
                                  icon: Icons.flag,
                                  iconColor: Colors.green.shade700,
                                ),
                                // Via Location Toggle
                                // Tooltip(
                                //   message: showViaLocation
                                //       ? "Remove via location".tr
                                //       : "Add via location".tr,
                                //   child: AnimatedContainer(
                                //     duration: Duration(milliseconds: 300),
                                //     width: 48,
                                //     height: 48,
                                //     decoration: BoxDecoration(
                                //       color: showViaLocation
                                //           ? Colors.red.shade50
                                //           : Colors.grey.shade100,
                                //       borderRadius: BorderRadius.circular(12),
                                //       border: Border.all(
                                //         color: showViaLocation
                                //             ? Colors.red.shade300
                                //             : Colors.grey.shade300,
                                //         width: 1.5,
                                //       ),
                                //     ),
                                //     child: Material(
                                //       color: Colors.transparent,
                                //       child: InkWell(
                                //         onTap: () {
                                //           setState(() {
                                //             showViaLocation = !showViaLocation;
                                //           });
                                //         },
                                //         borderRadius: BorderRadius.circular(12),
                                //         child: Icon(
                                //           showViaLocation
                                //               ? Icons.remove
                                //               : Icons.add,
                                //           color: showViaLocation
                                //               ? Colors.red.shade700
                                //               : primaryColor,
                                //           size: 24,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),

                            SizedBox(height: 12),

                            // Via Location (Conditional)
                            if (showViaLocation)
                              AnimatedSize(
                                duration: Duration(milliseconds: 300),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.orange.shade200,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.route,
                                        color: Colors.orange.shade700,
                                        size: 22,
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          "Via location".tr,
                                          style: TextStyle(
                                            color: Colors.orange.shade800,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.orange.shade700,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            SizedBox(height: showViaLocation ? 8 : 0),

                            // Drop Locations List
                            ...dropWidgets.asMap().entries.map((entry) {
                              final index = entry.key;
                              final widget = entry.value;

                              return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            color: Colors.green.shade800,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(child: widget),
                                    if (dropWidgets.length > 1)
                                      Icon(
                                        Icons.delete_outline,
                                        color: Colors.red.shade600,
                                        size: 24,
                                      ).onTap(() {
                                        setState(() {
                                          dropWidgets.removeAt(index);
                                          dropControllers[index].dispose();
                                          dropControllers.removeAt(index);
                                        });
                                      }),
                                  ],
                                ),
                              );
                            }),

                            // Add More Drop Location Button
                            if (dropWidgets.length < 5)
                              AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: EdgeInsets.only(top: 8),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        final newController =
                                            TextEditingController();
                                        dropControllers.add(newController);
                                        dropWidgets.add(
                                          CustomDropWidget(
                                            controller: newController,
                                            onLocationSelected: (lat, lng) {
                                              truckController.dropLatLngList
                                                  .add({
                                                    'lat': lat,
                                                    'lng': lng,
                                                  });
                                            },
                                          ),
                                        );
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: primaryColor50,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: primaryColor,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_location_alt,
                                            color: primaryColor,
                                            size: 20,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "Add Drop Location".tr,
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
          ).expand(flex: 1),

          // Bottom Action Button
          Padding(
            padding: const EdgeInsets.all(8),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              elevation: 4,
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (locationController.pickUpLocation.value.isEmpty) {
                        VxToast.show(context, msg: "Pickup Location Needed");
                        return;
                      }

                      _printDropLocations();
                      bool hasDrop = dropControllers.any(
                            (c) => c.text.trim().isNotEmpty,
                      );
                      if (!hasDrop) {
                        VxToast.show(context, msg: 'Drop off Location Needed');
                        return;
                      }

                      Get.to(() => SelectTruckScreen());
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue to Select Truck".tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ViaLocation Widget (Optional - if you have it in your original code)
class ViaLocation extends StatelessWidget {
  const ViaLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.route, color: Colors.orange.shade700, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Via location".tr,
              style: TextStyle(
                color: Colors.orange.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(Icons.arrow_drop_down, color: Colors.orange.shade700),
        ],
      ),
    );
  }
}
