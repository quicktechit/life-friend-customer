import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/date_format.dart';
import 'package:pickup_load_update/src/configs/empty_box_widget.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/trip%20history%20controller/return_trip_history_controller.dart';
import 'package:pickup_load_update/src/models/return_history_model.dart';
import 'package:pickup_load_update/src/pages/home/rental/tripHistoryPage.dart';
import 'package:pickup_load_update/src/pages/single%20history%20trip%20details/single_return_trip_history_details.dart';
import 'package:pickup_load_update/src/widgets/history_time_widget.dart';
import 'package:pickup_load_update/src/widgets/status_widget.dart';

class ReturnTripHistory extends StatefulWidget {
  ReturnTripHistory({super.key});

  @override
  State<ReturnTripHistory> createState() => _ReturnTripHistoryState();
}

class _ReturnTripHistoryState extends State<ReturnTripHistory> {
  final ReturnHistoryController _controller =
      Get.put(ReturnHistoryController());

 final int maxWordsToShow = 4;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getReturnHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoading.value
        ? Center(
            child: loader(),
          )
        : _controller.returnData.isEmpty
            ? EmptyBoxWidget(title: 'No Return Truck trip history available yet!', truckImage: 'assets/images/pickup-truck-svgrepo-com.png',)
            : ListView.builder(
                itemCount: _controller.returnData.length,
                itemBuilder: (context, index) {
                  final ReturnData item = _controller.returnData[index];
                  return InkWell(
                    onTap: (){
                      Get.to(() => SingleReturnHistoryTripDetailsPage(
                        tripId: item.id.toString(),
                      ));
                      print("Trip ID============================${item.id.toString()}");

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
                                          item.createdAt.toString()),
                                    ),
                                    SizedBox(
                                      width: 80.h,
                                    ),

                                    StatusWidget(
                                      icon: item.isConfirm == 0 && item.isBiding == 1
                                          ? Icons.car_crash_rounded
                                          : item.isConfirm == 0 && item.isBiding == 0
                                          ? Icons.cancel_outlined
                                          : Icons.car_crash_rounded,
                                      statusTitle:  item.isConfirm == 0 && item.isBiding == 1
                                          ? "Ongoing/Hold"
                                          : item.isConfirm == 0 && item.isBiding == 0
                                          ? "CANCELLED"
                                          : "CONFIRMED",
                                      textColor: item.isConfirm == 1 && item.isBiding == 0
                                          ? Colors.green
                                          : Colors.red,
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
                                                              "",
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
                                                              "",
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
                                                      endPoint: item
                                                          .getvehicle!.image
                                                          .toString()),
                                                  scale: 1,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              item.getvehicle?.name ?? "N/A",
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
                                Text(
                                  'Journey OTP',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                Text(
                                  item.otp == 1 ? "Submitted" : item.otp.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
    if (text.isEmpty) {
      return "N/A";
    }

    List<String> words = text.split(RegExp(r'\s+'));
    int wordCount = words.length;

    return wordCount > maxWords ? '${words.take(maxWords).join(" ")}...' : text;
  }
}
