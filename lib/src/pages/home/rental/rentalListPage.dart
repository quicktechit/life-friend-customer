import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/car%20category%20controller/car_category_list_controller.dart';
import 'package:pickup_load_update/src/controllers/vehicles%20categoris/quick_tech_vehicles_controller.dart';
import 'package:pickup_load_update/src/pages/home/ambulence/ambulance_page.dart';
import 'package:pickup_load_update/src/pages/home/rental/rentalPointPage.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';
import 'package:pickup_load_update/src/widgets/custom_button_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:velocity_x/velocity_x.dart';

class RentalListPage extends StatelessWidget {
  final bool? isAirport;
  final bool? isTrac;
  final bool? ambulance;
  final String tripType;
  final CarCategoryController carCategoryController = Get.put(
    CarCategoryController(),
  );
  final vehicleController = Get.put(QuickTechVehiclesController());

  // Variable to store the selected item
  final Rxn<dynamic> selectedItem = Rxn<dynamic>();

  RentalListPage({
    super.key,
    this.isAirport,
    this.isTrac,
    required this.tripType,
    this.ambulance,
  });

  String get _pageTitle {
    if (isTrac == true) return 'truckTrip'.tr;
    if (isAirport == true) return "airportTrip".tr;
    if (ambulance == true) return "ambulanceService".tr;
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
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        } else if (vehicles.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.car_rental,
                  size: 80,
                  color: Colors.grey[300],
                ),
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
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
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
              Expanded(
                child: _buildVehicleList(vehicles),
              ),

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
              Icon(
                Icons.directions_car,
                color: primaryColor,
                size: 24,
              ),
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
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleList(List<dynamic> vehicles) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final item = vehicles[index];

          return GestureDetector(
            onTap: () {
              selectedItem.value = item;
            },
            child: Obx(() {
              final isSelected = selectedItem.value == item;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[200]!,
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isSelected ? 0.1 : 0.05),
                      blurRadius: isSelected ? 12 : 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Vehicle Image with gradient
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: isSelected
                                  ? [primaryColor.withOpacity(0.3), Colors.transparent]
                                  : [Colors.grey[50]!, Colors.white],
                            ),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                Urls.getImageURL(endPoint: item.image.toString()),
                                width: 130,
                                height: 85,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 120,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _getVehicleIcon(item.name.toString()),
                                        style: const TextStyle(fontSize: 32),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        // Vehicle Details
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item.name.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? primaryColor : Colors.grey[800],
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),

                              // Capacity badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? primaryColor.withOpacity(0.2)
                                      : Colors.grey[100],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.people,
                                      size: 14,
                                      color: isSelected ? primaryColor : Colors.grey[600],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${item.capacity} ${'seats'.tr}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected ? primaryColor : Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),

                    // Selected indicator
                    if (isSelected)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: primaryColor,
                            size: 20,
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

  Widget _buildNextButton(BuildContext context) {
    final isEnabled = selectedItem.value != null;
    final selected = selectedItem.value;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
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
                      Urls.getImageURL(
                        endPoint: selected.image.toString(),
                      ),
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
                      selectedItem.value = null;
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
    if (ambulance == true) {
      Get.to(
            () => AmbulancePage(
          carImg: Urls.getImageURL(
            endPoint: selectedItem.value!.image.toString(),
          ),
          carName: selectedItem.value!.name.toString(),
          capacity: selectedItem.value!.capacity.toString(),
          carId: selectedItem.value!.id.toString(),
          tripType: tripType,
        ),
      );
    } else {
      Get.to(
            () => RentalPointPage(
          isAirport: isAirport,
          carImg: Urls.getImageURL(
            endPoint: selectedItem.value!.image.toString(),
          ),
          carName: selectedItem.value!.name.toString(),
          capacity: selectedItem.value!.capacity.toString(),
          carId: selectedItem.value!.id.toString(),
          tripType: tripType == 'car'
              ? '2'
              : tripType == 'truck'
              ? '1'
              : tripType == 'bike'
              ? '4'
              : '1',
        ),
      );
    }
  }
}
