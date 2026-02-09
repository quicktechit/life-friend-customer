import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/components/bottom%20navbar/bottom.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';

import 'package:pickup_load_update/src/models/rental_bid_confirm_model.dart';

import 'package:pickup_load_update/src/widgets/car_container_widget.dart';
import 'package:pickup_load_update/src/widgets/custom_button_widget.dart';
import 'package:pickup_load_update/src/widgets/driver_info_widget.dart';
import 'package:pickup_load_update/src/widgets/history_time_widget.dart';
import 'package:pickup_load_update/src/widgets/partner_info_widget.dart';

import 'package:pickup_load_update/src/widgets/status_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveBiddingConfirmScreen extends StatefulWidget {
  final RentalBidConfirm rentalBidConfirm;

  const LiveBiddingConfirmScreen({
    super.key,
    required this.rentalBidConfirm,
  });

  @override
  _LiveBiddingConfirmScreenState createState() =>
      _LiveBiddingConfirmScreenState();
}

class _LiveBiddingConfirmScreenState extends State<LiveBiddingConfirmScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text(
            "Tracking #${widget.rentalBidConfirm.tripConfirm!.trackingId.toString()}",
            style: TextStyle(color: Colors.white, fontSize: 16.h),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        size: 30,
                        color: Colors.amber.withOpacity(0.9),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Your Trip is Confirmed, Partner will pick you up at the selected time. Share the OTP with Partner to verify your trip',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.all(10),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       StatusWidget(
                            //         icon: Icons.password,
                            //         bgColors: Colors.grey.withOpacity(0.2),
                            //         statusTitle: "YOUR OTP",
                            //         textColor: Colors.black,
                            //       ),
                            //       KText(
                            //         text: widget
                            //             .rentalBidConfirm.tripConfirm!.otp
                            //             .toString(),
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: CarContainerWidget(
                      img: Urls.getImageURL(
                          endPoint: widget.rentalBidConfirm.vehicle!.image
                              .toString()),
                      carName: widget.rentalBidConfirm.vehicle!.name.toString(),
                      capacity:
                          "${widget.rentalBidConfirm.vehicle!.capacity.toString()} Seats Capacity"),
                ),
                SizedBox(height: 10),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusWidget(
                        icon: Icons.refresh,
                        bgColors: Colors.grey.withOpacity(0.4),
                        statusTitle: "Round Trip",
                        textColor: Colors.black),
                    KText(
                      text:
                          "${widget.rentalBidConfirm.tripRequest!.roundTrip == 0 ? "No" : "Yes"}",
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    StatusWidget(
                      icon: Icons.watch_later_outlined,
                      statusTitle: 'Journey Time',
                      textColor: Colors.black,
                    ),
                    Spacer(),
                    HistoryTimeWidget(
                      date: "${widget.rentalBidConfirm.tripRequest!.datetime}",
                    )
                  ],
                ),
                SizedBox(height: 10),
            PartnerInfoWidget(
              partnerName: widget.rentalBidConfirm.partner?.name?.toString() ?? 'N/A',
              partnerCall: widget.rentalBidConfirm.partner?.phone?.toString() ?? 'N/A',
              partnerImg: widget.rentalBidConfirm.partner?.image != null
                  ? Urls.getImageURL(endPoint: widget.rentalBidConfirm.partner!.image.toString())
                  : 'default_image_url', // replace with a placeholder URL if needed
              onTap: () async {
                if (widget.rentalBidConfirm.partner?.phone != null) {
                  final Uri url = Uri(
                    scheme: 'tel',
                    path: widget.rentalBidConfirm.partner!.phone.toString(),
                  );

                  if (await launchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                } else {
                  print('Phone number is not available');
                }
              },
              title: 'Partner Info',
            ),

            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(
                      text: 'Total Fare: ',
                      fontWeight: FontWeight.bold,
                    ),
                    KText(
                      text:
                          "${widget.rentalBidConfirm.tripConfirm!.amount.toString()}",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                // SafetyAssuranceWidget(),
                SizedBox(height: 20),
                DriverInfoWidget(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.offAll(() => DashboardView());
                    },
                    child: SizedBox(
                      height: 50.h,
                      child: CustomCommonButton(
                          icons: Icons.settings_backup_restore_sharp,
                          title: "Back to Dashboard"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
