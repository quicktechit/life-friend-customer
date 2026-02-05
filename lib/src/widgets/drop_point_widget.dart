import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/live%20location%20controller/live_location_controller.dart';

class DropWidget extends StatefulWidget {
  const DropWidget({super.key});

  @override
  State<DropWidget> createState() => DropWidgetState();
}

class DropWidgetState extends State<DropWidget> {
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search field with destination icon
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
            controller: locationController.dropC,
            onChanged: (value) {
              value.isEmpty
                  ? locationController.fetchDropSuggestions("Bangladesh")
                  : locationController.fetchDropSuggestions(value);
            },
            decoration: InputDecoration(
              hintText: 'dropOffPoint'.tr,
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
                Icons.location_pin,
                color: Colors.red[600],
                size: 24,
              ),
              suffixIcon: locationController.dropC.text.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  locationController.dropC.clear();
                  locationController.suggestionsDrop.clear();
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
                    color: Colors.red[600],
                    size: 40.0,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Searching destinations...',
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
        else if (locationController.suggestionsDrop.isNotEmpty)
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
                  itemCount: locationController.suggestionsDrop.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final suggestion = locationController.suggestionsDrop[index];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          debugPrint('Testing ::: ');
                          locationController.dropC.text = suggestion.description;
                          locationController.selectDropAddress(suggestion);
                          locationController.suggestionsDrop.clear();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            border: index != locationController.suggestionsDrop.length - 1
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
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.red[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.flag_outlined,
                                  color: Colors.red[600],
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Destination',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.red[600],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      suggestion.description,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.red[400],
                                size: 24,
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
