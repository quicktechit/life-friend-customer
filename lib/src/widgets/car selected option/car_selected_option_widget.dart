import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class CarSelectedOption extends StatefulWidget {
  final String carImg;
  final String carName;
  final String capacity;

  const CarSelectedOption({
    super.key,
    required this.carImg,
    required this.carName,
    required this.capacity,
  });

  @override
  State<CarSelectedOption> createState() => _CarSelectedOptionState();
}

class _CarSelectedOptionState extends State<CarSelectedOption> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // Car Image with container for better presentation
            Container(
              height: 60,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.carImg,
                  height: 60,
                  width: 100,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 60,
                      width: 80,
                      color: Colors.grey.shade200,
                      child: Icon(
                        Icons.directions_car,
                        color: Colors.grey.shade400,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 16),
            // Car Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(
                    text: widget.carName,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.airline_seat_recline_normal,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: 4),
                      KText(
                        text: widget.capacity,
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Optional: Add a verified or selected indicator
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
