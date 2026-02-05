import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/live%20location%20controller/live_location_controller.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
class ViaLocation extends StatefulWidget {
  const ViaLocation({super.key});

  @override
  State<ViaLocation> createState() => _ViaLocationState();
}

class _ViaLocationState extends State<ViaLocation> {
  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        // Padding(
        //   padding: EdgeInsets.only(bottom: 8),
        //   child: KText(
        //     text: 'Via Point'.tr,
        //     fontSize: 16,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.black87,
        //   ),
        // ),

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
            controller: locationController.viaTextC,
            onChanged: (value) {
              value.isEmpty
                  ? locationController.fetchViaSuggestions("Bangladesh")
                  : locationController.fetchViaSuggestions(value);
            },
            decoration: InputDecoration(
              hintText: 'Via Point'.tr,
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
                Icons.location_searching_outlined,
                color: Colors.orange[700],
                size: 24,
              ),
              suffixIcon: locationController.viaTextC.text.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  locationController.viaTextC.clear();
                  locationController.suggestionsVia.clear();
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
                    color: Colors.orange[700],
                    size: 40.0,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Searching via points...',
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
        else if (locationController.suggestionsVia.isNotEmpty)
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
                  itemCount: locationController.suggestionsVia.length,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final suggestion = locationController.suggestionsVia[index];
                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          locationController.viaTextC.text = suggestion.description;
                          locationController.selectViaAddress(suggestion);
                          locationController.suggestionsVia.clear();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            border: index != locationController.suggestionsVia.length - 1
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
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.route_outlined,
                                  color: Colors.orange[700],
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Via Point ${index + 1}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange[700],
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
                                Icons.add_circle_outline,
                                color: Colors.green,
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
