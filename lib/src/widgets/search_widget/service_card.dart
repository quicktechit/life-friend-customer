import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../configs/app_list.dart';
import '../../controllers/return trip controller/return_filter_controller.dart';
import '../../controllers/vehicles categoris/quick_tech_vehicles_controller.dart';
import '../../pages/home/rental/rentalListPage.dart';
import '../../pages/home/rental/rentalPointPage.dart';
import '../../pages/home/return trip/return_trip_list_filter.dart';
import '../../pages/home/truck/select_location.dart';
import '../text/kText.dart';

Widget buildQuickServiceCard(BuildContext context,ServiceItem service, double width) {
  final vehicleController = Get.put(QuickTechVehiclesController());
  final ReturnTripFilter returnTripFilter = Get.put(ReturnTripFilter());
  return GestureDetector(
    onTap: () async {
      switch (service.onTap) {
        case 'returnTruck':
          Get.to(() => ReturnTripListFilterPage());
          return;
        case 'truckRental':
          Get.to(() => SelectLocation());
          await returnTripFilter.returnTripFilterList();
          return;
        case 'ambulance':
          await vehicleController.getVehicles(id: '2');
          Get.to(
                () => RentalListPage(tripType: 'Ambulance', ambulance: true),
          );
          break;
        case 'carRental':
          await vehicleController.getVehicles(id: '2');
          Get.to(() => RentalListPage(isAirport: false, tripType: 'car'));
          break;
        case 'airport':
          await vehicleController.getVehicles(id: '2');
          Get.to(() => RentalListPage(isAirport: true, tripType: 'car'));
          break;
        case 'rideShare':
          Get.to(
                () => RentalPointPage(
              isAirport: false,
              carImg: '',
              carName: 'bike',
              capacity: '',
              carId: '',
              tripType: '4',
            ),
          );
          break;
      }
    },
    child: Container(
      width: context.screenWidth,
      height: 110, // Maintains a consistent vertical feel
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // colors: service.gradient,
          colors: [Colors.grey.shade300, Colors.grey.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: service.gradient[0].withOpacity(0.3),
        //     blurRadius: 10,
        //     offset: Offset(0, 5),
        //   ),
        // ],
      ),
      child: Stack(
        children: [
          // Background "Watermark" Icon
          Positioned(
            right: -5,
            bottom: -5,
            child: Text(
              service.icon,
              style: TextStyle(
                fontSize: 45,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Text(service.icon, style: TextStyle(fontSize: 24)),
                ),
                KText(
                  text: service.title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  // textAlign: TextAlign.center,
                ),
                KText(
                  text: service.subtitle,
                  fontSize: 10.sp,
                  color: Colors.black,
                  // textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}