import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/empty_box_widget.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/cancel%20Controller/cancel_controller.dart';
import 'package:pickup_load_update/src/controllers/live%20bidding%20controller/live_bidding_controller.dart';
import 'package:pickup_load_update/src/controllers/rental%20trip%20request%20controllers/rental_trip_req_submit_controller.dart';
import 'package:pickup_load_update/src/controllers/single%20trip%20details%20controller/single_trip_details_controller.dart';
import 'package:pickup_load_update/src/controllers/truck/truck_controller.dart';
import 'package:pickup_load_update/src/models/live_bidding_model.dart';
import 'package:pickup_load_update/src/pages/live%20bidding/trip_wise_bid_list.dart';
import 'package:pickup_load_update/src/pages/splash%20page/splash_page.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/car_live_bidding_widget.dart';
import 'package:pickup_load_update/src/widgets/divider_widget.dart';
import 'package:pickup_load_update/src/widgets/slider/slider_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/bottom navbar/bottom.dart';
import '../../controllers/rental trip request controllers/rental_trip_bid_confirm_controller.dart';
import 'bidding_confirm_screen.dart';

class LiveBiddingPageTruck extends StatefulWidget {
  final String createdAt;
  final String id;

  const LiveBiddingPageTruck({Key? key, required this.createdAt, required this.id}) : super(key: key);

  @override
  State<LiveBiddingPageTruck> createState() => _LiveBiddingPageTruckState();
}

class _LiveBiddingPageTruckState extends State<LiveBiddingPageTruck>
    with TickerProviderStateMixin {
  final pric=TextEditingController();
  var box=GetStorage();
  AnimationController? _controller;
  bool determinate = false;
  final CancelController cancelController = Get.put(CancelController());
  final TruckController truckController=Get.find();
  int? selectedCarIndex;
  bool _timerRunning = false;
  DateTime _startTime = DateTime.now();
  Duration _remainingTime = const Duration(hours: 1);

  late StreamController<Duration> _timerStreamController;
  late Timer _timer;

  final LiveBiddingController liveBiddingController =
  Get.put(LiveBiddingController());
  final RentalTripSubmitController _rentalTripSubmitController =
  Get.put(RentalTripSubmitController());

  @override
  void initState() {
    super.initState();

    log(widget.id);

    // Initialize the remaining time based on a 1-hour countdown
    _remainingTime = Duration(hours: 1) -
        DateTime.now().difference(DateTime.parse(widget.createdAt));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {});
    });
    _controller!.repeat();

    _timerStreamController = StreamController<Duration>();

    _loadStartTime();
    _startDataRefreshTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isEmpty = liveBiddingController.filteredLiveBidDataTruck.isEmpty;

      box.write("liveBidTruckStart", !isEmpty);
      _rentalTripSubmitController.liveBidTruckStart.value = !isEmpty;
    });
  }

  void _loadStartTime() async {
    final prefs = await SharedPreferences.getInstance();
    final storedStartTime = prefs.getInt('timer_start_time');

    if (storedStartTime != null) {
      _startTime = DateTime.fromMillisecondsSinceEpoch(storedStartTime);
    } else {
      _startTime = DateTime.now();
      await prefs.setInt('timer_start_time', _startTime.millisecondsSinceEpoch);
    }

    final elapsed = DateTime.now().difference(_startTime);
    final totalDuration = const Duration(hours: 1);
    _remainingTime = totalDuration - elapsed;

    if (_remainingTime.isNegative) {
      _remainingTime = Duration.zero;
    }

    _timerStreamController.add(_remainingTime);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingTime.inSeconds > 0) {
        _remainingTime -= const Duration(seconds: 1);
        _timerStreamController.add(_remainingTime);
      } else {
        _timer.cancel();
        _timerStreamController.add(Duration.zero);

        // Optional: actions when time ends
        // box.write("liveBidStart", false);
        // _rentalTripSubmitController.liveBidStart.value = false;
        // _callAPIAfterOneHour();
      }
    });
  }
  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_remainingTime > Duration.zero) {
          _remainingTime -= Duration(seconds: 1);
        } else {
          _rentalTripSubmitController.liveBidTruckStart.value=false;

          box.write("liveBidTruckStart", false);

          _timer.cancel();
          _timerStreamController.add(Duration.zero);
        }
      });
      _timerStreamController.add(_remainingTime);
    });
  }


  void _startDataRefreshTimer() {
    if (!_timerRunning) {
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        liveBiddingController.getLiveBid();
      });
      _timerRunning = true;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer.cancel();
    _timerStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = liveBiddingController.isLoading;
    final filteredList = liveBiddingController.filteredLiveBidDataTruck;
    return PopScope(
      canPop: false, // prevent default pop
      onPopInvoked: (didPop) {
        if (!didPop) {
          // Navigate back to dashboard
          Get.offAll(()=>DashboardView());
        }
      },
      child: Scaffold(

        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: (){
                Get.offAll(()=>DashboardView());
              },
              child: Icon(Icons.arrow_back)),
          title: Text(
            "liveBidding".tr,
            style: TextStyle(color: Colors.white, fontSize: 17.h),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<Duration>(
                stream: _timerStreamController.stream,
                initialData: _remainingTime,
                builder: (context, snapshot) {
                  final remainingTime = snapshot.data!;
                  return Text(
                    remainingTime > Duration.zero
                        ? _formatDuration(remainingTime)
                        : "Time's up",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  minHeight: 10,
                  backgroundColor: primaryColor50,
                  value: _controller!.value,
                ),
                20.heightBox,
                Obx(() {
                  final list = filteredList;

                  if (isLoading.value) {
                    return loader();
                  } else if (list.isEmpty) {
                    // Safe zone outside reactive logic
                    Future.microtask(() {
                      box.write("liveBidTruckStart", false);
                      _rentalTripSubmitController.liveBidTruckStart.value = false;
                    });

                    return EmptyBoxWidget(
                      title: "noLiveMessage".tr,
                      truckImage: 'assets/images/pickup-truck-svgrepo-com.png',
                    );
                  } else {
                    Future.microtask(() {
                      box.write("liveBidTruckStart", true);
                      _rentalTripSubmitController.liveBidTruckStart.value = true;
                    });

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        final TripList data = list[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => TripWiseBidList(
                                data: data.tripBids ?? [],
                                amount: data.amount.toString(),
                                id: data.id.toString()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CarLiveBiddingContainerWidget(
                              pickup: data.pickupLocation ?? '',
                              dropoff: data.dropoffLocation ?? '',
                              dropoffs: data.dropoffLocations ?? [],
                              amount: 'Fare:${data.amount?.toString() ?? '0'}TK         ${data.trackingId}',
                            ),
                          ),
                        );
                      },
                    ).h(context.screenHeight / 1.5);
                  }
                })
                // if (selectedCarIndex == null&&truckController.price.value == "Bid")
                //   SizedBox(height: context.screenHeight*0.17,),
                //
                // if (selectedCarIndex == null)
                //   Obx(
                //     () => Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         20.heightBox,
                //         Container(
                //           width: 150,
                //           child: primaryButton(
                //               icon: Icons.arrow_circle_right_outlined,
                //               buttonName: 'Cancel'.tr,
                //               onTap: () {
                //                 cancelTripRequestReason(
                //                   context,
                //                   widget.id.toString(),
                //                 );
                //               }),
                //         ),
                //         if (truckController.price.value != "Bid") 40.heightBox,
                //         if (truckController.price.value != "Bid")
                //           KText(text: 'addmoremoney'),
                //         if (truckController.price.value != "Bid")
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               KText(text: "total"),
                //               5.widthBox,
                //               "${truckController.totalPrice}৳"
                //                   .text
                //                   .semiBold
                //                   .lg
                //                   .make()
                //             ],
                //           ).paddingSymmetric(horizontal: 20),
                //         if (truckController.price.value != "Bid") 10.heightBox,
                //         if (truckController.price.value != "Bid")
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: [
                //               Container(
                //                 width: MediaQuery.of(context).size.width / 2,
                //                 height: 50,
                //                 child: TextField(
                //                   controller: pric,
                //                   keyboardType: TextInputType.number,
                //                   decoration: InputDecoration(
                //                     labelText: 'Enter Amount',
                //                     border: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(15),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                     backgroundColor: primaryColor),
                //                 onPressed: () {
                //                   // Close the modal when Submit is clicked
                //                   truckController
                //                       .sendExtraMoney(
                //                           tripId: widget.id,
                //                           extendedAmount: pric.text)
                //                       .then((value) => {pric.clear()});
                //                 },
                //                 child: "Submit".text.white.make(),
                //               ),
                //             ],
                //           ),
                //         50.heightBox,
                //         DividerWidget(title: 'Ongoing Offer'.tr),
                //         20.heightBox,
                //         SliderWidget().h(120),
                //       ],
                //     ),
                //   ),
                //
                // if (selectedCarIndex != null)
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       SizedBox(
                //         width: context.screenWidth / 2.2,
                //         child: primaryButton(
                //           icon: Icons.arrow_circle_right_outlined,
                //           buttonName: 'Continue',
                //           onTap: () async {
                //             if (selectedCarIndex != null &&
                //                 selectedCarIndex! <
                //                     liveBiddingController.liveBidData.length) {
                //               final TripList selectedBidData =
                //                   liveBiddingController
                //                       .liveBidData[selectedCarIndex!];
                //
                //               final ReturnBidConfirmController confirmController =
                //                   ReturnBidConfirmController();
                //
                //               await confirmController.bidConfirm(
                //                 bidId: selectedBidData.id.toString(),
                //                 tripId: "selectedBidData.tripId.toString()",
                //               );
                //
                //               if (confirmController
                //                       .bidConfirmModel.value.status ==
                //                   "success") {
                //                 _rentalTripSubmitController.liveBidTruckStart.value=false;
                //                 Get.to(() => LiveBiddingConfirmScreen(
                //                   rentalBidConfirm: confirmController
                //                       .bidConfirmModel.value.data!,
                //                 ));;
                //               }
                //             }
                //           },
                //         ),
                //       ),
                //       SizedBox(
                //         width: context.screenWidth / 2.2,
                //         child: primaryButton(
                //             icon: Icons.arrow_circle_right_outlined,
                //             buttonName: 'cancel'.tr,
                //             onTap: () {
                //               cancelTripRequestReason(
                //                 context,
                //                 widget.id.toString(),
                //               );
                //             }),
                //       )
                //     ],
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return '$hours hrs $minutes min $seconds sec';
  }

  var isOther = false;

  void cancelTripRequestReason(BuildContext context, String tripId) {
    isOther = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          // This allows us to call setState inside the modal
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Cancel trip?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Why do you want to cancel?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                    liveBiddingController.beforeCancelList.length,
                    itemBuilder: (context, index) {
                      var item =
                      liveBiddingController.beforeCancelList[index];
                      return ListTile(
                        leading: Icon(Icons.no_crash),
                        title: Text(item.title.toString()),
                        onTap: () {
                          if (item.id == 14) {
                            // Update the state to show the "Other" input
                            setModalState(() {
                              isOther = true;
                            });
                          } else {
                            cancelController.sendBeforeCancel(
                                tripId, item.id.toString());
                          }
                        },
                      );
                    },
                  ),
                  if (isOther)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter text',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Close the modal when Submit is clicked
                            cancelController.sendBeforeCancel(tripId, '14');
                          },
                          child: Text("Submit"),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Keep my trip"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
