import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/car%20details%20controller/car_details_controller.dart';
import 'package:pickup_load_update/src/widgets/car_details_title_widget.dart';

Widget _buildStarRating(int starCount) {
  List<Widget> stars = List.generate(
    starCount,
    (index) => Icon(Icons.star, color: Colors.amber),
  );
  return Row(children: stars);
}

class CarDetailsPage extends StatefulWidget {
  final String tripId;
  final String bidId;

  const CarDetailsPage({Key? key, required this.tripId, required this.bidId})
      : super(key: key);

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  final CarDetailsController _carDetailsController =
      Get.put(CarDetailsController());

  @override
  void initState() {
    super.initState();
    _carDetailsController.carDetails(
        tripId: widget.tripId, bidId: widget.bidId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Car Details Page",
          style: TextStyle(color: Colors.white, fontSize: 17.h),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (_carDetailsController.isLoading.value) {
            return Center(child: loader());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 200.h,
                        width: Get.width,
                        child: Image.network(
                          Urls.getImageURL(
                            endPoint: _carDetailsController
                                    .carDetailsModel
                                    .value
                                    .data
                                    ?.biddata
                                    ?.getvehicle
                                    ?.vehicleFrontPic ??
                                '',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200.h,
                        width: Get.width,
                        child: Image.network(
                          Urls.getImageURL(
                            endPoint: _carDetailsController
                                    .carDetailsModel
                                    .value
                                    .data
                                    ?.biddata
                                    ?.getvehicle
                                    ?.vehicleBackPic ??
                                '',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarDetailsTitleWidget(
                      title: 'Brand Name',
                      subTitle: _carDetailsController.carDetailsModel.value.data
                              ?.biddata?.getBrand?.name ??
                          '',
                    ),
                    Divider(),
                    CarDetailsTitleWidget(
                      title: 'Model',
                      subTitle: _carDetailsController.carDetailsModel.value.data
                              ?.biddata?.getCar?.model ??
                          '',
                    ),
                    Divider(),
                    CarDetailsTitleWidget(
                        title: 'Rating',
                        subTitle: _carDetailsController
                                .carDetailsModel.value.data?.averageStar ??
                            '0'),
                    Divider(),
                    CarDetailsTitleWidget(
                      title: 'Metro No',
                      subTitle: _carDetailsController.carDetailsModel.value.data
                              ?.biddata?.getvehicle?.metroNo ??
                          '',
                    ),
                    Divider(),
                    CarDetailsTitleWidget(
                      title: 'Vehicle Metro',
                      subTitle: _carDetailsController.carDetailsModel.value.data
                              ?.biddata?.getvehicle?.metro ??
                          '',
                    ),
                    Divider(),
                    CarDetailsTitleWidget(
                      title: 'Metro Type',
                      subTitle: _carDetailsController.carDetailsModel.value
                              .data?.metrotype?.metroSubName ??
                          '',
                    ),
                    Divider(),
                    CarDetailsTitleWidget(
                      title: 'Vehicle Color',
                      subTitle: _carDetailsController.carDetailsModel.value.data
                              ?.biddata?.getvehicle?.vehicleColor ??
                          '',
                    ),
                    Divider(),
                    CarDetailsTitleWidget(
                      title: 'Vehicle AirCondition',
                      subTitle: _carDetailsController.carDetailsModel.value.data
                              ?.biddata?.getvehicle?.aircondition ??
                          '',
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Customer Ratings:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 34,
                              ),
                              SizedBox(width: 20.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _carDetailsController
                                            .carDetailsModel
                                            .value
                                            .data
                                            ?.reviews?[0]
                                            .getCustomer
                                            ?.name ??
                                        '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    _carDetailsController.carDetailsModel.value
                                            .data?.reviews?[0].comment ??
                                        '',
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              _buildStarRating(int.parse(_carDetailsController
                                      .carDetailsModel
                                      .value
                                      .data
                                      ?.reviews?[0]
                                      .starReviews
                                      ?.toString() ??
                                  '0')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
