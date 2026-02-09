import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../configs/appBaseUrls.dart';
import '../../configs/appColors.dart';
import '../../configs/empty_box_widget.dart';
import '../../controllers/cancel Controller/cancel_controller.dart';
import '../../controllers/live bidding controller/live_bidding_controller.dart';
import '../../controllers/rental trip request controllers/rental_trip_bid_confirm_controller.dart';
import '../../controllers/rental trip request controllers/rental_trip_req_submit_controller.dart';
import '../../controllers/single trip details controller/single_trip_details_controller.dart';
import '../../controllers/truck/truck_controller.dart';
import '../../models/live_bidding_model.dart';
import '../../widgets/button/primaryButton.dart';
import '../../widgets/car_live_bidding_widget.dart';
import '../../widgets/divider_widget.dart';
import '../../widgets/slider/slider_widget.dart';
import '../../widgets/text/kText.dart';
import 'bidding_confirm_screen.dart';

class TripWiseBidList extends StatefulWidget {
  final String id;
  final String amount;
  final List<TripBids> data;
  const TripWiseBidList({super.key, required this.data, required this.id, required this.amount});

  @override
  State<TripWiseBidList> createState() => _TripWiseBidListState();
}

class _TripWiseBidListState extends State<TripWiseBidList> {
  int? selectedCarIndex;
  final pric = TextEditingController();
  var box = GetStorage();
  final CancelController cancelController = Get.put(CancelController());
  final TruckController truckController = Get.find();
  final LiveBiddingController liveBiddingController =
  Get.put(LiveBiddingController());
  final RentalTripSubmitController _rentalTripSubmitController =
  Get.put(RentalTripSubmitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Bid List".tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(seconds: 1), () {
            Get.back();
          });
          return Future.value();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Trip Amount Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trip Amount',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '৳${widget.amount}',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Text(
                        '${widget.data.length} Bids',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Bid List Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: widget.data.isEmpty
                    ? Container(
                  padding: const EdgeInsets.all(40),
                  child: EmptyBoxWidget(
                    title: "noLiveMessage".tr,
                    truckImage: 'assets/images/pickup-truck-svgrepo-com.png',
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: widget.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool isSelected = selectedCarIndex == index;
                    final TripBids data = widget.data[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCarIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? primaryColor.withOpacity(0.05)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? primaryColor
                                : Colors.grey.withOpacity(0.1),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Vehicle Image
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey[100],
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          Urls.getImageURL(
                                            endPoint: data.getBrand?.image
                                                ?.toString() ??
                                                '',
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                        onError: (exception, stackTrace) =>
                                            Icon(
                                              Icons.local_shipping,
                                              color: primaryColor,
                                              size: 40,
                                            ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // Vehicle Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                data.getBrand?.name?.toString() ??
                                                    data.getvehicle?.model ??
                                                    '',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            if (isSelected)
                                              Icon(
                                                Icons.check_circle_rounded,
                                                color: primaryColor,
                                                size: 24,
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${data.getBrand?.capacity?.toString() ?? ''} ton capacity',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: primaryColor.withOpacity(0.1),
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: primaryColor.withOpacity(0.2),
                                                ),
                                              ),
                                              child: Text(
                                                '${data.getvehicle?.metro?.toString() ?? ''} ${data.getvehicle?.metroNo?.toString() ?? ''}',
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
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
                                      primaryColor,
                                      primaryColor.withRed(200),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryColor.withOpacity(0.3),
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons or Extra Money Section
              if (selectedCarIndex == null)
                Column(
                  children: [
                    // Cancel Trip Button
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryColor.withRed(200)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          cancelTripRequestReason(
                            context,
                            widget.id.toString(),
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
                              size: 20,
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

                    // Extra Money Section (if amount is not 0)
                    if (widget.amount != "0")
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add More Money'.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.attach_money_rounded,
                                  color: primaryColor,
                                  size: 24,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount".tr,
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${widget.amount}৳",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 20,
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
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: pric,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Amount',
                                        hintStyle: TextStyle(
                                            color: Colors.grey[500]),
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
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primaryColor.withOpacity(0.3),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                        truckController
                                            .sendExtraMoney(
                                            tripId: widget.id,
                                            extendedAmount: pric.text)
                                            .then((value) => pric.clear());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        "Submit".tr,
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
                            const SizedBox(height: 8),
                            Text(
                              'Add extra amount to increase your chance',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Offer Slider Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
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
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: primaryColor.withOpacity(0.2),
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
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),

              // Confirm Selection Buttons (when a vehicle is selected)
              if (selectedCarIndex != null)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.1),
                      width: 1,
                    ),
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
                      const SizedBox(height: 8),
                      Text(
                        'You have selected a vehicle. Confirm your choice or change selection.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
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
                                  colors: [primaryColor, primaryColor.withRed(200)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (selectedCarIndex != null &&
                                      selectedCarIndex! < widget.data.length) {
                                    var selectedBidData = widget.data[selectedCarIndex!];

                                    final ReturnBidConfirmController confirmController =
                                    ReturnBidConfirmController();

                                    await confirmController.bidConfirm(
                                      bidId: selectedBidData.id.toString(),
                                      tripId: selectedBidData.tripId.toString(),
                                    );

                                    if (confirmController
                                        .bidConfirmModel.value.status ==
                                        "success") {
                                      _rentalTripSubmitController
                                          .liveBidTruckStart.value = false;
                                      Get.to(() => LiveBiddingConfirmScreen(
                                        rentalBidConfirm: confirmController
                                            .bidConfirmModel.value.data!,
                                      ));
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.white, size: 20),
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedCarIndex = null;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.close,
                                        color: Colors.grey[700], size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Change',
                                      style: TextStyle(
                                        color: Colors.grey[700],
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

              const SizedBox(height: 80), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  void cancelTripRequestReason(BuildContext context, String tripId) {
    bool isOther = false;
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
                      color: primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: primaryColor.withOpacity(0.1),
                      ),
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
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.1),
                      ),
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
                                color: primaryColor.withOpacity(0.1),
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
                                    tripId, item.id.toString());
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
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.1),
                        ),
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
                                      color: Colors.grey.withOpacity(0.3),
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
                                        color: primaryColor.withOpacity(0.3),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      cancelController.sendBeforeCancel(
                                          tripId, '14');
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
                        color: primaryColor.withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
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
