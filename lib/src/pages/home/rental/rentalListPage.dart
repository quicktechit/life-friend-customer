import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/car%20category%20controller/car_category_list_controller.dart';
import 'package:pickup_load_update/src/controllers/vehicles%20categoris/quick_tech_vehicles_controller.dart';
import 'package:pickup_load_update/src/models/vehicle_categories/quick_tech_get_vehicle_categories.dart';
import 'package:pickup_load_update/src/pages/home/ambulence/ambulance_page.dart';
import 'package:pickup_load_update/src/pages/home/rental/rentalPointPage.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';
import 'package:pickup_load_update/src/widgets/custom_button_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/rental trip request controllers/rental_trip_req_submit_controller.dart';

class RentalListPage extends StatefulWidget {
  final bool? isAirport;
  final bool? isTrac;
  final bool? ambulance;
  final String tripType;

  const RentalListPage({
    super.key,
    this.isAirport,
    this.isTrac,
    required this.tripType,
    this.ambulance,
  });

  @override
  State<RentalListPage> createState() => _RentalListPageState();
}

class _RentalListPageState extends State<RentalListPage> {
  final CarCategoryController carCategoryController = Get.put(
    CarCategoryController(),
  );
  final RentalTripSubmitController controller = Get.put(
    RentalTripSubmitController(),
  );
  final vehicleController = Get.put(QuickTechVehiclesController());

  // Variable to store the selected item

  String get _pageTitle {
    if (widget.isTrac == true) return 'truckTrip'.tr;
    if (widget.isAirport == true) return "airportTrip".tr;
    if (widget.ambulance == true) return "ambulanceService".tr;
    return "carTrip".tr;
  }

  String _getVehicleIcon(String vehicleType) {
    switch (vehicleType.toLowerCase()) {
      case 'truck':
        return '🚚';
      case 'ambulance':
        return '🚑';
      case 'bike':
        return '🏍️';
      default:
        return '🚗';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.selectedAnswers.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          _pageTitle,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.h,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        final isLoading = vehicleController.isLoading.value;
        final vehicles = vehicleController.data;

        if (isLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'loadingVehicles'.tr,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        } else if (vehicles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.car_rental, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                Text(
                  'noVehiclesAvailable'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'pleaseCheckBackLater'.tr,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              // Header section
              _buildHeader(context),

              // Vehicles list
              Expanded(child: _buildVehicleList(vehicles)),

              // Next button
              Obx(() => _buildNextButton(context)),
            ],
          );
        }
      }),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.directions_car, color: primaryColor, size: 24),
              const SizedBox(width: 8),
              Text(
                'selectVehicle'.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'tapToSelectVehicle'.tr,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList(List<Datum> vehicles) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: vehicles.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final vehicle = vehicles[index];

          return GestureDetector(
            onTap: () {
              vehicleController.selectedItem.value = vehicle;
            },
            child: Obx(() {
              final isSelected =
                  vehicleController.selectedItem.value == vehicle;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? primaryColor.withOpacity(0.05)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[200]!,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isSelected ? 0.1 : 0.05),
                      blurRadius: isSelected ? 15 : 10,
                      offset: const Offset(0, 5),
                      spreadRadius: isSelected ? 0 : 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .start,
                  children: [
                    // Main content
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .start,
                        children: [
                          // Vehicle Image
                          Container(
                            width: 100,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: isSelected
                                    ? [
                                        primaryColor.withOpacity(0.2),
                                        primaryColor.withOpacity(0.05),
                                      ]
                                    : [Colors.grey[50]!, Colors.white],
                              ),
                              border: Border.all(
                                color: isSelected
                                    ? primaryColor.withOpacity(0.3)
                                    : Colors.grey[200]!,
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                Urls.getImageURL(endPoint: vehicle.image ?? ''),
                                width: 100,
                                height: 80,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 100,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getVehicleIcon(vehicle.name ?? ''),
                                        style: TextStyle(
                                          fontSize: 40,
                                          color: isSelected
                                              ? primaryColor
                                              : Colors.grey[400],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Vehicle Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Vehicle name
                                Text(
                                  vehicle.name ?? 'Unknown Vehicle',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.grey[900],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                // Bengali name if available
                                if (vehicle.nameBn != null &&
                                    vehicle.nameBn!.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Text(
                                      vehicle.nameBn!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                const SizedBox(height: 8),

                                // Capacity
                                if (vehicle.capacity != null)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.people,
                                        size: 16,
                                        color: isSelected
                                            ? primaryColor
                                            : Colors.grey[500],
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${vehicle.capacity} ${'seats'.tr}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      // Status badge if needed
                                      if (vehicle.status != null &&
                                          vehicle.status == '1')
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green.withOpacity(
                                                0.1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              'available'.tr,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.green[700],
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                          ),

                          // Selection indicator
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryColor
                                  : Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isSelected
                                  ? Icons.check
                                  : Icons.arrow_forward_ios,
                              size: 16,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // See More Section
                    GestureDetector(
                      onTap: () {
                        _showVehicleDetails(context, vehicle);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                          color: isSelected
                              ? primaryColor.withOpacity(0.05)
                              : Colors.grey[50],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'seeMoreDetails'.tr,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? primaryColor
                                    : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: isSelected
                                  ? primaryColor
                                  : Colors.grey[500],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }

  // Method to show vehicle details
  void _showVehicleDetails(BuildContext context, dynamic vehicle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      vehicle.name ?? 'Vehicle Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Vehicle image
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          Urls.getImageURL(endPoint: vehicle.image ?? ''),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _getVehicleIcon(vehicle.name ?? ''),
                                      style: const TextStyle(fontSize: 60),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Image not available',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Vehicle name and Bengali name
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle.name ?? 'Unknown Vehicle',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (vehicle.nameBn != null &&
                                  vehicle.nameBn!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    vehicle.nameBn!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (vehicle.status == '1')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:  Text(
                              'available'.tr,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Specifications
                     Text(
                      'specifications'.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Specs grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 2.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      children: [
                        if (vehicle.capacity != null)
                          _buildDetailItem(
                            icon: Icons.people,
                            label: 'seatCapacity'.tr,
                            value: '${vehicle.capacity} ${"persons".tr}',
                          ),
                        _buildDetailItem(
                          icon: Icons.tag,
                          label: 'vehicleId'.tr,
                          value: '#${vehicle.id ?? 'N/A'}',
                        ),
                        if (vehicle.slug != null)
                          _buildDetailItem(
                            icon: Icons.link,
                            label: 'slug'.tr,
                            value: vehicle.slug!,
                          ),
                        _buildDetailItem(
                          icon: Icons.calendar_today,
                          label: 'created'.tr,
                          value: formatFullDateTime(
                            vehicle.createdAt.toString(),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Additional info
                    if (vehicle.updatedAt != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          '${"lastUpdated".tr} ${formatFullDateTime(vehicle.updatedAt.toString())}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Select button
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    vehicleController.selectedItem.value = vehicle;
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child:  Text('selectThisVehicle'.tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for detail items
  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 18, color: primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to format date
  String formatFullDateTime(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      DateTime date = DateTime.parse(dateString.replaceFirst(' ', 'T'));
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildNextButton(BuildContext context) {
    final isEnabled = vehicleController.selectedItem.value != null;
    final selected = vehicleController.selectedItem.value;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Selected vehicle indicator
          if (selected != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Image.network(
                      Urls.getImageURL(endPoint: selected.image.toString()),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selected.name.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${'capacity'.tr}: ${selected.capacity} ${'seats'.tr}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      vehicleController.selectedItem.value = null;
                    },
                    icon: const Icon(Icons.close),
                    color: Colors.grey[500],
                  ),
                ],
              ),
            ),

          // Next button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isEnabled ? () => _handleNext(context) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnabled ? primaryColor : Colors.grey[400],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                shadowColor: isEnabled
                    ? primaryColor.withOpacity(0.3)
                    : Colors.transparent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "next".tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext(BuildContext context) {
    if (widget.ambulance == true) {
      Get.to(
        () => AmbulancePage(
          carImg: Urls.getImageURL(
            endPoint: vehicleController.selectedItem.value!.image.toString(),
          ),
          carName: vehicleController.selectedItem.value!.name.toString(),
          capacity: vehicleController.selectedItem.value!.capacity.toString(),
          carId: vehicleController.selectedItem.value!.id.toString(),
          tripType: '6',
          question:
              vehicleController.selectedItem.value?.vehicleQuestions ?? [],
        ),
      );
    } else {
      Get.to(
        () => RentalPointPage(
          isAirport: widget.isAirport,
          carImg: Urls.getImageURL(
            endPoint: vehicleController.selectedItem.value!.image.toString(),
          ),
          carName: vehicleController.selectedItem.value!.name.toString(),
          capacity: vehicleController.selectedItem.value!.capacity.toString(),
          carId: vehicleController.selectedItem.value!.id.toString(),
          tripType: widget.tripType == 'car'
              ? '2'
              : widget.tripType == 'truck'
              ? '1'
              : widget.tripType == 'bike'
              ? '4'
              : '1',
        ),
      );
    }
  }
}
