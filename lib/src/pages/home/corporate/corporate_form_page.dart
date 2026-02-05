import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/pages/home/corporate/corporate_success_screen.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/text/custom_text_filed_widget.dart';

import '../../../configs/appUtils.dart';
import '../../../widgets/date and time widget/date_time_widget.dart';
import '../../../widgets/drop_point_widget.dart';
import '../../../widgets/pick_up_location_widget.dart';
import '../../../widgets/text/kText.dart';

class CorporateFormPage extends StatefulWidget {
  CorporateFormPage({super.key});

  @override
  State<CorporateFormPage> createState() => _CorporateFormPageState();
}

class _CorporateFormPageState extends State<CorporateFormPage> {
   bool showViaLocation = false;

  /// for time and date
  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Request Corporate Trip",
          style: TextStyle(color: Colors.white, fontSize: 17.h),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// for location track
            Container(
              width: Get.width,
              color: white,
              child: Padding(
                padding: paddingH10V20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/images/pick.png",
                          scale: 12,
                        ),
                        sizeH5,
                        Container(
                          height: 80,
                          width: .9,
                          color: black,
                        ),
                        sizeH5,
                        Image.asset(
                          "assets/images/map.png",
                          scale: 12,
                        ),
                      ],
                    ),
                    sizeW20,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            text: 'pickUpPoint',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          sizeH5,

                          /// pick up point
                          PickUp(),
                          sizeH5,

                         /* /// via location
                          Visibility(
                            visible: showViaLocation,
                            child: ViaLocation(),
                          ),*/

                          /// drop point
                          sizeH10,

                          KText(
                            text: 'dropOffPoint',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          sizeH5,

                          /// drop pont
                          DropWidget()
                        ],
                      ),
                    ),
                   /* InkWell(
                      onTap: () {
                        setState(() {
                          showViaLocation = !showViaLocation;
                        });
                      },
                      child: CircleAvatar(
                        radius: 13,
                        backgroundColor: grey.shade300,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: white,
                          child: Icon(
                            showViaLocation ? Icons.close : Icons.add,
                            color: black54,
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
            sizeH5,
            DateAndTime(
              onDateTimeSelected: (date, time) {
                selectedDate = date;
                selectedTime = time;
              },
            ),
            sizeH5,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(children: [
                CustomTextFieldWithIcon(
                    label: 'Name',
                    icon: Icons.person_outline,
                    controller: nameTextEditingController,
                    hinttext: 'Enter Your Name'),
                sizeH10,
                CustomTextFieldWithIcon(
                    label: 'Phone',
                    icon: Icons.call_outlined,
                    controller: phoneTextEditingController,
                    hinttext: 'Enter Your Phone Number'),
                sizeH10,
                CustomTextFieldWithIcon(
                    label: 'Email',
                    icon: Icons.email_outlined,
                    controller: emailTextEditingController,
                    hinttext: 'Enter Your Email'),
              ],),
            ),
         sizeH30,
            primaryButton(buttonName: 'Continue', onTap: (){
              Get.to(CorporateSuccessScreen());
            })
          ],
        ),
      ),
    );
  }
}
