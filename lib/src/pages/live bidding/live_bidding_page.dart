
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pickup_load_update/src/components/bottom%20navbar/bottom.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/empty_box_widget.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/cancel%20Controller/cancel_controller.dart';
import 'package:pickup_load_update/src/controllers/live%20bidding%20controller/live_bidding_controller.dart';
import 'package:pickup_load_update/src/controllers/rental%20trip%20request%20controllers/rental_trip_req_submit_controller.dart';
import 'package:pickup_load_update/src/controllers/single%20trip%20details%20controller/single_trip_details_controller.dart';
import 'package:pickup_load_update/src/models/live_bidding_model.dart';
import 'package:pickup_load_update/src/pages/car%20details%20page/car_details_page.dart';
import 'package:pickup_load_update/src/pages/splash%20page/splash_page.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/car_live_bidding_widget.dart';
import 'package:pickup_load_update/src/widgets/divider_widget.dart';
import 'package:pickup_load_update/src/widgets/slider/slider_widget.dart';
import '../../controllers/rental trip request controllers/rental_trip_bid_confirm_controller.dart';
import 'bidding_confirm_screen.dart';

class LiveBiddingPage extends StatefulWidget {
  final String createdAt;
  final String type;

  const LiveBiddingPage({Key? key, required this.createdAt, required this.type})
      : super(key: key);

  @override
  State<LiveBiddingPage> createState() => _LiveBiddingPageState();
}

class _LiveBiddingPageState extends State<LiveBiddingPage>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  bool determinate = false;
  final CancelController cancelController = Get.put(CancelController());
  int? selectedCarIndex;
  var box=GetStorage();
  bool _timerRunning = false;
  Duration _remainingTime = const Duration(hours: 1);

  late StreamController<Duration> _timerStreamController;
  late Timer _timer;

  final LiveBiddingController liveBiddingController =
  Get.put(LiveBiddingController());
  final SingleTripDetailsController _singleTripC =
  Get.put(SingleTripDetailsController());
  final RentalTripSubmitController _rentalTripSubmitController =
  Get.put(RentalTripSubmitController());

  @override
  void initState() {
    super.initState();

    // Initialize the remaining time based on a 1-hour countdown
    _remainingTime = Duration(hours: 1) -
        DateTime.now().difference(DateTime.parse(widget.createdAt));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
      setState(() {});
    });
    _controller!.repeat();

    _startDataRefreshTimer();

    _timerStreamController = StreamController<Duration>();
    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_remainingTime > Duration.zero) {
          _remainingTime -= Duration(seconds: 1);
        } else {
          _rentalTripSubmitController.liveBidStart.value=false;

          box.write("liveBidStart", false);

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  minHeight: 10,
                  backgroundColor: primaryColor50,
                  value: _controller!.value,
                ),
                SizedBox(
                  height: 320,
                  child: Obx(() {
                    if (liveBiddingController.isLoading.value) {
                      return loader();
                    } else if (liveBiddingController.filteredLiveBidData.first.tripBids!.isEmpty||liveBiddingController.filteredLiveBidData.first.tripBids==[]) {
                      return EmptyBoxWidget(
                        title: "noLiveMessage".tr,
                        truckImage: widget.type == "Bike"
                            ? "assets/images/motorcycle.png"
                            : 'assets/images/empty.png',
                      );
                    } else {
                      return ListView.builder(
                        itemCount: liveBiddingController.filteredLiveBidData.first.tripBids?.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isSelected = selectedCarIndex == index;

                          var data =
                          liveBiddingController.filteredLiveBidData.first.tripBids?[index];

                          return GestureDetector(
                            onTap: () {
                              _singleTripC
                                  .singleTripDetails("${data?.tripId.toString()}",'normal');
                              setState(() {
                                selectedCarIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: isSelected
                                    ? Border.all(
                                  color: Colors.green,
                                  width: 1.5,
                                )
                                    : null,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CarLiveBiddingContainerWidget2(
                                  img: Urls.getImageURL(
                                      endPoint:
                                      data?.getBrand?.image?.toString() ?? ''),
                                  carName: data?.getBrand?.name?.toString() ??
                                      data?.getvehicle?.model ??
                                      '',
                                  capacity:
                                  '${data?.getBrand?.capacity?.toString() ?? ''} Seats Capacity',
                                  rating: '',
                                  fare:
                                  'Fare: ${data?.amount?.toString() ?? '0'} TK',
                                  carNumber:
                                  '${data?.getvehicle?.metro?.toString() ?? ''}\n${data?.getvehicle?.metroNo?.toString() ?? ''}',
                                  onTap: () {
                                    Get.to(() => CarDetailsPage(
                                      tripId: data?.tripId?.toString() ?? '',
                                      bidId: data?.id?.toString() ?? '',
                                    ));
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
                if (selectedCarIndex == null)
                  Column(
                    children: [
                      Container(
                        width: 150,
                        color: Colors.white,
                        child: primaryButton(
                            icon: Icons.arrow_circle_right_outlined,
                            buttonName: 'Cancel'.tr,
                            onTap: () {
                              cancelTripRequestReason(
                                context,
                                box.read("ID").toString(),
                              );
                            }),
                      ),
                      20.heightBox,
                      DividerWidget(title: 'Ongoing Offer'.tr),
                      SizedBox(height: 20.h),
                      SliderWidget(),
                    ],
                  ),
                SizedBox(height: 67),
                if (selectedCarIndex != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: context.screenWidth/2.2,
                        child:    primaryButton(

                          icon: Icons.arrow_circle_right_outlined,
                          buttonName: 'Continue',
                          onTap: () async {
                            if (selectedCarIndex != null &&
                                selectedCarIndex! <
                                    liveBiddingController.filteredLiveBidData.length) {
                              var selectedBidData =
                              liveBiddingController.filteredLiveBidData.first.tripBids?[selectedCarIndex!];

                              final ReturnBidConfirmController confirmController =
                              ReturnBidConfirmController();

                              await confirmController.bidConfirm(
                                bidId: selectedBidData?.id.toString(),
                                tripId: selectedBidData?.tripId.toString(),
                              );

                              if (confirmController
                                  .bidConfirmModel.value.status ==
                                  "success") {
                                _rentalTripSubmitController.liveBidStart.value=false;


                                Get.to(() => LiveBiddingConfirmScreen(
                                  rentalBidConfirm: confirmController
                                      .bidConfirmModel.value.data!,
                                ));
                              }
                            }
                          },
                        ),
                      ),

                      SizedBox(width: context.screenWidth/2.2,
                        child: primaryButton(
                            icon: Icons.arrow_circle_right_outlined,
                            buttonName: 'Cancel'.tr,
                            onTap: () {}),
                      ),
                      // Column(
                      //   children: [
                      //
                      //     20.heightBox,
                      //     DividerWidget(title: "onGoingOffer".tr),
                      //     SizedBox(height: 20.h),
                      //     SliderWidget(),
                      //   ],
                      // ),
                    ],
                  ),
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
                  // Show the text input if "Other" was selected
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
