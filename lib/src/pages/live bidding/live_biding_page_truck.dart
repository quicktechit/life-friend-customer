import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/empty_box_widget.dart';
import 'package:pickup_load_update/src/controllers/cancel%20Controller/cancel_controller.dart';
import 'package:pickup_load_update/src/controllers/live%20bidding%20controller/live_bidding_controller.dart';
import 'package:pickup_load_update/src/controllers/rental%20trip%20request%20controllers/rental_trip_req_submit_controller.dart';
import 'package:pickup_load_update/src/controllers/truck/truck_controller.dart';
import 'package:pickup_load_update/src/models/live_bidding_model.dart';
import 'package:pickup_load_update/src/pages/live%20bidding/trip_wise_bid_list.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/slider/slider_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../components/bottom navbar/bottom.dart';


class LiveBiddingPageTruck extends StatefulWidget {
  final String createdAt;
  final String id;

  const LiveBiddingPageTruck({
    super.key,
    required this.createdAt,
    required this.id,
  });

  @override
  State<LiveBiddingPageTruck> createState() => _LiveBiddingPageTruckState();
}

class _LiveBiddingPageTruckState extends State<LiveBiddingPageTruck>
    with TickerProviderStateMixin {
  final pric = TextEditingController();
  var box = GetStorage();
  AnimationController? _controller;
  bool determinate = false;
  final CancelController cancelController = Get.put(CancelController());
  final TruckController truckController = Get.find();
  int? selectedCarIndex;
  bool _timerRunning = false;
  DateTime _startTime = DateTime.now();
  Duration _remainingTime = const Duration(hours: 1);

  late StreamController<Duration> _timerStreamController;
  late Timer _timer;

  final LiveBiddingController liveBiddingController = Get.put(
    LiveBiddingController(),
  );
  final RentalTripSubmitController _rentalTripSubmitController = Get.put(
    RentalTripSubmitController(),
  );

  @override
  void initState() {
    super.initState();

    log(widget.id);

    // Initialize the remaining time based on a 1-hour countdown
    _remainingTime =
        Duration(hours: 1) -
        DateTime.now().difference(DateTime.parse(widget.createdAt));

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });
    _controller!.repeat();

    _timerStreamController = StreamController<Duration>();

    _loadStartTime();
    _startDataRefreshTimer();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   bool isEmpty = liveBiddingController.filteredLiveBidDataTruck.isEmpty?true:false;
    //
    //   box.write("liveBidTruckStart", !isEmpty);
    //   _rentalTripSubmitController.liveBidTruckStart.value = !isEmpty;
    // });
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
      }
    });
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_remainingTime > Duration.zero) {
          _remainingTime -= Duration(seconds: 1);
        } else {
          _rentalTripSubmitController.liveBidTruckStart.value = false;

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
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Get.offAll(() => DashboardView());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.offAll(() => DashboardView());
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            "liveBidding".tr,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(50),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withAlpha(80),
                  width: 1,
                ),
              ),
              child: StreamBuilder<Duration>(
                stream: _timerStreamController.stream,
                initialData: _remainingTime,
                builder: (context, snapshot) {
                  final remainingTime = snapshot.data!;
                  return Row(
                    children: [
                      Icon(Icons.timer, color: Colors.white, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        remainingTime > Duration.zero
                            ? _formatDuration(remainingTime)
                            : "Time's up",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Animated Progress Bar
            SizedBox(
              height: 4,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                backgroundColor: primaryColor.withAlpha(50),
                value: _controller!.value,
              ),
            ),

            // Live Bidding Status Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withAlpha(50),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.circle, color: Colors.red, size: 10),
                        const SizedBox(width: 6),
                        Text(
                          "LIVE",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Truck Bidding in progress... Select your preferred trip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                margin: const EdgeInsets.all(5),
                padding:  const EdgeInsets.all(5),

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Truck Trip List Section
                      Obx(() {
                        final list = filteredList;

                        if (isLoading.value) {
                          return SizedBox(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  primaryColor,
                                ),
                              ),
                            ),
                          );
                        } else if (list.isEmpty) {
                          // Safe zone outside reactive logic
                          // Future.microtask(() {
                          //   box.write("liveBidTruckStart", false);
                          //   _rentalTripSubmitController
                          //       .liveBidTruckStart.value = false;
                          // });

                          return Container(
                            padding: const EdgeInsets.all(32),
                            child: EmptyBoxWidget(
                              title: "noLiveMessage".tr,
                              truckImage:
                                  'assets/images/pickup-truck-svgrepo-com.png',
                            ),
                          );
                        } else {
                          // Future.microtask(() {
                          //   box.write("liveBidTruckStart", true);
                          //   _rentalTripSubmitController
                          //       .liveBidTruckStart.value = true;
                          // });

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              final TripList data = list[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => TripWiseBidList(
                                      data: data.tripBids ?? [],
                                      amount: data.amount.toString(),
                                      id: data.id.toString(),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.grey.withAlpha(30),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(10),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Tracking ID
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: primaryColor
                                                    .withAlpha(30),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      8,
                                                    ),
                                                border: Border.all(
                                                  color: primaryColor
                                                      .withAlpha(50),
                                                ),
                                              ),
                                              child: Text(
                                                data.trackingId ?? '',
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            // Price Tag
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8,
                                                  ),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    primaryColor,
                                                    primaryColor.withRed(
                                                      200,
                                                    ),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      20,
                                                    ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: primaryColor
                                                        .withAlpha(80),
                                                    blurRadius: 10,
                                                    spreadRadius: 1,
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                '৳${data.amount?.toString() ?? '0'}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),

                                        // Pickup Location
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: primaryColor
                                                    .withAlpha(30),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.location_on,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    'Pickup Location',
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey[600],
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    data.pickupLocation ??
                                                        '',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),

                                        // Dropoff Location
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.green
                                                    .withAlpha(30),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.location_on,
                                                color: Colors.green,
                                                size: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    'Dropoff Location',
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey[600],
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    data.dropoffLocation ??
                                                        '',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                  if (data.dropoffLocations !=
                                                          null &&
                                                      data
                                                          .dropoffLocations!
                                                          .isNotEmpty)
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          'Additional Dropoffs:',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                        ...data
                                                            .dropoffLocations!
                                                            .map(
                                                              (
                                                                location,
                                                              ) => Text(
                                                                '• $location',
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .grey[700],
                                                                  fontSize:
                                                                      12,
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),

                                        // View Bids Button
                                        Container(
                                          width: double.infinity,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: primaryColor
                                                  .withAlpha(80),
                                              width: 1,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withAlpha(10),
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Get.to(
                                                () => TripWiseBidList(
                                                  data: data.tripBids ?? [],
                                                  amount: data.amount
                                                      .toString(),
                                                  id: data.id.toString(),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shadowColor:
                                                  Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      12,
                                                    ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'View Bids',
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: primaryColor,
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }).card.rounded.white.make(),

                      const SizedBox(height: 24),

                      // Cancel Trip Button
                      primaryButton(
                        buttonName: "Cancel Trip",
                        onTap: () {
                          cancelTripRequestReason(
                            context,
                            widget.id.toString(),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // Extra Money Section (if applicable)
                      Obx(
                        () => truckController.price.value != "Bid"
                            ? Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Add More Money'.tr,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total".tr,
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            "${truckController.totalPrice}৳",
                                            style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: Colors.grey
                                                      .withAlpha(80),
                                                ),
                                              ),
                                              child: TextField(
                                                controller: pric,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintText: 'Enter Amount',
                                                  hintStyle: TextStyle(
                                                    color: Colors.grey[500],
                                                  ),
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 14,
                                                      ),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    primaryColor,
                                                    primaryColor.withRed(200),
                                                  ],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: primaryColor
                                                        .withAlpha(80),
                                                    blurRadius: 10,
                                                  ),
                                                ],
                                              ),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  truckController
                                                      .sendExtraMoney(
                                                        tripId: widget.id,
                                                        extendedAmount:
                                                            pric.text,
                                                      )
                                                      .then(
                                                        (value) =>
                                                            pric.clear(),
                                                      );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Submit".tr,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ).p12().card.rounded.white.make(),
                                  const SizedBox(height: 24),
                                ],
                              )
                            : const SizedBox(),
                      ),

                      // Offer Slider Section
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ongoing Offer'.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: primaryColor.withAlpha(50),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: primaryColor,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Best Price',
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SliderWidget(),
                          const SizedBox(height: 12),
                          Text(
                            'Adjust your bid to get the best deal',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ).p12().card.rounded.white.make(),

                      const SizedBox(height: 80), // Bottom padding
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  var isOther = false;

  void cancelTripRequestReason(BuildContext context, String tripId) {
    isOther = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Header
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cancel_outlined,
                          color: primaryColor,
                          size: 48,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Cancel Trip?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Please tell us why you want to cancel",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Reasons List
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.withAlpha(30)),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: liveBiddingController.beforeCancelList.length,
                      itemBuilder: (context, index) {
                        var item =
                            liveBiddingController.beforeCancelList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(30),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.info_outline,
                                color: primaryColor,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              item.title.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: primaryColor,
                              size: 16,
                            ),
                            onTap: () {
                              if (item.id == 14) {
                                setModalState(() {
                                  isOther = true;
                                });
                              } else {
                                cancelController.sendBeforeCancel(
                                  tripId,
                                  item.id.toString(),type: 't'
                                );
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  // Other Reason Input
                  if (isOther)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.withAlpha(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Please specify the reason",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            style: TextStyle(color: Colors.black),
                            maxLines: 3,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Type your reason here...",
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.withAlpha(80),
                                    ),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setModalState(() {
                                        isOther = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      "Back",
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        primaryColor,
                                        primaryColor.withRed(200),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryColor.withAlpha(80),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cancelController.sendBeforeCancel(
                                        tripId,
                                        '14',
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Keep Trip Button
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: primaryColor.withAlpha(80),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(10),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Keep My Trip",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
