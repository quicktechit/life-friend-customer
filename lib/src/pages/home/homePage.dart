import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/vehicles%20categoris/quick_tech_vehicles_controller.dart';
import 'package:pickup_load_update/src/pages/home/rental/rentalListPage.dart';
import 'package:pickup_load_update/src/pages/home/rental/rentalPointPage.dart';
import 'package:pickup_load_update/src/pages/home/return%20trip/return_trip_list_filter.dart';
import 'package:pickup_load_update/src/pages/home/truck/select_location.dart';
import 'package:pickup_load_update/src/widgets/custom%20app%20bar/app_bar_widget.dart';
import 'package:pickup_load_update/src/widgets/divider_widget.dart';
import 'package:pickup_load_update/src/widgets/slider/slider_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:pickup_load_update/src/widgets/web_view/in_app_web_view_screen.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/drawer/sidebarComponent.dart';
import '../../controllers/rental trip request controllers/rental_trip_req_submit_controller.dart';
import '../../controllers/return trip controller/return_filter_controller.dart';
import '../../controllers/truck/truck_controller.dart';
import '../../widgets/button/primaryButton.dart';
import '../live bidding/live_bidding_page.dart';
import '../live bidding/live_biding_page_truck.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final vehicleController = Get.put(QuickTechVehiclesController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final TruckController truckController = Get.put(TruckController());
  var box = GetStorage();
  final RentalTripSubmitController _rentalTripSubmitController = Get.put(
    RentalTripSubmitController(),
  );
  final ReturnTripFilter returnTripFilter = Get.put(ReturnTripFilter());
  List name = ["ambulanceService", "truckRental", "return truck"];
  List images = [
    'assets/new_image/ambulance.jpeg',
    'assets/new_image/truck.jpg',
    'assets/new_image/truck2.jpeg',
  ];

  @override
  void initState() {
    super.initState();

    // _getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      drawer: Drawer(child: ExampleSidebarX(controller: _controller)),
      appBar: CustomCommonAppBar(title: 'homeTitle', scaffoldKey: _scaffoldKey),
      body: ListView(
        children: [
          sizeH20,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderWidget(),
              sizeH10,
              Padding(
                padding: paddingH20,
                child: DividerWidget(title: "chooseRide"),
              ),
              SizedBox(height: 5.h),
              Obx(() {
                if (_rentalTripSubmitController.liveBidStart.value ||
                    _rentalTripSubmitController.liveBidTruckStart.value) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        if (_rentalTripSubmitController.liveBidTruckStart.value)
                          Container(
                            alignment: Alignment.center,
                            width: context.screenWidth,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.4),
                                  Colors.orange.shade500,
                                  Colors.orange.shade500,
                                  Colors.black.withOpacity(0.4),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: KText(
                              text: "youHaveTruckOngoingTrip".tr,
                              color: Colors.white,
                            ),
                          ).onTap(() {
                            Get.to(
                              () => LiveBiddingPageTruck(
                                createdAt: DateTime.now().toLocal().toString(),
                                id: box.read("BUIDID").toString(),
                              ),
                            );
                          }),

                        10.heightBox,
                        if (_rentalTripSubmitController.liveBidStart.value)
                          Container(
                            alignment: Alignment.center,
                            width: context.screenWidth,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.4),
                                  Colors.orange.shade500,
                                  Colors.orange.shade500,
                                  Colors.black.withOpacity(0.4),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: KText(
                              text: "youHaveOtherOngoingTrip".tr,
                              color: Colors.white,
                            ),
                          ).onTap(() {
                            Get.to(
                              () => LiveBiddingPage(
                                createdAt: DateTime.now().toString(),
                                type: box.read("type"),
                              ),
                            );
                          }),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
              SizedBox(height: 5.h),
              Padding(
                padding: paddingH10,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
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
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            // color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/bke.png',
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                              KText(
                                text: 'Ride share',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      15.horizontalSpace,
                      GestureDetector(
                        onTap: () async {
                          await vehicleController.getVehicles(id: '2');
                          Get.toNamed('/rental');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            // color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/car1.png',
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                              KText(
                                text: 'carRental',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),

                      15.horizontalSpace,
                      GestureDetector(
                        onTap: () async {
                          await vehicleController.getVehicles(id: '2');
                          Get.to(
                            () => RentalListPage(
                              isAirport: true,
                              tripType: 'car',
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            // color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/car3.png',
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                              KText(
                                text: "Airport pickup",
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 15.horizontalSpace,
                      // GestureDetector(
                      //   onTap: () async {
                      //     Get.showSnackbar(
                      //       GetSnackBar(
                      //         title: "Up coming!",
                      //         message: "This feature is not yet available.",
                      //         duration: Duration(seconds: 3),
                      //       ),
                      //     );
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      //     decoration: BoxDecoration(
                      //       // color: Colors.grey.withOpacity(0.4),
                      //         borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.grey.shade400,width: 1.5)
                      //     ),
                      //     child: Row(
                      //       children: [
                      //         Image.asset(
                      //           'assets/images/bus.png',
                      //           width: 50,
                      //           height: 50,
                      //           fit: BoxFit.cover,
                      //         ),
                      //         KText(
                      //           text: 'বাস টিকিট',fontSize: 13,
                      //           fontWeight: FontWeight.bold,
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.h),

              /// desire section
              Padding(
                padding: paddingH10,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,

                  child: Row(
                    children: List.generate(name.length, (index) {
                      return GestureDetector(
                        onTap: () async {
                          if (index == 2) {
                            Get.to(() => SelectLocation());
                          }

                          if (index == 1) {
                            Get.to(() => ReturnTripListFilterPage());
                            await returnTripFilter.returnTripFilterList();
                          }

                          if (index == 0) {
                            await vehicleController.getVehicles(id: '2');

                            Get.to(
                              () => RentalListPage(
                                tripType: 'Ambulance',
                                ambulance: true,
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: context.screenHeight / 2.8,
                          width: context.screenWidth / 1.7,
                          // important for horizontal layout
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.only(right: 12),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.asset(
                                  images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.5, 0.8, 1.0],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.3),
                                        Colors.black.withOpacity(0.9),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 20,
                                left: 10,
                                child: KText(
                                  text: name[index],
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              // sizeH20,
              //
              // // Padding(
              // //   padding: paddingH20,
              // //   child: DividerWidget(title: "others"),
              // // ),
              // sizeH20,
              // GestureDetector(
              //   onTap: () {
              //     Get.to(
              //       () => InAppWebViewScreen(url: 'https://gariseba.com/'),
              //     );
              //   },
              //   child: Container(
              //     margin: paddingH20,
              //     height: 80,
              //     decoration: BoxDecoration(
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.5),
              //           spreadRadius: 6,
              //           blurRadius: 7,
              //           offset: Offset(0, 3),
              //         ),
              //       ],
              //       color: bgColor,
              //       borderRadius: BorderRadius.circular(10.r),
              //     ),
              //     width: double.infinity,
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(10.0.r),
              //       child: Image.asset(
              //         'assets/images/App_Footer_Banner.jpg',
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 15),
            ],
          ),
        ],
      ),
    );
  }

  // void _getDeviceToken() async {
  //   String? token = await _firebaseMessaging.getToken();
  //   print('=============FCM Token: $token');
  //   // Save FCM token using GetStorage
  //   _storage.write('fcm_token', token);
  // }
}
