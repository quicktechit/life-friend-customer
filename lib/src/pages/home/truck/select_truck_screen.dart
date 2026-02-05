import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/language/langController.dart';
import 'package:pickup_load_update/src/pages/home/truck/shipping_details.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../configs/appBaseUrls.dart';
import '../../../controllers/truck/truck_controller.dart';
import '../../../models/truck_related_model/truck_category_model.dart';
import '../../../widgets/date and time widget/date_time_widget.dart';

class SelectTruckScreen extends StatefulWidget {
  SelectTruckScreen({super.key});

  @override
  State<SelectTruckScreen> createState() => _SelectTruckScreenState();
}

class _SelectTruckScreenState extends State<SelectTruckScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late PageController _pageController;
  final LangController langController = Get.find();
  int? selectedIndexOpen = -1;
  int? selectedIndexCover = -1;
  String? selectedValue1;
  String? selectedValue2;
  var id;
  final TruckController truckController = Get.find();

  @override
  void initState() {
    super.initState();

    // Initialize TabController with the number of sizecategories
    _tabController = TabController(length: truckController.sizeCategory.length, vsync: this);

    // Initialize PageController to detect swipe
    _pageController = PageController();

    // Listen for changes in the TabController (when a tab is tapped)
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          // Sync PageView with TabController when a tab is tapped
          _pageController.jumpToPage(_tabController.index);

          // Reset values when the tab changes
          selectedIndexOpen = -1;
          selectedIndexCover = -1;
        });
      }
    });

    // Sync the PageView with TabController when swiping
    _pageController.addListener(() {
      if (_pageController.page?.round() != _tabController.index) {
        _tabController.animateTo(_pageController.page!.round());
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();  // Dispose PageController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'selectTruck'.tr.text.white.make(),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          controller: _tabController,
          tabs: List.generate(
              truckController.sizeCategory.length,
              (index) => Obx(
                    () => Tab(
                      text: langController.selectedLang.value.toString() == 'en_US'
                          ? truckController.sizeCategory[index].name
                          : truckController.sizeCategory[index]
                              .nameBn, // Use the name of each sizecategory
                    ),
                  )),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          // When the page is swiped, update the TabController to match
          if (_tabController.index != index) {
            _tabController.animateTo(index);
          }
        },
        children: List.generate(
          truckController.sizeCategory.length,
          (index) {
            return Stack(
              children: [
                ListView(
                  children: [
                    buildTabContent(truckController.sizeCategory[index], index),
                  ],
                ),
                selectedIndexOpen != -1 || selectedIndexCover != -1
                    ? Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      primaryColor)),
                              onPressed: () async {


                                truckController
                                    .getService(truckController.id);

                                Get.bottomSheet(
                                    clipBehavior: Clip.antiAlias,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ), StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                  return Container(
                                    height: 200.h,
                                    width: Get.width,
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        "Pick up time"
                                            .tr
                                            .text
                                            .bold
                                            .size(18)
                                            .black
                                            .make(),
                                        10.heightBox,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            DateAndTime(
                                              onDateTimeSelected:
                                                  (date, time) {
                                                    truckController
                                                        .selectedDate =
                                                        date;
                                                    truckController
                                                        .selectedTime =
                                                        time;
                                              },
                                            ),
                                            // Column(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.start,
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   children: [
                                            //     const Text(
                                            //       "দিন",
                                            //       style: TextStyle(
                                            //           fontSize: 15,
                                            //           fontWeight:
                                            //               FontWeight.w600),
                                            //     ),
                                            //     GestureDetector(
                                            //       onTap: () async {
                                            //         // Call the _selectDate function to show the date picker
                                            //         await _selectDate(context);
                                            //
                                            //         // Log the selected date (optional)
                                            //         print("Selected Date: $selectedDate");
                                            //       },
                                            //       child: Container(
                                            //         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                            //         decoration: BoxDecoration(
                                            //           border: Border.all(color: Colors.grey),
                                            //           borderRadius: BorderRadius.circular(4),
                                            //         ),
                                            //         child: Row(
                                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //           children: [
                                            //             Text(
                                            //               selectedDate,
                                            //               style: const TextStyle(color: Colors.black),
                                            //             ),
                                            //             const Icon(Icons.calendar_today_outlined),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // const Spacer(),
                                            // Column(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.start,
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   children: [
                                            //     const Text(
                                            //       "ঘন্টা",
                                            //       style: TextStyle(
                                            //           fontSize: 15,
                                            //           fontWeight:
                                            //               FontWeight.w600),
                                            //     ),
                                            //     GestureDetector(
                                            //       onTap: () async {
                                            //         TimeOfDay? pickedTime =
                                            //             await showTimePicker(
                                            //           context: context,
                                            //           initialTime:
                                            //               TimeOfDay.now(),
                                            //         );
                                            //
                                            //         if (pickedTime != null) {
                                            //           setState(() {
                                            //             selectedTime =
                                            //                 pickedTime.format(
                                            //                     context);
                                            //           });
                                            //           log(selectedTime,
                                            //               name:
                                            //                   'Selected Time');
                                            //         }
                                            //       },
                                            //       child: Container(
                                            //         padding: const EdgeInsets
                                            //             .symmetric(
                                            //             vertical: 12,
                                            //             horizontal: 16),
                                            //         decoration: BoxDecoration(
                                            //           border: Border.all(
                                            //               color: Colors.grey),
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   4),
                                            //         ),
                                            //         child: Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .spaceBetween,
                                            //           children: [
                                            //             Text(
                                            //               selectedTime,
                                            //               style:
                                            //                   const TextStyle(
                                            //                       color: Colors
                                            //                           .black),
                                            //             ),
                                            //             const Icon(Icons
                                            //                 .access_time_outlined),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ],
                                            // )
                                          ],
                                        ).paddingSymmetric(vertical: 10),

                                        TextButton(
                                                onPressed: () {
                                                  truckController.totalPriceNew='';
                                                  truckController.calculateRangeAmount();
                                                  log(truckController
                                                      .distances.value);
                                                  log(truckController.amounts
                                                      .toString());
                                                  if (truckController
                                                      .price.value !=
                                                      'Bid') {
                                                    truckController
                                                        .totalPrice =
                                                        (int.parse(
                                                            truckController
                                                                .amounts
                                                                .toString()) *
                                                            int.parse(
                                                                truckController
                                                                    .distances
                                                                    .value
                                                                    .toString()))
                                                            .toString();
                                                    log(truckController
                                                            .totalPrice,name: "before");
                                                        truckController
                                                        .totalPrice =
                                                        (int.parse(
                                                            truckController
                                                                .totalPrice) +
                                                            int.parse(
                                                                truckController
                                                                    .price
                                                                    .value))
                                                            .toString();
                                                    log(truckController
                                                        .totalPrice,name: "after");
                                                  } else {
                                                    truckController
                                                        .totalPrice = 'Bid';
                                                  }

                                                  Get.to(
                                                      () => ShippingDetails(),
                                                      transition:
                                                          Transition.fadeIn,
                                                      duration:
                                                          const Duration(
                                                              seconds: 1));
                                                },
                                                child: "go next"
                                                    .tr
                                                    .text
                                                    .white
                                                    .semiBold
                                                    .size(15)
                                                    .make())
                                            .box.width(context.screenWidth/1.2).color(primaryColor).rounded.makeCentered(),

                                      ],
                                    ),
                                  );
                                }));
                              },
                              child: Text(
                                "go next".tr,
                                style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              )).box.width(context.screenWidth/1.2).color(primaryColor).rounded.makeCentered(),
                        ),
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }

  // Build the content for each tab
  Widget buildTabContent(Sizecategories sizecategory, int tabIndex) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover Vehicles List
          sizeH10,
          ListView.builder(
            itemCount: sizecategory.vehicles?.length,
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final vehicle = sizecategory.vehicles?[index];
              return GestureDetector(
                onTap: () async {
                log('${vehicle?.id}');
                await truckController.getAmount(vehicle?.id);
                truckController.getRange(vehicle?.id);
                  setState(() {
                    log("${vehicle?.id}",name: "vehicle id");
                    log("${vehicle?.sizecategoryId}",name: "Size Category id");

                    selectedIndexCover =
                        (selectedIndexCover == index) ? -1 : index;
                    selectedIndexOpen = -1;
                    truckController.truck_type = "${vehicle?.truckType}";
                    truckController.sizeId = "${vehicle?.sizecategoryId}";
                    truckController.id = "${vehicle?.id}";
                    truckController.name = "${vehicle?.name}";
                    truckController.image = "${vehicle?.image}";
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                            Urls.getImageURL(endPoint: "${vehicle?.image}"),
                            height: 60,
                            width: 80,
                            fit: BoxFit.cover)
                        .box
                        .rounded
                        .clip(Clip.antiAlias)
                        .make(),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                            ()=> Text(langController.selectedLang.value.toString() ==
                                      'en_US'
                                  ? "${vehicle?.name}"
                                  : "${vehicle?.nameBn}",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                            ),
                            Text(
                              "${vehicle?.description}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                    ),
                    SizedBox(width: 10.w),
                    KText(text: 'Bid'),
                  ],
                )
                    .box
                    .padding(EdgeInsets.symmetric(horizontal: 10, vertical: 15))
                    .color(
                      selectedIndexCover == index ? titleColor : Colors.white,
                    )
                    .shadowXs
                    .margin(EdgeInsets.symmetric(horizontal: 10, vertical: 5))
                    .roundedSM
                    .make(),
              );
            },
          ),
          50.heightBox,
        ],
      );
  }
}
