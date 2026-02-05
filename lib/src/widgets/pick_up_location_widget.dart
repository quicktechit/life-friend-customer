import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/live%20location%20controller/live_location_controller.dart';

class PickUp extends StatefulWidget {
  const PickUp({super.key});

  @override
  State<PickUp> createState() => _PickUpState();
}

class _PickUpState extends State<PickUp> {
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search field with icon
        Container(
          decoration: BoxDecoration(
            color: greyBackgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: locationController.pickUpC,
            onChanged: (value) {
              value.isEmpty
                  ? locationController.fetchPickSuggestions("Bangladesh")
                  : locationController.fetchPickSuggestions(value);
            },
            decoration: InputDecoration(
              hintText: 'pickUpPoint'.tr,
              hintStyle: TextStyle(
                color: black54.withOpacity(0.7),
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              prefixIcon: Icon(
                Icons.location_on_outlined,
                color: primaryColor,
                size: 24,
              ),
              suffixIcon: locationController.pickUpC.text.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  locationController.pickUpC.clear();
                  locationController.suggestionsPickUp.clear();
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey,
                  size: 20,
                ),
              )
                  : null,
              filled: true,
              fillColor: Colors.transparent,
            ),
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        SizedBox(height: 12),

        // Loading indicator
        if (locationController.isLoading.value)
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Column(
                children: [
                  SpinKitDoubleBounce(
                    color: primaryColor,
                    size: 40.0,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Searching locations...',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          )

        // Suggestions list
        else if (locationController.suggestionsPickUp.isNotEmpty)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200.h,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: locationController.suggestionsPickUp.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final suggestion = locationController.suggestionsPickUp[index];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          locationController.pickUpC.text = suggestion.description;
                          locationController.selectPikUpAddress(suggestion);
                          locationController.suggestionsPickUp.clear();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            border: index != locationController.suggestionsPickUp.length - 1
                                ? Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.1),
                                width: 1,
                              ),
                            )
                                : null,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: primaryColor.withOpacity(0.7),
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  suggestion.description,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
      ],
    ));
  }
}
