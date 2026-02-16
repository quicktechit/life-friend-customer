import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/search_widget/service_category.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../configs/appColors.dart';
import '../../configs/appUtils.dart';
import '../../controllers/live location controller/live_location_controller.dart';
import '../../models/suggestion_model.dart';
import '../../pages/home/rental/rentalListPage.dart';
import '../../pages/map_page/MapSinglePickerScreen.dart';
import '../../pages/map_page/controller/LocationPickerController.dart';
import '../custom_form.dart';
import '../text/kText.dart';

class SearchWidgets extends StatefulWidget {
  final String tripType;

  const SearchWidgets({super.key, required this.tripType});

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
      appBar: AppBar(
        title: KText(
          text: 'Search Locations',
          color: Colors.white,
          fontSize: 17,
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              sizeH10,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(8),
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
                                      locationController
                                          .selectedPickUpLat
                                          .value,
                                    ),
                                    lng: double.tryParse(
                                      locationController
                                          .selectedPickUpLng
                                          .value,
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
                                  pickLat = locationController
                                      .selectedPickUpLat
                                      .value;
                                  pickLng = locationController
                                      .selectedPickUpLng
                                      .value;
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
                                width: 35,
                                height: 35,
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
                                  size: 22,
                                ),
                              ),
                            ),
                            sizeH5,

                            // Vertical timeline connector
                            Container(
                              height: showViaLocation ? 40 : 50,
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
                                height: 20,
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
                                      locationController
                                          .selectedDropUpLat
                                          .value,
                                    ),
                                    lng: double.tryParse(
                                      locationController
                                          .selectedDropUpLng
                                          .value,
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
                                width: 35,
                                height: 35,
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
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),

                        sizeW10,

                        // Location input fields
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Pickup section
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: CustomForm(
                                  hintText: 'Pickup Locations',
                                  controller: locationController.pickUpC,
                                  onChange: (value) {
                                    value.isEmpty
                                        ? locationController
                                              .fetchPickSuggestions(
                                                "Bangladesh",
                                              )
                                        : locationController
                                              .fetchPickSuggestions(value);
                                  },
                                  sufIcon: IconButton(
                                    onPressed: () {
                                      locationController.pickUpC.clear();
                                      locationController.suggestionsPickUp
                                          .clear();
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              // Add/Remove via point button
                              Align(
                                alignment: AlignmentGeometry.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showViaLocation = !showViaLocation;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Row(mainAxisAlignment: .end,
                                    children: [
                                      KText(text: "Via Locations"),sizeW5,
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            3,
                                          ),
                                          color: showViaLocation
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                        child: Icon(
                                          showViaLocation
                                              ? Icons.remove
                                              : Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              sizeH10,
                              // Via location (conditional)
                              if (showViaLocation)
                                Column(
                                  children: [
                                    CustomForm(
                                      hintText: 'Via Locations',
                                      controller: locationController.viaTextC,
                                      onChange: (value) {
                                        value.isEmpty
                                            ? locationController
                                                  .fetchViaSuggestions(
                                                    "Bangladesh",
                                                  )
                                            : locationController
                                                  .fetchViaSuggestions(value);
                                      },
                                      sufIcon: IconButton(
                                        onPressed: () {
                                          locationController.viaTextC.clear();
                                          locationController.suggestionsVia
                                              .clear();
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                    sizeH10,
                                  ],
                                ),

                              // Dropoff section
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomForm(
                                    hintText: 'Dropoff Locations',

                                    controller: locationController.dropC,
                                    sufIcon: IconButton(
                                      onPressed: () {
                                        locationController.dropC.clear();
                                        locationController.suggestionsDrop
                                            .clear();
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    onChange: (value) {
                                      value.isEmpty
                                          ? locationController
                                                .fetchDropSuggestions(
                                                  "Bangladesh",
                                                )
                                          : locationController
                                                .fetchDropSuggestions(value);
                                    },
                                  ),
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
              sizeH10,
              // Loading indicator
              if (locationController.isLoading.value)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Column(
                      children: [
                        LinearProgressIndicator(color: primaryColor),
                        SizedBox(height: 8),
                        Text(
                          'Searching locations...',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )
              // Suggestions list
              else if (locationController.suggestionsPickUp.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 250.h),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: locationController.suggestionsPickUp.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(5),
                        itemBuilder: (context, index) {
                          final suggestion =
                              locationController.suggestionsPickUp[index];
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                locationController.pickUpC.text =
                                    suggestion.description;
                                locationController.selectPikUpAddress(
                                  suggestion,
                                );
                                locationController.suggestionsPickUp.clear();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      index !=
                                          locationController
                                                  .suggestionsPickUp
                                                  .length -
                                              1
                                      ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.withOpacity(0.1),
                                            width: 1,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: primaryColor.withOpacity(0.7),
                                      size: 20,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        suggestion.description,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              else if (locationController.suggestionsDrop.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 250.h),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: locationController.suggestionsDrop.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(5),
                        itemBuilder: (context, index) {
                          final suggestion =
                              locationController.suggestionsDrop[index];
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                debugPrint('Testing ::: ');
                                locationController.dropC.text =
                                    suggestion.description;
                                locationController.selectDropAddress(
                                  suggestion,
                                );
                                locationController.suggestionsDrop.clear();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      index !=
                                          locationController
                                                  .suggestionsDrop
                                                  .length -
                                              1
                                      ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.withOpacity(0.1),
                                            width: 1,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: primaryColor.withOpacity(0.7),
                                      size: 20,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Destination',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.red[600],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            suggestion.description,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              else if (locationController.suggestionsVia.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 250.h),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: locationController.suggestionsVia.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(5),
                        itemBuilder: (context, index) {
                          final suggestion =
                              locationController.suggestionsVia[index];
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                locationController.viaTextC.text =
                                    suggestion.description;
                                locationController.selectViaAddress(suggestion);
                                locationController.suggestionsVia.clear();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      index !=
                                          locationController
                                                  .suggestionsVia
                                                  .length -
                                              1
                                      ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.withOpacity(0.1),
                                            width: 1,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Colors.orange[50],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.route_outlined,
                                        color: Colors.orange[700],
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Via Point ${index + 1}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.orange[700],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            suggestion.description,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.green,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

              Spacer(),
              primaryButton(
                buttonName: "Next",
                icon: Icons.navigate_next_outlined,
                onTap: () {
                  switch (widget.tripType) {
                    case 'Ambulance':
                      Get.to(
                        () => RentalListPage(
                          ambulance: true,
                          tripType: 'Ambulance',
                        ),
                      );
                      break;

                    case 'car':
                      Get.to(
                        () => RentalListPage(isAirport: false, tripType: 'car'),
                      );
                      break;

                    case 'airport':
                      Get.to(
                        () => RentalListPage(
                          isAirport: true,
                          tripType: 'airport',
                        ),
                      );
                      break;

                    default:
                      Get.to(
                        () => RentalListPage(
                          isAirport: false,
                          tripType: widget.tripType,
                        ),
                      );
                  }
                },
              ).p8(),

              sizeH30,
            ],
          );
        }),
      ),
    );
  }
}
