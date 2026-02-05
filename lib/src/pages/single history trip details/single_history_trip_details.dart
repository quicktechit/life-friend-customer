import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/pdf_controller.dart';
import 'package:pickup_load_update/src/controllers/single%20trip%20details%20controller/single_trip_details_controller.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/car%20selected%20option/car_selected_option_widget.dart';
import 'package:pickup_load_update/src/widgets/custom_button_widget.dart';
import 'package:pickup_load_update/src/widgets/partner_info_widget.dart';
import 'package:pickup_load_update/src/widgets/single_trip_history_title_widget.dart';
import 'package:pickup_load_update/src/widgets/trip_id_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../configs/appUtils.dart';
import '../../widgets/text/kText.dart';

class SingleHistoryTripDetailsPage extends StatefulWidget {
  final String tripId;
  final String type;
  final bool? isComplete;
  final bool? isConfirm;
  final bool? isCancel;
  final bool? isReturn;

  const SingleHistoryTripDetailsPage({super.key,
    required this.tripId,
    this.isComplete = false,
      this.isCancel = false,
      this.isConfirm = false,
      this.isReturn = false, required this.type});

  @override
  State<SingleHistoryTripDetailsPage> createState() =>
      SingleHistoryTripDetailsPageState();
}

class SingleHistoryTripDetailsPageState
    extends State<SingleHistoryTripDetailsPage> {
  final SingleTripDetailsController _singleTripDetailsController =
      Get.put(SingleTripDetailsController());
  final PdfController pdfController = Get.put(PdfController());

  @override
  void initState() {
    super.initState();
    _singleTripDetailsController.singleTripDetails(widget.tripId,widget.type).then((value) {
      if (widget.isComplete == true) {
        if (widget.isReturn == true) {
          pdfController.generatePdf(
              tripId: widget.tripId, tripType: "return_trip");
        } else {
          pdfController.generatePdf(
              tripId: widget.tripId, tripType: "rental_trip");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: CustomAppBar(
          appbarTitle: 'Trip Details',
        ),
        body: Obx(() => _singleTripDetailsController.isLoading.value
            ? loader()
            : _singleTripDetailsController.singleTripDetailsModel.value.data!=null?
        SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TripIDWidget(
                    tripId:
                        '#${_singleTripDetailsController.singleTripDetailsModel.value.data?.tripHistory?.trackingId ?? "N/A"}',
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: Get.width,
                    color: white,
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
                                KText(
                                  text: "Trip Info:",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_singleTripDetailsController
                                                .singleTripDetailsModel
                                                .value
                                                .data
                                                ?.tripHistory
                                                ?.datetime ??
                                            "N/A"),
                                      ],
                                    ),
                                  ],
                                ),
                                10.heightBox,
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
                                        _singleTripDetailsController
                                                .singleTripDetailsModel
                                                .value
                                                .data
                                                ?.tripHistory
                                                ?.pickupLocation ??
                                            "N/A",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.h,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizeH5,
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(12.h, 0, 12.h, 0),
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
                                        for (var location
                                            in _singleTripDetailsController
                                            .singleTripDetailsModel
                                                .value
                                            .data
                                            ?.tripHistory
                                            ?.dropoffLocations
                                            ?.toList() ??
                                            [])
                                          "${location.dropoffLocation}"
                                              .text
                                              .semiBold.maxLines(4)
                                              .overflow(TextOverflow.ellipsis)
                                              .make(),

                                        if( _singleTripDetailsController
                                            .singleTripDetailsModel
                                            .value
                                            .data
                                            ?.tripHistory?.dropoffLocation!=null)
                                          "${ _singleTripDetailsController
                                              .singleTripDetailsModel
                                              .value
                                              .data
                                              ?.tripHistory?.dropoffLocation}" .text
                                              .semiBold.maxLines(4)
                                              .overflow(TextOverflow.ellipsis)
                                              .make(),
                                      ],
                                    )
                                  ],
                                ),
                                sizeH5,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CarSelectedOption(
                    carImg: Urls.getImageURL(
                      endPoint: _singleTripDetailsController
                              .singleTripDetailsModel
                              .value
                              .data
                              ?.tripHistory
                              ?.vehicle
                              ?.image ??
                          "",
                    ),
                    carName: _singleTripDetailsController.singleTripDetailsModel
                            .value.data?.tripHistory?.vehicle?.name ??
                        "N/A",
                    capacity:
                        "${_singleTripDetailsController.singleTripDetailsModel.value.data?.tripHistory?.vehicle?.capacity ?? "N/A"} Seats Capacity",
                  ),
                  SizedBox(height: 20.h),
                  if (widget.isCancel != true && widget.isComplete != true && _singleTripDetailsController
                          .singleTripDetailsModel.value.data?.partner !=
                      null)
                    PartnerInfoWidget(
                      partnerName:
                      "${_singleTripDetailsController.singleTripDetailsModel
                          .value.data!.partner?.name}",
                      partnerCall: _singleTripDetailsController
                              .singleTripDetailsModel
                              .value
                              .data!
                              .partner!
                              .phone ??
                          "N/A",
                      partnerImg: Urls.getImageURL(
                        endPoint: _singleTripDetailsController
                                .singleTripDetailsModel
                                .value
                                .data!
                                .partner!
                                .image ??
                            "",
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: _singleTripDetailsController
                                  .singleTripDetailsModel
                                  .value
                                  .data!
                                  .partner!
                                  .phone ??
                              "",
                        );

                        if (await launchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      title: 'Partner Info',
                    ),
                  SizedBox(height: 20.h),
                  if(widget.isConfirm==false)
                  if (widget.isCancel != true && widget.isComplete != true  &&
                      _singleTripDetailsController.singleTripDetailsModel.value.data?.driver != null)
                    PartnerInfoWidget(
                      partnerName: _singleTripDetailsController
                              .singleTripDetailsModel
                              .value
                              .data!
                              .driver!
                              .name ??
                          "N/A",
                      partnerCall: _singleTripDetailsController
                              .singleTripDetailsModel
                              .value
                              .data!
                              .driver!
                              .phone ??
                          "N/A",
                      partnerImg: Urls.getImageURL(
                        endPoint: _singleTripDetailsController
                                .singleTripDetailsModel
                                .value
                                .data!
                                .driver!
                                .image ??
                            "",
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: _singleTripDetailsController
                                  .singleTripDetailsModel
                                  .value
                                  .data!
                                  .driver!
                                  .phone ??
                              "",
                        );
                        if (!await launchUrl(url)) {
                          throw 'Could not launch $url';
                        }
                      },
                      title: 'Driver Info',
                    ),

                  SizedBox(height: 20.h),
                  SingleTripHistoryWidget(
                    title: 'Round Trip :',
                    subTitle: _singleTripDetailsController
                                .singleTripDetailsModel
                                .value
                                .data
                                ?.tripHistory
                                ?.roundTrip ==
                            1
                        ? "Yes"
                        : "No",
                  ),
                  // if(_singleTripDetailsController
                  //     .singleTripDetailsModel.value.data?.tripHistory?.vehicle?.vehicleCategory==2)
                  // SingleTripHistoryWidget(
                  //   title: 'Journey OTP :',
                  //   subTitle: _singleTripDetailsController
                  //               .singleTripDetailsModel
                  //               .value
                  //               .data
                  //               ?.tripHistory
                  //               ?.otp ==
                  //           1
                  //       ? "Verified"
                  //       : _singleTripDetailsController.singleTripDetailsModel
                  //               .value.data?.tripHistory?.otp
                  //               ?.toString() ??
                  //           "N/A",
                  // ),
                  SingleTripHistoryWidget(
                    title: 'Total Distance :',
                    subTitle:
                        '${calculateTotalDistance().toStringAsFixed(2)} km',
                  ),
                  SingleTripHistoryWidget(
                    title: 'Total Fare :',
                    subTitle: _singleTripDetailsController
                                .singleTripDetailsModel
                                .value
                                .data
                                ?.tripHistory
                                ?.amount !=
                            null
                        ? "${_singleTripDetailsController.singleTripDetailsModel.value.data!.tripHistory!.amount} ৳"
                        : "N/A",
                  ),
                  if(widget.isComplete == true)
                    CustomCommonButton(
                        icons: Icons.download, title: 'Download Pdf').w(
                      context.screenWidth / 1.3,).onTap(() {
                      pdfController.downloadPdf(pdfController.fileName.value);
                    }).centered(),
                  10.heightBox,
                ],
              )):
        SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TripIDWidget(
                    tripId:
                        '#${_singleTripDetailsController.singleReturnTripDetailsModel.value.data?.tripHistory?.trackingId ?? "N/A"}',
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: Get.width,
                    color: white,
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
                                KText(
                                  text: "Trip Info:",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_singleTripDetailsController
                                                .singleReturnTripDetailsModel
                                                .value
                                                .data
                                                ?.tripHistory
                                                ?.timedate ??
                                            "N/A"),
                                      ],
                                    ),
                                  ],
                                ),
                                10.heightBox,
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
                                        _singleTripDetailsController
                                                .singleReturnTripDetailsModel
                                                .value
                                                .data
                                                ?.tripHistory
                                                ?.location ??
                                            "N/A",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.h,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                sizeH5,
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(12.h, 0, 12.h, 0),
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
                                        for (var location
                                            in _singleTripDetailsController
                                            .singleReturnTripDetailsModel
                                                .value
                                            .data
                                            ?.tripHistory
                                            ?.dropoffLocations
                                            ?.toList() ??
                                            [])
                                          "${location.dropoffLocation}"
                                              .text
                                              .semiBold.maxLines(4)
                                              .overflow(TextOverflow.ellipsis)
                                              .make(),
                                        if( _singleTripDetailsController
                                            .singleTripDetailsModel
                                            .value
                                            .data
                                            ?.tripHistory?.dropoffLocation!=null)
                                          "${ _singleTripDetailsController
                                              .singleTripDetailsModel
                                              .value
                                              .data
                                              ?.tripHistory?.dropoffLocation}" .text
                                              .semiBold.maxLines(4)
                                              .overflow(TextOverflow.ellipsis)
                                              .make(),
                                      ],
                                    )
                                  ],
                                ),
                                sizeH5,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CarSelectedOption(
                    carImg: Urls.getImageURL(
                      endPoint: _singleTripDetailsController
                              .singleReturnTripDetailsModel
                              .value
                              .data
                              ?.tripHistory
                              ?.getvehicle
                              ?.image ??
                          "",
                    ),
                    carName: _singleTripDetailsController.singleReturnTripDetailsModel
                            .value.data?.tripHistory?.getvehicle?.name ??
                        "N/A",
                    capacity:
                        "${_singleTripDetailsController.singleReturnTripDetailsModel.value.data?.tripHistory?.getvehicle?.capacity ?? "N/A"} Seats Capacity",
                  ),
                  SizedBox(height: 20.h),
                  if (widget.isCancel != true && widget.isComplete != true && _singleTripDetailsController
                          .singleReturnTripDetailsModel.value.data?.partner !=
                      null)
                    PartnerInfoWidget(
                      partnerName:
                      "${_singleTripDetailsController.singleReturnTripDetailsModel
                          .value.data!.partner?.name}",
                      partnerCall: _singleTripDetailsController
                              .singleReturnTripDetailsModel
                              .value
                              .data!
                              .partner!
                              .phone ??
                          "N/A",
                      partnerImg: Urls.getImageURL(
                        endPoint: _singleTripDetailsController
                                .singleReturnTripDetailsModel
                                .value
                                .data!
                                .partner!
                                .image ??
                            "",
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: _singleTripDetailsController
                                  .singleReturnTripDetailsModel
                                  .value
                                  .data!
                                  .partner!
                                  .phone ??
                              "",
                        );

                        if (await launchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      title: 'Partner Info',
                    ),
                  SizedBox(height: 20.h),
                  if(widget.isConfirm==false)
                  if (widget.isCancel != true && widget.isComplete != true &&
                      _singleTripDetailsController.singleReturnTripDetailsModel.value.data?.driver != null)
                    PartnerInfoWidget(
                      partnerName: _singleTripDetailsController
                              .singleReturnTripDetailsModel
                              .value
                              .data!
                              .driver!
                              .name ??
                          "N/A",
                      partnerCall: _singleTripDetailsController
                              .singleReturnTripDetailsModel
                              .value
                              .data!
                              .driver!
                              .phone ??
                          "N/A",
                      partnerImg: Urls.getImageURL(
                        endPoint: _singleTripDetailsController
                                .singleReturnTripDetailsModel
                                .value
                                .data!
                                .driver!
                                .image ??
                            "",
                      ),
                      onTap: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: _singleTripDetailsController
                                  .singleReturnTripDetailsModel
                                  .value
                                  .data!
                                  .driver!
                                  .phone ??
                              "",
                        );
                        if (!await launchUrl(url)) {
                          throw 'Could not launch $url';
                        }
                      },
                      title: 'Driver Info',
                    ),

                  SizedBox(height: 20.h),
                  SingleTripHistoryWidget(
                    title: 'Round Trip :',
                    subTitle: "No",
                  ),
                  // SingleTripHistoryWidget(
                  //   title: 'Journey OTP :',
                  //   subTitle: _singleTripDetailsController
                  //               .singleTripDetailsModel
                  //               .value
                  //               .data
                  //               ?.tripHistory
                  //               ?.otp ==
                  //           1
                  //       ? "Verified"
                  //       : _singleTripDetailsController.singleTripDetailsModel
                  //               .value.data?.tripHistory?.otp
                  //               ?.toString() ??
                  //           "N/A",
                  // ),
                  SingleTripHistoryWidget(
                    title: 'Total Distance :',
                    subTitle:
                        '${calculateTotalDistance().toStringAsFixed(2)} km',
                  ),
                  SingleTripHistoryWidget(
                    title: 'Total Fare :',
                    subTitle: _singleTripDetailsController
                                .singleReturnTripDetailsModel
                                .value
                                .data
                                ?.tripHistory
                                ?.amount !=
                            null
                        ? "${_singleTripDetailsController.singleReturnTripDetailsModel.value.data!.tripHistory!.amount} ৳"
                        : "N/A",
                  ),
                  if(widget.isComplete == true)
                    CustomCommonButton(
                        icons: Icons.download, title: 'Download Pdf').w(
                      context.screenWidth / 1.3,).onTap(() {
                      pdfController.downloadPdf(pdfController.fileName.value);
                    }).centered(),
                  10.heightBox,
                ],
              ))
        )
    );
  }

  /// calculate form api
  double calculateTotalDistance() {
    String? map;
    String? dropOffMap;
    var item =_singleTripDetailsController.singleTripDetailsModel.value.data!=null? _singleTripDetailsController
        .singleTripDetailsModel.value.data?.tripHistory:_singleTripDetailsController.singleReturnTripDetailsModel.value.data!.tripHistory;
    if (item !=null) {
      map = _singleTripDetailsController
          .singleTripDetailsModel.value.data?.tripHistory?.map?? _singleTripDetailsController
          .singleReturnTripDetailsModel.value.data?.tripHistory?.bidLists?.last.map;
      dropOffMap = _singleTripDetailsController
          .singleTripDetailsModel.value.data?.tripHistory?.dropoffMap!=null?_singleTripDetailsController
          .singleTripDetailsModel.value.data?.tripHistory?.dropoffMap.replaceAll(',', ' '):_singleTripDetailsController
          .singleTripDetailsModel.value.data?.tripHistory?.dropoffLocations?.last.dropoffMap?.replaceAll(',', ' ')??_singleTripDetailsController
          .singleReturnTripDetailsModel.value.data?.tripHistory?.dropoffLocations?.last.dropoffMap?.replaceAll(',', ' ');
    } else {
      map = _singleTripDetailsController
          .singleTripDetailsModel.value.data?.tripHistory?.map;
      String? modifiedCoordinates = _singleTripDetailsController
          .singleTripDetailsModel.value.data?.tripHistory?.dropoffLocations?.last.dropoffMap?.replaceAll(',', ' ');
      dropOffMap =modifiedCoordinates;
    }


    if (map != null && dropOffMap != null) {
      return _singleTripDetailsController.calculateDistance(map, dropOffMap);
    } else {
      return 0.0;
    }
  }
}
