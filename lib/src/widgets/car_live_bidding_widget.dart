import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

import '../configs/appColors.dart';
import '../models/live_bidding_model.dart';

class CarLiveBiddingContainerWidget extends StatelessWidget {

  final String pickup;
  final String amount;
  final List<DropoffLocations> dropoffs;
  final String dropoff;

  const CarLiveBiddingContainerWidget({
    super.key,

    required this.pickup,
    required this.amount,
    required this.dropoffs,
    required this.dropoff,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      height: dropoffs != [] ? 250 : 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizeW20,
            KText(text: "Pickup"),
            KText(
              text: pickup,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 15),
            KText(text: "DropOff"),
            if (dropoffs != [])
              for (var location in dropoffs)
                KText(
                  text: "${location.dropoffLocation}",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
            if (dropoff != "")
              KText(
                text: dropoff,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            Spacer(),
            KText(
              text: amount,
              fontSize: 14,
              color: black45,
            ),
          ],
        ),
      ),
    );
  }
}

class CarLiveBiddingContainerWidget2 extends StatelessWidget {
  final String img;
  final String rating;
  final String carName;
  final String capacity;
  final String fare;
  final VoidCallback onTap;
  final String carNumber;

  const CarLiveBiddingContainerWidget2(
      {super.key,
      required this.img,
      required this.carName,
      required this.capacity,
      required this.rating,
      required this.fare,
      required this.carNumber, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
           InkWell(
             onTap: onTap,
             child: Image.network(img,scale: 1.5,)
           ),
            sizeW20,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: carName,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 3),
                KText(
                  text: capacity,
                  fontSize: 14,
                  color: black45,
                ),
                KText(
                  fontWeight: FontWeight.bold,
                  text: fare,
                  fontSize: 15,
                  color: black45,
                ),
              ],
            ),
            SizedBox(width: 30.h),
            Column(
              children: [
                KText(
                  text: carNumber,
                  fontSize: 14,
                  color: black45,
                ),
                KText(
                  text: rating,
                  fontSize: 14,
                  color: black45,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
