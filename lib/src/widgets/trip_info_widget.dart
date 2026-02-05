import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
class TripInfoWidget extends StatelessWidget {
  final String pick;
  final String drop;
  final String journeyTime;
  const TripInfoWidget({super.key, required this.pick, required this.drop, required this.journeyTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(
              text: "Trip Info:",
              fontWeight: FontWeight.bold,
              fontSize: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   
                    Text(journeyTime),
                  ],
                ),
              ],
            ),
            Container(
              width: Get.width,
              color: white,
              child: Padding(
                padding: paddingH10V20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/pick.png",
                                scale: 20.h,
                              ),
                              SizedBox(
                                width: 3.h,
                              ),
                              Expanded(
                                child: Text(
                                  pick,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.h,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizeH5,
                          Padding(
                            padding:
                            EdgeInsets.fromLTRB(12.h, 0, 12.h, 0),
                            child: Container(
                              height: 15,
                              width: 1,
                              color: grey,
                            ),
                          ),
                          sizeH5,
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/map.png",
                                scale: 20.h,
                              ),
                              SizedBox(
                                width: 3.h,
                              ),
                              Expanded(
                                child: Text(
                                  drop,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.h,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          sizeH5,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
