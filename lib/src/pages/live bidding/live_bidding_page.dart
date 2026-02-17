
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

  const LiveBiddingPage({super.key, required this.createdAt, required this.type});

  @override
  State<LiveBiddingPage> createState() => _LiveBiddingPageState();
}

class _LiveBiddingPageState extends State<LiveBiddingPage>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  bool determinate = false;
  final CancelController cancelController = Get.put(CancelController());
  int? selectedCarIndex;
  var box = GetStorage();
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

  // Define color scheme
  final Color primaryRed =primaryColor; // Deep Red
  final Color darkRed =primaryColor.withRed(200);
  final Color lightRed = const Color(0xFFFFEBEE);
  final Color accentGold = const Color(0xFFFFD700);

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
          _rentalTripSubmitController.liveBidStart.value = false;
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
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Get.offAll(() => DashboardView());
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.offAll(() => DashboardView());
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            splashRadius: 20,
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
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: primaryRed.withAlpha(80),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
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
                backgroundColor: lightRed,
                value: _controller!.value,
              ),
            ),

            // Live Bidding Status Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryRed, primaryRed],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryRed.withAlpha(60),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 10,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "LIVE",
                          style: TextStyle(
                            color: darkRed,
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
                      "Bidding in progress... Select your preferred vehicle",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Vehicle List Section
                    Container(
                      decoration: BoxDecoration(
                        color: lightRed,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(60),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Obx(() {
                          if (liveBiddingController.isLoading.value) {
                            return SizedBox(
                              height: 300,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(primaryRed),
                                ),
                              ),
                            );
                          }

                          // ✅ FIRST CHECK THE MAIN LIST
                          if (liveBiddingController.filteredLiveBidData.isEmpty) {
                            return EmptyBoxWidget(
                              title: "noLiveMessage".tr,
                              truckImage: widget.type == "Bike"
                                  ? "assets/images/motorcycle.png"
                                  : 'assets/images/empty.png',
                            ).p12();
                          }

                          // ✅ SAFE ACCESS
                          final tripBids = liveBiddingController
                              .filteredLiveBidData.first.tripBids ??
                              [];

                          if (tripBids.isEmpty) {
                            return EmptyBoxWidget(
                              title: "noLiveMessage".tr,
                              truckImage: widget.type == "Bike"
                                  ? "assets/images/motorcycle.png"
                                  : 'assets/images/empty.png',
                            ).p12();
                          }
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: liveBiddingController
                                  .filteredLiveBidData.first.tripBids?.length,
                              itemBuilder: (BuildContext context, int index) {
                                final data = tripBids[index];
                                final isSelected = selectedCarIndex == index;

                                return GestureDetector(
                                  onTap: () {
                                    _singleTripC.singleTripDetails(
                                        data.tripId.toString(), 'normal');
                                    setState(() {
                                      selectedCarIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? darkRed.withAlpha(50)
                                          : lightRed,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isSelected
                                            ? primaryRed
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(50),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              // Vehicle Image
                                              Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  color: Colors.grey[900],
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      Urls.getImageURL(
                                                        endPoint: data.getBrand
                                                            ?.image
                                                            ?.toString() ??
                                                            '',
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),

                                              // Vehicle Details
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          data.getBrand?.name
                                                              ?.toString() ??
                                                              data.getvehicle
                                                                  ?.model ??
                                                              '',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                        ),
                                                        if (isSelected)
                                                          Icon(
                                                            Icons
                                                                .check_circle_rounded,
                                                            color: primaryRed,
                                                            size: 24,
                                                          ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      '${data.getBrand?.capacity?.toString() ?? ''} Seats Capacity',
                                                      style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                            horizontal: 8,
                                                            vertical: 4,
                                                          ),
                                                          decoration:
                                                          BoxDecoration(
                                                            color: darkRed
                                                                .withAlpha(
                                                                60),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                          ),
                                                          child: Text(
                                                            '${data.getvehicle?.metro?.toString() ?? ''} ${data.getvehicle?.metroNo?.toString() ?? ''}',
                                                            style: TextStyle(
                                                              color: primaryRed,
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Price Tag
                                        Positioned(
                                          right: 16,
                                          top: 16,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  primaryRed,
                                                  darkRed,
                                                ],
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                  primaryRed.withAlpha(80),
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              '৳${data.amount?.toString() ?? '0'}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // View Details Button
                                        Positioned(
                                          right: 16,
                                          bottom: 16,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(() => CarDetailsPage(
                                                tripId: data.tripId
                                                    ?.toString() ??
                                                    '',
                                                bidId:
                                                data.id?.toString() ??
                                                    '',
                                              ));
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.white
                                                      .withAlpha(60),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Details',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.black,
                                                    size: 12,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                        }),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Action Buttons Section
                    if (selectedCarIndex == null)
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryRed, darkRed],
                              ),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryRed.withAlpha(90),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                cancelTripRequestReason(
                                  context,
                                  box.read("ID").toString(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Cancel Trip'.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),

                    if (selectedCarIndex != null)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: lightRed,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(50),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Selected Vehicle',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [primaryRed, darkRed],
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryRed.withAlpha(80),
                                          blurRadius: 10,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (selectedCarIndex != null &&
                                            selectedCarIndex! <
                                                liveBiddingController
                                                    .filteredLiveBidData
                                                    .length) {
                                          var selectedBidData =
                                          liveBiddingController
                                              .filteredLiveBidData
                                              .first
                                              .tripBids?[selectedCarIndex!];

                                          final ReturnBidConfirmController
                                          confirmController =
                                          ReturnBidConfirmController();

                                          await confirmController.bidConfirm(
                                            bidId: selectedBidData?.id
                                                .toString(),
                                            tripId: selectedBidData?.tripId
                                                .toString(),
                                          );

                                          if (confirmController
                                              .bidConfirmModel.value.status ==
                                              "success") {
                                            _rentalTripSubmitController
                                                .liveBidStart.value = false;

                                            Get.to(
                                                    () => LiveBiddingConfirmScreen(
                                                  rentalBidConfirm:
                                                  confirmController
                                                      .bidConfirmModel
                                                      .value
                                                      .data!,
                                                ));
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: Colors.white),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Confirm',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey.withAlpha(80),
                                        width: 2,
                                      ),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedCarIndex = null;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.close,
                                              color: Colors.black),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Change',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
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

                    // Offer Slider Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: lightRed,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(50),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
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
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: primaryRed.withAlpha(60),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: primaryRed.withAlpha(80),
                                  ),
                                ),
                                child: Text(
                                  'Best Price',
                                  style: TextStyle(
                                    color: primaryRed,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SliderWidget(),
                          const SizedBox(height: 10),
                          Text(
                            'Adjust your bid to get the best deal',
                            style: TextStyle(
                              color: grey,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 80), // Bottom padding
                  ],
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
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Header
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: lightRed,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cancel_outlined,
                          color: primaryRed,
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
                            color: Colors.grey[400],
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
                      color: lightRed,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: liveBiddingController.beforeCancelList.length,
                      itemBuilder: (context, index) {
                        var item = liveBiddingController.beforeCancelList[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primaryRed.withAlpha(50),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.info_outline,
                                color: primaryRed,
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
                                    tripId, item.id.toString());
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
                        color: lightRed,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Please specify the reason",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            style: TextStyle(color: Colors.white),
                            maxLines: 3,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[900],
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
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    cancelController.sendBeforeCancel(
                                        tripId, '14');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryRed,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
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
                      border: Border.all(color: primaryRed.withAlpha(80)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Keep My Trip",
                        style: TextStyle(
                          color: primaryRed,
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
