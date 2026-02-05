import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/single%20trip%20details%20controller/single_return_trip_details_controller.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/car%20selected%20option/car_selected_option_widget.dart';
import 'package:pickup_load_update/src/widgets/driver_information_widget.dart';
import 'package:pickup_load_update/src/widgets/partner_info_widget.dart';
import 'package:pickup_load_update/src/widgets/single_trip_history_title_widget.dart';
import 'package:pickup_load_update/src/widgets/trip_id_widget.dart';
import 'package:pickup_load_update/src/widgets/trip_info_widget.dart';
import 'package:pickup_load_update/src/widgets/vehicle_full%20details_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleReturnHistoryTripDetailsPage extends StatefulWidget {
  final String tripId;

  const SingleReturnHistoryTripDetailsPage({super.key, required this.tripId});

  @override
  State<SingleReturnHistoryTripDetailsPage> createState() =>
      SingleReturnHistoryTripDetailsPageState();
}

class SingleReturnHistoryTripDetailsPageState
    extends State<SingleReturnHistoryTripDetailsPage> {
  final SingleReturnTripDetailsController _controller =
      Get.put(SingleReturnTripDetailsController());

  @override
  void initState() {
    super.initState();
    _controller.getReturnSingeHistory(widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(
        appbarTitle: 'Return Trip Details',
      ),
      body: Obx(() => _controller.isLoading.value
          ? loader()
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TripIDWidget(
                    tripId:
                        '#${_controller.returnTrip.value.data?.trackingId == null ? "N/A" : _controller.returnTrip.value.data?.trackingId}',
                  ),
                  SizedBox(height: 20.h),
                  TripInfoWidget(
                    pick:
                        "${_controller.returnTrip.value.data?.pickupLocation.toString()}",
                    drop:
                        "${_controller.returnTrip.value.data?.dropoffLocation.toString()}",
                    journeyTime:
                        "${_controller.returnTrip.value.data?.timedate.toString()}",
                  ),
                  SizedBox(height: 20.h),
                  CarSelectedOption(
                    carImg: Urls.getImageURL(
                      endPoint:
                          "${_controller.returnTrip.value.data?.getvehicle?.image.toString()}",
                    ),
                    carName:
                        "${_controller.returnTrip.value.data?.getvehicle?.name.toString()}",
                    capacity:
                        "${_controller.returnTrip.value.data?.getvehicle?.capacity.toString()} Seats Capacity",
                  ),
                  SizedBox(height: 20.h),

                  /// partner information widget

                  _controller.returnTrip.value.data?.getpartner == null
                      ? Container()
                      : PartnerInfoWidget(
                          partnerName:
                              "${_controller.returnTrip.value.data?.getpartner?.name.toString()}",
                          partnerCall:
                              "${_controller.returnTrip.value.data?.getpartner?.phone.toString()}",
                          partnerImg: Urls.getImageURL(
                            endPoint:
                                "${_controller.returnTrip.value.data?.getpartner?.image.toString()}",
                          ),
                          onTap: () async {
                            final Uri url = Uri(
                                scheme: 'tel',
                                path: _controller
                                    .returnTrip.value.data?.getpartner?.phone
                                    .toString());

                            if (await launchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          title: 'Partner Info',
                        ),
                  SizedBox(height: 20.h),

                  /// driver information widget
                  _controller.returnTrip.value.data?.assignedDriver == null
                      ? Container()
                      : DriverInformationWidget(
                          driverName:
                              "${_controller.returnTrip.value.data?.assignedDriver?.name.toString()}",
                          driverCall:
                              "${_controller.returnTrip.value.data?.assignedDriver?.phone.toString()}",
                          driverImg: Urls.getImageURL(
                              endPoint:
                                  "${_controller.returnTrip.value.data?.assignedDriver?.image.toString()}"),
                          onTap: () async {
                            final Uri url = Uri(
                                scheme: 'tel',
                                path:
                                    "${_controller.returnTrip.value.data?.assignedDriver?.phone.toString()}");

                            if (await launchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          title: 'Driver Info',
                          email:
                              "${_controller.returnTrip.value.data?.assignedDriver?.email.toString()}",
                        ),
                  SizedBox(height: 20.h),

                  /// vehicle details widget
                  _controller.returnTrip.value.data?.assignedCar == null
                      ? Container()
                      : BriefDescriptionVehchile(
                          airCondition:
                              "${_controller.returnTrip.value.data?.assignedCar?.aircondition.toString()}",
                          metroType:
                              "${_controller.returnTrip.value.data?.assignedCar?.metro.toString()} - ${_controller.returnTrip.value.data?.assignedCar?.metroSubCategory.toString()} - ${_controller.returnTrip.value.data?.assignedCar?.metroNo.toString()}",
                          brandName:
                              "${_controller.returnTrip.value.data?.assignedCar?.brandName.toString()}",
                        ),
                  SizedBox(height: 20.h),
                  SingleTripHistoryWidget(
                    title: 'Trip Status :',
                    subTitle: () {
                      final tripData = _controller.returnTrip.value.data;
                      if (tripData?.isConfirmed == 1 &&
                          tripData?.otp != 1 &&
                          tripData?.status == 0) {
                        return "Confirmed";
                      } else if (tripData?.isConfirmed == 1 &&
                          tripData?.otp == 1 &&
                          tripData?.status == 0) {
                        return "Trip Started";
                      } else if (tripData?.isConfirmed == 1 &&
                          tripData?.otp == 1 &&
                          tripData?.status == 1) {
                        return "Trip Completed";
                      } else {
                        return "Cancelled";
                      }
                    }(),
                  ),
                  SingleTripHistoryWidget(
                    title: 'Journey OTP :',
                    subTitle: _controller.returnTrip.value.data?.otp == 1
                        ? "Submitted"
                        : "${_controller.returnTrip.value.data?.otp.toString()}",
                  ),
                  SingleTripHistoryWidget(
                    title: 'Total Distance :',
                    subTitle:
                        '${calculateTotalDistance().toStringAsFixed(2)}  km',
                  ),
                  SingleTripHistoryWidget(
                    title: 'Total Fare :',
                    subTitle:
                        "${_controller.returnTrip.value.data?.amount.toString()} ৳",
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            )),
    );
  }

  /// calculate form api
  dynamic calculateTotalDistance() {
    String? map = _controller.returnTrip.value.data?.bidDetails?.map;
    String? dropOffMap =
        _controller.returnTrip.value.data?.bidDetails?.dropoffMap;

    if (map != null && dropOffMap != null) {
      return _controller.calculateDistance(map, dropOffMap);
    } else {
      return 0.0;
    }
  }
}
