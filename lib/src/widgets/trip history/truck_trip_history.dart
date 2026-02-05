// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/empty_box_widget.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/models/rental_trip_history_model.dart';
import 'package:pickup_load_update/src/pages/home/rental/rentalListPage.dart';
import 'package:pickup_load_update/src/pages/home/rental/tripHistoryPage.dart';
import 'package:pickup_load_update/src/pages/live%20bidding/live_bidding_page.dart';
import 'package:pickup_load_update/src/pages/single%20history%20trip%20details/single_history_trip_details.dart';
import 'package:pickup_load_update/src/widgets/history_time_widget.dart';
import 'package:pickup_load_update/src/widgets/status_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/trip history controller/truck_trip_history_controller.dart';

class TruckTripTripHistory extends StatefulWidget {
  TruckTripTripHistory({super.key});

  @override
  State<TruckTripTripHistory> createState() => _TruckTripTripHistoryState();
}

class _TruckTripTripHistoryState extends State<TruckTripTripHistory> {
  final TruckTripHistoryController _controller =
  Get.put(TruckTripHistoryController());

  final int maxWordsToShow = 4;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getTruckTrip();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoading.value
        ? Center(
      child: loader(),
    )
        : _controller.rentalTripHistory.isEmpty
            ? EmptyBoxWidget(
                title: 'No Truck trip history available yet!',
                truckImage: 'assets/images/pickup-truck-svgrepo-com.png',
              )
            : ListView.builder(
      itemCount: _controller.rentalTripHistory.length,
      itemBuilder: (context, index) {
        final Data item = _controller.rentalTripHistory[index];
        return InkWell(
          onTap: () {
            Get.to(() => SingleHistoryTripDetailsPage(
              tripId: item.id.toString(), type: '',
            ));
          },
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: paddingH10V10,
                  child: Column(
                    children: [
                      sizeH20,
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          HistoryTimeWidget(
                            date: item.datetime.toString(),
                          ),
                          SizedBox(width: 10.h),
                          StatusWidget(
                            icon: item.status == 0
                                ? Icons.cancel_outlined
                                : Icons.car_crash_rounded,
                            statusTitle: item.status == 0
                                ? item.biding == 1
                                ? "ONGOING"
                                : "CANCELED"
                                : "CONFIRM",
                            textColor: item.status == 0
                                ? item.biding == 1
                                ? Colors.black
                                : Colors.red
                                : Colors.green,
                          ),
                          SizedBox(width: 10.h),

                          item.status == 0 && item.biding == 1
                              ? GestureDetector(
                            onTap: (){
                                              Get.to(() => LiveBiddingPage(
                                                    createdAt: item.createdAt
                                                        .toString(),
                                                    type: 'truck',
                                                  ));
                                            },
                            child: Row(
                              children: [
                                Text("Live Bid"),
                                Image.asset(
                                  "assets/images/live.jpg",
                                  width: 60,
                                ),

                              ],
                            ),
                          )
                              : Container(),
                          Spacer(),
                        ],
                      ),
                      sizeH10,
                      Divider(),
                      Container(
                        width: Get.width,
                        color: white,
                        child: Padding(
                          padding: paddingH10V20,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
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
                                            truncateTextIfNeeded(
                                                item.pickupLocation ??
                                                    "",
                                                maxWordsToShow),
                                            maxLines: 1,
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 13,
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
                                                  Column(
                                                    children: [
                                                      for (var location in item
                                                          .dropoffLocations!
                                                          .toList())
                                                        "${location.dropoffLocation}"
                                                            .text.semiBold
                                                            .overflow(
                                                                TextOverflow
                                                                    .ellipsis)
                                                            .make()
                                                    ],
                                                  ).w(context.screenWidth/1.95)
                                                ],
                                              ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  item.vehicle?.image != null ? Padding(
                                    padding: EdgeInsets.all(4.0.h),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        Urls.getImageURL(
                                            endPoint: item
                                                .vehicle!.image
                                                .toString()),
                                        scale: 1,
                                      ),
                                    ),
                                  ):SizedBox(),
                                  Text(
                                    item.vehicle?.name ?? "N/A",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15.0.h, 0, 15.h, 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => RentalListPage(tripType: 'truck',isTrac: true,));
                        },
                        child: Text(
                          'Send Request Again',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor.withOpacity(0.8)),
                        ),
                      ),
                      item.amount == null
                          ? Container()
                          : Text(
                        'Fare: ${item.amount.toString()} ৳',
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Center(
                  child: CustomPaint(
                    painter: DrawDottedHorizontalLine(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  String truncateTextIfNeeded(String text, int maxWords) {
    if (text == null || text.isEmpty) {
      return "N/A";
    }

    List<String> words = text.split(RegExp(r'\s+'));
    int wordCount = words.length;

    return wordCount > maxWords ? '${words.take(maxWords).join(" ")}...' : text;
  }
}
