import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/date_format.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/models/rental_trip_history_model.dart';
import 'package:pickup_load_update/src/pages/home/rental/rentalListPage.dart';
import 'package:pickup_load_update/src/pages/single%20history%20trip%20details/single_history_trip_details.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/history_time_widget.dart';
import 'package:pickup_load_update/src/widgets/rental_trip_title.dart';
import 'package:pickup_load_update/src/widgets/status_widget.dart';

import '../../../controllers/trip history controller/rental_trip_history_controller.dart';


class TripHistoryPage extends StatelessWidget {
  final RentalTripHistoryController _controller =
  Get.put(RentalTripHistoryController());

  final int maxWordsToShow = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              CustomAppBar(appbarTitle: ''),
              Padding(
                padding: paddingH20,
                child: Row(
                  children: [
                    RentalTripTitle(
                        title: "Trip History",
                        subTitle: "Your Awesome Trip History")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() => _controller.isLoading.value
          ? Center(
        child: loader(),
      )
          : ListView.builder(
        itemCount: _controller.rentalTripHistory.length,
        itemBuilder: (context, index) {
          final Data item = _controller.rentalTripHistory[index];

          return InkWell(
            onTap: () {
              Get.to(() => SingleHistoryTripDetailsPage(
                tripId: item.id.toString(), type: 'normal',
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
                              date: formatDateTime(
                                  item.createdAt?.toString() ?? ''),
                            ),
                            SizedBox(
                              width: 80.h,
                            ),
                            StatusWidget(
                              icon: item.status == 0
                                  ? Icons.cancel_outlined
                                  : Icons.car_crash_rounded,
                              statusTitle: item.status == 0
                                  ? "CANCELLED"
                                  : "CONFIRM",
                              textColor: item.status == 0
                                  ? Colors.red
                                  : Colors.green,
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                                      "N/A",
                                                  maxWordsToShow),
                                              maxLines: 1,
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
                                          Expanded(
                                            child: Text(
                                              truncateTextIfNeeded(
                                                  item.dropoffLocation ??
                                                      "N/A",
                                                  maxWordsToShow),
                                              maxLines: 1,
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
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(4.0.h),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black,
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                          Urls.getImageURL(
                                              endPoint: item.vehicle
                                                  ?.image
                                                  ?.toString() ??
                                                  ""),
                                          scale: 1,
                                        ),
                                      ),
                                    ),
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
                            Get.to(() => RentalListPage(tripType: 'car',));
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
      )),
    );
  }

  String truncateTextIfNeeded(String? text, int maxWords) {
    if (text == null || text.isEmpty) {
      return "N/A";
    }

    List<String> words = text.split(RegExp(r'\s+'));
    return words.length > maxWords ? '${words.take(maxWords).join(" ")}...' : text;
  }
}

class DrawDottedHorizontalLine extends CustomPainter {
  late Paint _paint;
  DrawDottedHorizontalLine() {
    _paint = Paint()
      ..color = grey.shade300
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.square;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 15) {
      if (i % 3 == 0) canvas.drawLine(Offset(i, 0.0), Offset(i + 3, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
