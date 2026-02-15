import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/search_widget/service_card.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../configs/app_list.dart';
import '../text/kText.dart';

class ServiceCategory extends StatelessWidget {
  const ServiceCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KText(
            text: "Select a Services",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF111827),
          ),
        sizeH30,
        _buildServicesSection(context),
      ],).p12(),
    );
  }
  Widget _buildServicesSection(BuildContext context) {
    // 1. Group items into the 2-3-2 pattern
    List<List<ServiceItem>> chunkedRows = [];
    int i = 0;
    bool isTwo = true;
    while (i < quickServices.length) {
      int size = isTwo ? 2 : 3;
      chunkedRows.add(
        quickServices.sublist(
          i,
          (i + size > quickServices.length) ? quickServices.length : i + size,
        ),
      );
      i += size;
      isTwo = !isTwo;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Get actual available width minus section padding
        double availableWidth =
            constraints.maxWidth - 32; // 16 horizontal padding on each side
        double spacing = 10.0; // The gap between cards

        return Column(
          children: chunkedRows.map((row) {
            // 2. Calculate exact item width based on row count
            int itemCount = row.length;
            // Formula: (Total Width - Total Gaps) / Number of items
            double itemWidth =
                (availableWidth - (spacing * (itemCount - 4))) / itemCount;

            return Padding(
              padding: EdgeInsets.only(bottom: spacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row.map((service) {
                  return SizedBox(
                    width: itemWidth,
                    child: buildQuickServiceCard(context,service, itemWidth),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
