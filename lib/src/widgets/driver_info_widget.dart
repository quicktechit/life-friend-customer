import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/call_center_bottom_sheet.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class DriverInfoWidget extends StatefulWidget {
  const DriverInfoWidget({super.key});

  @override
  State<DriverInfoWidget> createState() => _DriverInfoWidgetState();
}

class _DriverInfoWidgetState extends State<DriverInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.person),
            sizeW20,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Driver Info',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                KText(
                  text: 'A Driver will be assigned as soon as',
                  fontSize: 15.h,
                  fontWeight: FontWeight.w400,
                ),
                sizeW20,
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(child: CustomBottomSheetCallCenterWidget());
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.redAccent)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Call Center'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
