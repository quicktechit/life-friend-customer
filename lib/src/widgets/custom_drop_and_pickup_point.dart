import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/status_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class DropAndPickupWidget extends StatefulWidget {
  final String dropPoint;
  final String pickPoint;
  final String? viaPoint;

  const DropAndPickupWidget({
    super.key,
    required this.dropPoint,
    required this.pickPoint,
    this.viaPoint,
  });

  @override
  State<DropAndPickupWidget> createState() => _DropAndPickupWidgetState();
}

class _DropAndPickupWidgetState extends State<DropAndPickupWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRoutePoint(
              icon: Icons.circle,
              iconColor: primaryColor,
              label: 'pickUpPoint'.tr,
              location: widget.pickPoint,
              isFirst: true,
            ),
            if (widget.viaPoint != null && widget.viaPoint!.isNotEmpty) ...[
              _buildRoutePoint(
                icon: Icons.flag_circle,
                iconColor: Colors.orange,
                label: 'viaPoint'.tr,
                location: widget.viaPoint!,
              ),
            ],
            _buildRoutePoint(
              icon: Icons.location_on,
              iconColor: Colors.green,
              label: 'dropOffPoint'.tr,
              location: widget.dropPoint,
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutePoint({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String location,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 12,
            color: iconColor,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isFirst) ...[
                Container(
                  height: 20,
                  width: 2,
                  margin: EdgeInsets.only(left: 2),
                  color: Colors.grey.shade300,
                ),
                SizedBox(height: 8),
              ],
              KText(
                text: label,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              SizedBox(height: 2),
              KText(
                text: location,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              if (!isLast) SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
