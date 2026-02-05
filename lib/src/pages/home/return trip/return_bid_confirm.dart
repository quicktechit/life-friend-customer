import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/components/drawer/sidebarComponent.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/return%20trip%20controller/return_bid_cancel_controller.dart';
import 'package:pickup_load_update/src/pages/Trip%20History/trip_history_page.dart';
import 'package:pickup_load_update/src/widgets/border_background_button.dart';
import 'package:pickup_load_update/src/widgets/car_container_widget.dart';
import 'package:pickup_load_update/src/widgets/custom%20app%20bar/app_bar_widget.dart';
import 'package:pickup_load_update/src/widgets/history_time_widget.dart';
import 'package:pickup_load_update/src/widgets/partner_fee_widget.dart';
import 'package:pickup_load_update/src/widgets/status_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReturnBidConfirm extends StatefulWidget {
  final String carImg;
  final String capacity;
  final dynamic bidId;
  final String carName;
  final String pickup;
  final String drop;
  final String partnerFare;
  final String tripTime;

  const ReturnBidConfirm(
      {super.key,
      required this.carImg,
      required this.capacity,
      required this.carName,
      required this.pickup,
      required this.drop,
      required this.partnerFare,
      required this.tripTime,
      this.bidId});

  @override
  State<ReturnBidConfirm> createState() => _ReturnBidConfirmState();
}

class _ReturnBidConfirmState extends State<ReturnBidConfirm> {
  final ReturnTripBidCancelController _controller =
      Get.put(ReturnTripBidCancelController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AllTripHistoryController controller =
      Get.put(AllTripHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      drawer: Drawer(
        child: ExampleSidebarX(
          controller: controller.sidebarController,
        ),
      ),
      appBar: CustomCommonAppBar(
        title: 'Trip ID#${widget.bidId}',
        scaffoldKey: _scaffoldKey,
      ),
      body: Container(
        width: Get.width,
        child: Padding(
          padding: paddingH10V20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatusWidget(
                      bgColors: Colors.grey.withOpacity(0.2),
                      icon: Icons.edit_location_sharp,
                      statusTitle: widget.pickup,
                      textColor: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0.h),
                      child: Container(
                        height: 30,
                        width: 1.4,
                        color: Colors.red,
                      ),
                    ),
                    StatusWidget(
                      bgColors: Colors.grey.withOpacity(0.2),
                      icon: Icons.edit_location_rounded,
                      statusTitle: widget.drop,
                      textColor: Colors.black,
                    ),
                    sizeH20,
                    CarContainerWidget(
                      img: Urls.getImageURL(endPoint: widget.carImg),
                      carName: widget.carName,
                      capacity: '${widget.capacity} Seats Capacity',
                    ),
                    sizeH20,
                    Row(
                      children: [
                        StatusWidget(
                          icon: Icons.watch_later_outlined,
                          statusTitle: 'Trip Time',
                          textColor: Colors.black,
                        ),
                        Spacer(),
                        HistoryTimeWidget(
                          date: widget.tripTime,
                        )
                      ],
                    ),
                    Divider(),
                    PartnerFeeWidget(
                      partnerFee: "${widget.partnerFare} TK",
                    ),
                    sizeH20,
                    sizeH20,
                    Obx(
                      () => _controller.isLoading.value
                          ? loader()
                          : Container(
                              child: primaryBorderButton(
                                  icon: Icons.cancel_outlined,
                                  buttonName: 'Cancel Bid',
                                  onTap: () {
                                    _controller.cancelBid(bidId: 6);
                                  }),
                            ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
