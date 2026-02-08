import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../configs/appColors.dart';
import '../../../configs/appUtils.dart';
import '../../../controllers/live location controller/live_location_controller.dart';

class CustomDropWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String lat, String lng) onLocationSelected;

  const CustomDropWidget({
    super.key,
    required this.controller,
    required this.onLocationSelected,
  });

  @override
  State<CustomDropWidget> createState() => _CustomDropWidget();
}

class _CustomDropWidget extends State<CustomDropWidget> {
  final LocationController locationController = Get.put(LocationController());
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        locationController.activeController.value = widget.controller;
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isActive = locationController.activeController.value == widget.controller;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: (value) {
              value.isEmpty
                  ? locationController.fetchDropSuggestions("Bangladesh")
                  : locationController.fetchDropSuggestions(value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'dropOffPoint'.tr,
              counterText: '',
              labelStyle: TextStyle(color: black54),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          sizeH10,
          if (isActive && locationController.isLoading.value)
            Center(
              child: SpinKitDoubleBounce(
                color: primaryColor,
                size: 50.0,
              ),
            )
          else if (isActive && locationController.suggestionsDrop.isNotEmpty)
            SizedBox(
              height: 130.h,
              child: ListView.builder(
                itemCount: locationController.suggestionsDrop.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      locationController.suggestionsDrop[index].description,
                    ),
                    onTap: () async {
                      final selected = locationController.suggestionsDrop[index];

                      debugPrint('Getting Location ::: $selected');

                      await locationController.getDropDetailsAddress(selected);
                      widget.controller.text = locationController.dropUpBnLocation.value;

                      await locationController.selectMultipleDropAddress(selected);

                      widget.onLocationSelected(
                        locationController.selectedDropUpLat.value,
                        locationController.selectedDropUpLng.value,
                      );

                      locationController.suggestionsDrop.clear();
                    },
                  );
                },
              ),
            )
        ],
      );
    });
  }
}

