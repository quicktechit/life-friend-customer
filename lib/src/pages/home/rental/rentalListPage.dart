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
import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          isTrac == true
              ? 'truckTrip'.tr
              : isAirport == true
              ? "airportTrip".tr
              : ambulance == true
              ? "ambulanceService".tr
              : "carTrip".tr,
          style: TextStyle(color: Colors.white, fontSize: 17.h),
        ),
      ),
      body: Obx(() {
        if (carCategoryController.isLoading.value) {
          return Center(child: loader());
        } else {
          return Padding(
            padding: paddingH10,
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: vehicleController.data.length,
                      itemBuilder: (c, i) {
                        final item = vehicleController.data.elementAt(i);
                        return Obx(
                          () => CustomCardWidget(
                            onTap: () {
                              // Set the selected item
                              selectedItem.value = item;
                            },
                            elevation: 1,
                            color: selectedItem.value == item
                                ? primaryColor
                                : Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Image.network(
                                    Urls.getImageURL(
                                      endPoint: item.image.toString(),
                                    ),
                                    width: 110,
                                    height: 70,
                                    fit: BoxFit.contain,
                                  ),
                                  50.widthBox,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: item.name.toString(),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      5.verticalSpace,
                                      KText(
                                        text:
                                            "Seats Capacity  ${item.capacity}",
                                        fontSize: 14,
                                        color: black54,
                                      ),
                                    ],
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
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: selectedItem.value != null
                          ? () {
                              ambulance == true
                                  ? Get.to(
                                      () => AmbulancePage(
                                        carImg: Urls.getImageURL(
                                          endPoint: selectedItem.value!.image
                                              .toString(),
                                        ),
                                        carName: selectedItem.value!.name
                                            .toString(),
                                        capacity: selectedItem.value!.capacity
                                            .toString(),
                                        carId: selectedItem.value!.id
                                            .toString(),
                                        tripType: tripType,
                                      ),
                                    )
                                  : Get.to(
                                      () => RentalPointPage(
                                        isAirport: isAirport,
                                        carImg: Urls.getImageURL(
                                          endPoint: selectedItem.value!.image
                                              .toString(),
                                        ),
                                        carName: selectedItem.value!.name
                                            .toString(),
                                        capacity: selectedItem.value!.capacity
                                            .toString(),
                                        carId: selectedItem.value!.id
                                            .toString(),
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
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedItem.value != null
                            ? primaryColor
                            : Colors.grey,
                      ), // Disable if no item selected
                      child: Text(
                        "next".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ).w(context.screenWidth / 1.2),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
