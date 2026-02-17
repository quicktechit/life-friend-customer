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

  const RentalPointPage({
    super.key,
    required this.carImg,
    required this.carName,
    required this.capacity,
    this.isAirport = false,
    required this.tripType,
    required this.carId,
  });

  @override
  State<RentalPointPage> createState() => _RentalPointPageState();
}

class _RentalPointPageState extends State<RentalPointPage> {
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
  final airportController = Get.put(QuickTechAirportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 4,
        shadowColor: primaryColor.withOpacity(0.3),
        title: Text(
          widget.isAirport == true ? 'airportTrip'.tr : "requestTrip".tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.h,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
          child: Column(
            children: [
              // Car Selection (Conditional)
              // _buildCarSelectionSection(),

              // SizedBox(height: 16.h),

              // Airport Selection (Conditional)
              // _buildAirportSelectionSection(),

              // Main Card Container
              Card(
                elevation: 8,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.blueGrey.withOpacity(0.2),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, Colors.blueGrey[50]!],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Location Tracking Section
                      // _buildLocationSection(),

                      Divider(height: 1, color: Colors.grey[200]),

                      // Date and Time Selection (Conditional)
                      _buildDateTimeSection(),

                      // Round Trip or Hour Selection (Conditional)
                      _buildTripOptionsSection(),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Note Field
              Card(
                elevation: 4,
                color: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.note_add_outlined,
                            color: primaryColor,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Additional Notes',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      NoteTextFiled(controller: noteController),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),

              // Submit Button
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Methods
  Widget _buildCarSelectionSection() {
    final shouldShowCar = !['4', '6', 'truck'].contains(widget.tripType);

    return shouldShowCar
        ? Card(
            color: Colors.white,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarSelectedOption(
                carImg: widget.carImg,
                carName: widget.carName,
                capacity: "${widget.capacity} Seats Capacity",
              ),
            ),
          )
        : const SizedBox();
  }

  Widget _buildAirportSelectionSection() {
    if (widget.isAirport == false) return const SizedBox();

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.flight_takeoff_outlined,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'pickUpFrom',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _buildRadioTile(
                  'Airport',
                  'fromAirport'.tr,
                  Icons.airplanemode_active,
                ),
                _buildRadioTile('Home', 'fromHome'.tr, Icons.home_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioTile(String value, String title, IconData icon) {
    return Expanded(
      child: Obx(
        () => Card(
          elevation: 2,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: airportController.selectedLocation.value == value
                  ? primaryColor
                  : Colors.grey[300]!,
              width: airportController.selectedLocation.value == value ? 2 : 1,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              if (airportController.selectedLocation.value != value) {
                airportController.setLocation(value);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: airportController.selectedLocation.value == value
                        ? primaryColor
                        : Colors.grey[600],
                    size: 28,
                  ),
                  SizedBox(height: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight:
                          airportController.selectedLocation.value == value
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: airportController.selectedLocation.value == value
                          ? primaryColor
                          : Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4),
                  if (airportController.selectedLocation.value == value)
                    Container(
                      width: 24,
                      height: 2,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined, color: primaryColor, size: 20),
              SizedBox(width: 8),
              Text(
                'Trip Locations',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location Icons with connecting line
                  _buildLocationIcons(),
                  SizedBox(width: 20),
                  // Location Inputs
                  Expanded(child: _buildLocationInputs()),

                  // Via Location Toggle
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationIcons() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          // Pickup Icon with animation
          _buildLocationDot(Icons.circle, primaryColor),
          SizedBox(height: 8),
          // Animated connecting line
          Container(
            width: 2,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryColor.withOpacity(0.3),
                  Colors.grey[300]!,
                  primaryColor.withOpacity(0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SizedBox(height: 8),
          // Dropoff Icon
          _buildLocationDot(Icons.location_on_outlined, Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildLocationDot(IconData icon, Color color) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Center(child: Icon(icon, color: color, size: 18)),
    );
  }

  Widget _buildViaLocationToggle() {
    return Tooltip(
      message: showViaLocation ? 'Remove via location' : 'Add via location',
      child: InkWell(
        onTap: () {
          setState(() {
            showViaLocation = !showViaLocation;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: showViaLocation ? Colors.orange[50] : Colors.grey[50],
            shape: BoxShape.circle,
            border: Border.all(
              color: showViaLocation ? Colors.orange : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: showViaLocation
                  ? Icon(
                      Icons.remove,
                      color: Colors.orange,
                      size: 18,
                      key: Key('remove'),
                    )
                  : Icon(
                      Icons.add,
                      color: Colors.grey[600],
                      size: 18,
                      key: Key('add'),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAirportDropdown({required bool isPickup}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
      ),
      child: Obx(
        () => DropdownButton<String>(
          value: airportController.selectedAirport.value,
          dropdownColor: Colors.white,
          underline: const SizedBox(),
          icon: Icon(Icons.airplanemode_active, color: primaryColor),
          style: TextStyle(fontSize: 16, color: Colors.grey[800]),
          borderRadius: BorderRadius.circular(12),
          onChanged: (newAirport) {
            if (newAirport == null) return;
            airportController.selectedAirport.value = newAirport;
            if (isPickup) {
              locationController.pickUpLocation.value = newAirport;
            } else {
              locationController.dropLocation.value = newAirport;
            }
            airportController.updateSelectedCoordinates(newAirport);
          },
          items: airportController.airports.map((airport) {
            return DropdownMenuItem<String>(
              value: airport,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(airport, style: TextStyle(fontSize: 14)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDateTimeSection() {
    final shouldShowDateTime = !['4', '6'].contains(widget.tripType);

    return shouldShowDateTime
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: 8),
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
                SizedBox(height: 16),
                DateAndTime(
                  onDateTimeSelected: (date, time) {
                    selectedDate = date;
                    selectedTime = time;
                  },
                ),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _buildTripOptionsSection() {
    if (widget.tripType == '4') return const SizedBox();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trip_origin_outlined, color: primaryColor, size: 20),
              SizedBox(width: 8),
              Text(
                'Trip Options',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          airportController.selectedTripType.value == 'round'
              ? _buildRoundTripSection()
              : _buildHourSelectionSection(),
        ],
      ),
    );
  }

  Widget _buildRoundTripSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!, width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Ionicons.repeat_outline,
                  size: 20,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Round Trip',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Enable for return journey',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Transform.scale(
                scale: 1.2,
                child: CupertinoSwitch(
                  value: isRoundTrip,
                  activeColor: primaryColor,
                  trackColor: Colors.grey[300],
                  onChanged: (value) {
                    setState(() {
                      isRoundTrip = value;
                      roundTripValue = isRoundTrip ? 1 : 0;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        if (isRoundTrip) ...[
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[100]!, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: Colors.blue[700],
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Return Schedule',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                DateAndTime(
                  onDateTimeSelected: (date, time) {
                    selectedReturnDate = date;
                    selectedReturnTime = time;
                  },
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHourSelectionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.blue[50]!, Colors.purple[50]!],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[100]!, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timer_outlined, color: Colors.blue[700], size: 18),
              SizedBox(width: 8),
              Text(
                'Hourly Booking',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildHourButton(
                  icon: Icons.remove,
                  onTap: () {
                    if (airportController.hour.value > 2) {
                      airportController.hour.value--;
                    }
                  },
                  color: Colors.red[400],
                ),
              ),
              SizedBox(width: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      airportController.hour.value.toString(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    Text(
                      'Hours',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _buildHourButton(
                  icon: Icons.add,
                  onTap: () => airportController.hour.value++,
                  color: Colors.green[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHourButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color!.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Center(child: Icon(icon, color: color, size: 24)),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Obx(() {
      if (_controller.isLoading.value) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
        );
      }

      // return Container(
      //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topLeft,
      //       end: Alignment.bottomRight,
      //       colors: [primaryColor, primaryColor.withOpacity(0.8)],
      //     ),
      //     borderRadius: BorderRadius.circular(16),
      //     boxShadow: [
      //       BoxShadow(
      //         color: primaryColor.withOpacity(0.3),
      //         blurRadius: 15,
      //         spreadRadius: 2,
      //         offset: Offset(0, 4),
      //       ),
      //     ],
      //   ),
      //   child: InkWell(
      //     onTap: _handleSubmit,
      //     borderRadius: BorderRadius.circular(12),
      //     child: Container(
      //       padding: EdgeInsets.symmetric(vertical: 18),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Icon(Icons.directions_car_filled_outlined,
      //               color: Colors.white, size: 24),
      //           SizedBox(width: 12),
      //           Text(
      //             'tripForm'.tr,
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 18,
      //               fontWeight: FontWeight.w600,
      //               letterSpacing: 0.5,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
        child: primaryButton(
          buttonName: 'Submit Trip Request',
          radius: 16.0,
          onTap: _handleSubmit,
        ),
      );
    });
  }

  Future<void> _handlePickupLocationTap() async {
    if (widget.isAirport == false ||
        airportController.selectedLocation.value == 'Home') {
      await _selectLocation(
        isPickup: true,
        lat: locationController.selectedPickUpLat.value,
        lng: locationController.selectedPickUpLng.value,
      );
    }
  }

  Future<void> _handleDropoffLocationTap() async {
    if (widget.isAirport == false ||
        airportController.selectedLocation.value != 'Home') {
      await _selectLocation(
        isPickup: false,
        lat: locationController.selectedDropUpLat.value,
        lng: locationController.selectedDropUpLng.value,
      );
    }
  }

  Future<void> _selectLocation({
    required bool isPickup,
    required String lat,
    required String lng,
  }) async {
    final location = await Get.to(
      () => MapSinglePickerScreen(
        lat: double.tryParse(lat),
        lng: double.tryParse(lng),
      ),
    );

    if (location == null) return;

    _updateLocationData(location, isPickup);
  }

  void _updateLocationData(Map<String, dynamic> location, bool isPickup) {
    final lat = location['lat'].toString();
    final lng = location['lng'].toString();
    final address = location['address'].toString();
    final placeId = location['place_id'];

    Get.snackbar("Single Location", "$address\n($lat, $lng)");

    if (isPickup) {
      locationController.selectedPickUpLat.value = lat;
      locationController.selectedPickUpLng.value = lng;
      locationController.pickUpC.text = address;
      locationController.pickUpLocation.value = address;

      if (placeId != null) {
        locationController.selectPikUpAddress(
          Suggestion(placeId: placeId, description: address),
        );
      }
    } else {
      locationController.selectedDropUpLat.value = lat;
      locationController.selectedDropUpLng.value = lng;
      locationController.dropC.text = address;
      locationController.dropLocation.value = address;
    }
  }

  Widget _buildLocationInputs() {
    return widget.isAirport == true
        ? Obx(() => _buildAirportLocationInputs())
        : _buildRegularLocationInputs();
  }

  Widget _buildAirportLocationInputs() {
    final isFromAirport = airportController.selectedLocation.value == 'Airport';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pickup Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            KText(
              text: 'pickUpPoint',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            _buildViaLocationToggle(),
          ],
        ),
        SizedBox(height: 5),

        if (isFromAirport) ...[
          _buildAirportDropdown(isPickup: true),
          SizedBox(height: 10),
        ] else ...[
          PickUp(),
          SizedBox(height: 5),
        ],

        // Via Location (Conditional)
        if (showViaLocation) ViaLocation(),

        // Drop Section
        SizedBox(height: 10),
        KText(text: 'dropOffPoint', fontSize: 16, fontWeight: FontWeight.bold),
        SizedBox(height: 5),

        isFromAirport ? DropWidget() : _buildAirportDropdown(isPickup: false),
      ],
    );
  }

  Widget _buildRegularLocationInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pickup Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            KText(
              text: 'pickUpPoint',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            _buildViaLocationToggle(),
          ],
        ),
        SizedBox(height: 5),
        PickUp(),
        SizedBox(height: 5),

        // Via Location (Conditional)
        if (showViaLocation) ViaLocation(),

        // Drop Section
        SizedBox(height: 10),
        KText(text: 'dropOffPoint', fontSize: 16, fontWeight: FontWeight.bold),
        SizedBox(height: 5),
        DropWidget(),
      ],
    );
  }

  void _handleSubmit() {
    // Validate required fields
    if (!_validateRequiredFields()) {
      return;
    }

    // Prepare data for submission
    final formData = _prepareFormData();

    // Navigate to trip details
    Get.to(
      () => TripDetailsPage(
        carImg: widget.carImg,
        carName: widget.carName,
        capacity: widget.capacity,
        carId: widget.carId,
        pickUpPoint: formData.pickupLocation,
        dropPoint: formData.dropLocation,
        viaPoint: locationController.viaLocation.toString(),
        note: noteController.text,
        tripDetailsJourney: formData.journeyDateTime,
        roundTrip: roundTripValue.toString(),
        map: formData.pickupCoordinates,
        roundTripDetailsJourney: formData.returnDateTime,
        pickupDivision: locationController.pickupDivision.value,
        isAmbulance: false,
        dropOffMap: formData.dropoffCoordinates,
        categoryID: widget.tripType,
      ),
    );
  }

  bool _validateRequiredFields() {
    final hasPickup = locationController.pickUpLocation.isNotEmpty;
    final hasDropoff = locationController.dropLocation.isNotEmpty;

    if (!hasPickup || !hasDropoff) {
      Get.snackbar(
        'Sorry',
        "Pick & Drop Point Cannot be Empty",
        colorText: white,
        backgroundColor: Colors.redAccent,
      );
      return false;
    }

    return true;
  }

  FormData _prepareFormData() {
    final journeyDateTime = _formatDateTime(selectedDate, selectedTime);
    final returnDateTime = _formatDateTime(
      selectedReturnDate,
      selectedReturnTime,
    );

    final isAirportTrip = widget.isAirport == true;
    final isFromAirport = airportController.selectedLocation.value == 'Airport';

    return FormData(
      pickupLocation:
      // isAirportTrip && isFromAirport
      //     ? airportController.selectedAirport.value
      //     :
      locationController.pickUpLocation.toString(),
      dropLocation:
      // isAirportTrip && !isFromAirport
      //     ? airportController.selectedAirport.value
      //     :
      locationController.dropLocation.toString(),
      journeyDateTime: journeyDateTime,
      returnDateTime: returnDateTime,
      pickupCoordinates:
      // isAirportTrip && isFromAirport
      //     ? airportController.selectedCoordinates.value.toString()
      //     :
      '${locationController.selectedPickUpLat.value} ${locationController.selectedPickUpLng.value}',
      dropoffCoordinates:
      // isAirportTrip && !isFromAirport
      //     ? airportController.selectedCoordinates.value.toString()
      //     :
      '${locationController.selectedDropUpLat.value},${locationController.selectedDropUpLng.value}',
    );
  }

  String _formatDateTime(DateTime date, TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? '12' : '${time.hourOfPeriod}';
    final minute = '${time.minute}'.padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} $hour:$minute $period';
  }
}

// Data class for form data
class FormData {
  final String pickupLocation;
  final String dropLocation;
  final String journeyDateTime;
  final String returnDateTime;
  final String pickupCoordinates;
  final String dropoffCoordinates;

  FormData({
    required this.pickupLocation,
    required this.dropLocation,
    required this.journeyDateTime,
    required this.returnDateTime,
    required this.pickupCoordinates,
    required this.dropoffCoordinates,
  });
}
