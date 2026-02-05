import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../configs/appBaseUrls.dart';
import '../../configs/appColors.dart';
import '../../configs/appUtils.dart';
import '../../configs/empty_box_widget.dart';
import '../../configs/loader.dart';
import '../../controllers/new all trip history/all_trip_history_controller.dart';
import '../../models/new_all_trip_history_model.dart';
import '../../pages/home/rental/tripHistoryPage.dart';
import '../../pages/map_page/map_page_view.dart';
import '../../pages/single history trip details/single_history_trip_details.dart';
import '../text/kText.dart';

class CompleteTripHistory extends StatefulWidget {
  const CompleteTripHistory({super.key});

  @override
  State<CompleteTripHistory> createState() => _CompleteTripHistory();
}

class _CompleteTripHistory extends State<CompleteTripHistory> {
  final NewAllTripHistoryController _controller =
  Get.put(NewAllTripHistoryController());

  final int maxWordsToShow = 4;
  @override
  void initState() {
    super.initState();
    _controller.getCompleteTrip();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoading.value
        ? Center(
      child: loader(),
    )
        : _controller.allCompleteTripHistory.isEmpty
        ? EmptyBoxWidget(title: 'No Rental trip history available yet!', truckImage: 'assets/images/empty.png',)
        : ListView.builder(
      itemCount: _controller.allCompleteTripHistory.length,
      itemBuilder: (context, index) {
        final SortedTrips item = _controller.allCompleteTripHistory[index];

        String? pickUpCoordinates;
        String? downCoordinates;
        double upLat = 0.0, upLng = 0.0, downLat = 0.0, downLng = 0.0;
        if (item.rentalRelationships != null) {
          // Safely access pickUpCoordinates
          pickUpCoordinates = item.rentalRelationships?.trip?.map?.toString();

          // Check if dropoffLocations is not empty before accessing the last element
          if (item.rentalRelationships?.trip?.dropoffLocations?.isNotEmpty ?? false) {
            downCoordinates = item.rentalRelationships?.trip?.dropoffLocations?.last.dropoffMap.toString().replaceAll(',', ' ');
            log("${item.rentalRelationships?.trip?.dropoffLocations?.last.dropoffMap}");
          } else {
            downCoordinates = item
                .rentalRelationships?.trip?.dropoffMap
                .toString()
                .replaceAll(',', ' ');// Or handle this case as needed
          }
        } else {
          // Handle the case where rentalRelationships is null
          pickUpCoordinates = item.returnRelationships?.customerBidDetails?.map?.toString();

          // Check if returnTrip has dropoffLocations before accessing .last
          if (item.returnRelationships?.returnTrip?.dropoffLocations?.isNotEmpty ?? false) {
            String? modified = item.returnRelationships?.returnTrip?.dropoffLocations?.last.dropoffMap.toString().replaceAll(',', ' ');
            downCoordinates = modified;
          } else {
            downCoordinates = "No dropoff location available";  // Or handle this case
          }
        }

        if (pickUpCoordinates != null &&
            pickUpCoordinates.contains(' ')) {
          try {
            List<String> pickUpParts = pickUpCoordinates.split(' ');
            upLat = double.parse(pickUpParts[0]);
            upLng = double.parse(pickUpParts[1]);
          } catch (e) {
            print(
                "Error parsing pickup coordinates: $pickUpCoordinates");
          }
        }

        // Parse drop-off coordinates
        if (downCoordinates != null &&
            downCoordinates.contains(' ')) {
          try {
            List<String> downUpParts = downCoordinates.split(' ');
            downLat = double.parse(downUpParts[0]);
            downLng = double.parse(downUpParts[1]);
          } catch (e) {
            print(
                "Error parsing drop-off coordinates: $downCoordinates");
          }
        }

        return InkWell(
          onTap: () {
            Get.to(() => SingleHistoryTripDetailsPage(

              tripId: item.tripId.toString(),isComplete: true,
              isReturn: item.returnRelationships!=null?true:false,
 type:item.returnRelationships!=null? 'return':"normal",
            ));
          },
          child: Card(
            color: white,
            child: Column(
              children: [
                Padding(
                  padding: paddingH10V10,
                  child: Column(
                    children: [
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          KText(
                            text: item.rentalRelationships != null
                                ? "${item.rentalRelationships?.vehicle?.name}"
                                : "${item.returnRelationships?.returnVehicle?.name}",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ).box.p4.roundedSM.make(),
                        ],
                      ),
                      Row(
                        children: [
                          KText(text: "Trip: "),
                          KText(
                            text: item.trackingId.toString(),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          Spacer(),
                        ],
                      ),
                      20.heightBox,
                      Center(
                        child: CustomPaint(
                          painter: DrawDottedHorizontalLine(),
                        ),
                      ),
                      Container(
                        width: Get.width,
                        child: Padding(
                          padding: paddingV10,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Image.network(
                                Urls.getImageURL(
                                    endPoint: item
                                        .rentalRelationships !=
                                        null
                                        ? "${item.rentalRelationships?.vehicle?.image}"
                                        : "${item.returnRelationships?.returnVehicle?.image}"),
                                height: 70.h,
                                width: 70.w,
                              ),
                              5.widthBox,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/pick.png",
                                          scale: 20.h,
                                        ),
                                        SizedBox(
                                          width: 3.h,
                                        ),
                                        Expanded(
                                          child: Text(
                                            
                                                item.rentalRelationships !=
                                                    null
                                                    ? "${item.rentalRelationships?.trip?.pickupLocation}"
                                                    : "${item.returnRelationships?.returnTrip?.location}",

                                            maxLines: 4,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.h,
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    sizeH5,
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          12.h, 0, 10.h, 0),
                                      child: Container(
                                        height: 15,
                                        width: 1,
                                        color: grey,
                                      ),
                                    ),
                                    sizeH5,
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/map.png",
                                          scale: 20.h,
                                        ),
                                        SizedBox(
                                          width: 3.h,
                                        ),
                                        if (item.rentalRelationships !=
                                            null)
                                          for (var location in item
                                              .rentalRelationships!
                                              .trip!
                                              .dropoffLocations!)
                                            Text(
                                              "${location.dropoffLocation}, ",
                                              maxLines: 4,
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.h,
                                                fontWeight:
                                                FontWeight.w600,
                                              ),
                                            ).w(context.screenWidth/2.2),
                                        if (item.rentalRelationships?.trip?.dropoffLocation != null)
                                          "${item.rentalRelationships?.trip?.dropoffLocation}"
                                              .text
                                              .semiBold
                                              .make()
                                              .w(context.screenWidth /
                                              1.8),
                                        if (item.rentalRelationships ==
                                            null)
                                          Expanded(
                                            child: Text(

                                                  "${item.returnRelationships?.returnTrip?.destination}",

                                              maxLines: 4,
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.h,
                                                fontWeight:
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Column(
                              //    children: [
                              //      item.vehicle?.image != null ? Padding(
                              //          padding: EdgeInsets.all(4.0.h),
                              //          child: Image.network(
                              //            Urls.getImageURL(
                              //                endPoint: item
                              //                    .vehicle!.image
                              //                    .toString()),
                              //            scale: 1.5,
                              //          )):SizedBox(),
                              //      Text(
                              //        item.vehicle?.name ?? "N/A",
                              //        style: TextStyle(
                              //            fontWeight: FontWeight.bold),
                              //      )
                              //    ],
                              //  ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: CustomPaint(
                    painter: DrawDottedHorizontalLine(),
                  ),
                ),
                15.heightBox,
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0.h, 0, 15.h, 15.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          KText(
                            text: "Trip Time: ",
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          KText(
                            text: item.rentalRelationships != null
                                ? "${DateFormat("hh:mma dd-MM-yyyy").format(DateFormat("yyyy-MM-dd hh:mm a").parse("${item.rentalRelationships?.trip?.datetime}")).toLowerCase()}"
                                : "${item.returnRelationships?.returnTrip?.timedate}",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          Spacer(),

                        ],
                      ),
                      5.heightBox,
                      // Row(
                      //   children: [
                      //     KText(
                      //       text: "Round Trip: ",
                      //       fontSize: 13,
                      //       color: Colors.grey,
                      //     ),
                      //     KText(
                      //       text: item.rentalRelationships != null
                      //           ? item.rentalRelationships?.trip
                      //           ?.roundTrip ??
                      //           'NO'
                      //           : "NO",
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 14,
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),

                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      // "See Map"
                      //     .text
                      //     .semiBold.black
                      //     .make()
                      //     .box
                      //     .p4.shadowXs .white.gray50
                      //     .roundedSM
                      //     .make()
                      //     .onTap(() {
                      //   Get.to(
                      //         () => MapWithDirections(
                      //       pickUpLat: upLat,
                      //       pickUpLng: upLng,
                      //       dropUpLat: downLat,
                      //       dropUpLng: downLng,
                      //     ),
                      //   );
                      // }),
                      item.amount == null
                          ? Container()
                          : Text(
                        'Fare: ${item.amount.toString()} ৳',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                          .box
                          .p4
                          .color(primaryColor)
                          .roundedSM
                          .make()
                    ],
                  ).pSymmetric(h: 5),
                15.heightBox,
              ],
            ),
          ),
        );
      },
    ));
  }

  // String truncateTextIfNeeded(String text, int maxWords) {
  //   if (text.isEmpty) {
  //     return "N/A";
  //   }
  //
  //   List<String> words = text.split(RegExp(r'\s+'));
  //   int wordCount = words.length;
  //
  //   return wordCount > maxWords ? '${words.take(maxWords).join(" ")}...' : text;
  // }
}