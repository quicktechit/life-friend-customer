// custom_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/car%20category%20controller/car_category_list_controller.dart';
import 'package:pickup_load_update/src/controllers/division%20controller/division_controller.dart';
import 'package:pickup_load_update/src/models/car_category_list_model.dart';
import 'package:pickup_load_update/src/models/division_model.dart';
import 'package:pickup_load_update/src/pages/home/return%20trip/return_trip_list_page.dart';
import 'package:pickup_load_update/src/widgets/border_background_button.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/divider_widget.dart';
import 'package:pickup_load_update/src/widgets/division_box_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/language/langController.dart';
import '../controllers/return trip controller/return_filter_controller.dart';
import '../models/filter_return_trip_model.dart';
import '../pages/home/return trip/return_trip_list_filter.dart';

class CustomBottomSheetWidget extends StatefulWidget {
  @override
  State<CustomBottomSheetWidget> createState() =>
      _CustomBottomSheetWidgetState();
}

class _CustomBottomSheetWidgetState extends State<CustomBottomSheetWidget> {
  String selectedPickupDivision = '';
  String selectedDropOffDivision = '';
  String selectedCarCategory = '';
  dynamic selectedPickupDivisionId;
  dynamic selectedDropOffDivisionId;
  final LangController langController = Get.find();
  dynamic selectedCarCategoryId;
  final DivisionController _controller = Get.put(DivisionController());
  final CarCategoryController _carCategoryController =
      Get.put(CarCategoryController());

  bool isSelected(String divisionName, String selectedDivision) {
    return divisionName == selectedDivision;
  }
 final filterController = Get.put(ReturnTripFilter());
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: Get.height / 1.2,
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.h, 5, 12.h, 0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            DividerWidget(title: 'Filter'.tr),
            SizedBox(height: 10.h),
            Text(
              'Pick Up Divisions'.tr,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5.h),

            /// division section pick up
            Obx(
              () => _controller.isLoading.value
                  ? loader()
                  : ListView.builder(
                      itemCount: (_controller.divisionList.length / 3).ceil(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        int startIndex = index * 3;
                        int endIndex = (index + 1) * 3;
                        endIndex = endIndex > _controller.divisionList.length
                            ? _controller.divisionList.length
                            : endIndex;

                        List<DivisionList> currentRowDivisions = _controller
                            .divisionList
                            .sublist(startIndex, endIndex);

                        return Row(
                          children: currentRowDivisions.map((data) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DivisionContainer(
                                  isSelected: isSelected(data.name.toString(),
                                      selectedPickupDivision),
                                  onTap: () {
                                    setState(() {
                                      selectedPickupDivision =
                                          data.name.toString();
                                      selectedPickupDivisionId = data.id;
                                    });
                                    print(
                                        'Selected pickup ID: $selectedPickupDivisionId');
                                  },
                                  divisionName:langController.selectedLang.value.toString() == 'en_US'? data.name.toString(): data.nameBn.toString(),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
            ),
            SizedBox(height: 15.h),

            Text(
              'Drop of Divisions'.tr,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5.h),

            /// division section drop of
            Obx(
              () => _controller.isLoading.value
                  ? loader()
                  : ListView.builder(
                      itemCount: (_controller.divisionList.length / 3).ceil(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        int startIndex = index * 3;
                        int endIndex = (index + 1) * 3;
                        endIndex = endIndex > _controller.divisionList.length
                            ? _controller.divisionList.length
                            : endIndex;

                        List<DivisionList> currentRowDivisions = _controller
                            .divisionList
                            .sublist(startIndex, endIndex);

                        return Row(
                          children: currentRowDivisions.map((data) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DivisionContainer(
                                  isSelected: isSelected(data.name.toString(),
                                      selectedDropOffDivision),
                                  onTap: () {
                                    setState(() {
                                      selectedDropOffDivision =
                                          data.name.toString();
                                      selectedDropOffDivisionId = data.id;
                                    });
                                    print(
                                        'Selected Car drop ID: $selectedDropOffDivisionId');
                                  },
                                  divisionName:langController.selectedLang.value.toString() == 'en_US'? data.name.toString(): data.nameBn.toString(),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
            ),
            SizedBox(height: 10.h),

            Text(
              'Car Category'.tr,
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0.h,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5.h),

            /// car category section
            Obx(
              () => _carCategoryController.isLoading.value
                  ? loader()
                  : ListView.builder(
                      itemCount: (_carCategoryController.carListData.length / 3)
                          .ceil(),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        int startIndex = index * 3;
                        int endIndex = (index + 1) * 3;
                        endIndex =
                            endIndex > _carCategoryController.carListData.length
                                ? _carCategoryController.carListData.length
                                : endIndex;

                        List<CarData> currentRowDivisions =
                            _carCategoryController.carListData
                                .sublist(startIndex, endIndex);

                        return Row(
                          children: currentRowDivisions.map((data) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DivisionContainer(
                                  isSelected: isSelected(data.name.toString(),
                                      selectedCarCategory),
                                  divisionName:langController.selectedLang.value.toString() == 'en_US'? data.name.toString():data.nameBn.toString(),
                                  onTap: () {
                                    setState(() {
                                      selectedCarCategory =
                                          data.name.toString();
                                      selectedCarCategoryId = data.id;
                                    });
                                    print(
                                        'Selected Car Category ID: $selectedCarCategoryId');
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
            ),

            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: 170,
                  child: Container(
                    color: white,
                    child: primaryBorderButton(
                        icon: Icons.close,
                        buttonName: 'close'.tr,
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 170,
                  child: Container(
                    color: white,
                    child: primaryButton(
                      icon: Icons.arrow_circle_right_outlined,
                      buttonName: 'Apply'.tr,
                      onTap: () async{
                        if (selectedPickupDivision.isEmpty ||
                            selectedDropOffDivision.isEmpty ||
                            selectedCarCategory.isEmpty) {
                          Get.snackbar('Opps!',
                              'Please select Pickup Division, Drop-off Division, and Car Category',
                              colorText: white,
                              backgroundColor: Colors.redAccent);
                        } else {
                        /*  Get.to(() => ReturnTripListPage(
                                pick: selectedPickupDivisionId.toString(),
                                drop: selectedDropOffDivisionId.toString(),
                                carId: selectedCarCategoryId.toString(),
                              ));*/
                          Get.back();
                         await filterController.fetchReturnTrips(pickUpLocation: selectedPickupDivisionId.toString(),dropOff: selectedDropOffDivisionId.toString(),carID:selectedCarCategoryId.toString(), );

                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
