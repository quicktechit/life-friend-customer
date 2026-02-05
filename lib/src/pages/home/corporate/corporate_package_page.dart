import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/controllers/corporate%20controller/corporate_controller.dart';
import 'package:pickup_load_update/src/pages/home/corporate/corporate_payment_screen.dart';
import 'package:pickup_load_update/src/widgets/custom_button_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class CorporatePackageScreen extends StatelessWidget {
  CorporatePackageScreen({super.key});

  final controller = Get.put(CorporateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Corporate Subscription",
          style: TextStyle(color: Colors.white, fontSize: 17.h),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.isMonthly.value = true;
                        },
                        child: Container(
                          height: 30.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.blue),
                              color: controller.isMonthly.value
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8))),
                          child: Center(
                              child: Text(
                            'Monthly',
                            style: TextStyle(
                                color: controller.isMonthly.value
                                    ? Colors.white
                                    : Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.isMonthly.value = false;
                        },
                        child: Container(
                          height: 30.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.blue),
                              color: controller.isMonthly.value
                                  ? Colors.white
                                  : Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                          child: Center(
                              child: Text(
                            'Yearly',
                            style: TextStyle(
                                color: controller.isMonthly.value
                                    ? Colors.blue
                                    : Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
        SizedBox(
          height: Get.height*0.83,  // Adjust height as per your design
          child: ListView.builder(
            itemCount: 5,
            scrollDirection: Axis.horizontal,  // Set horizontal scrolling
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300.w,
                    margin: EdgeInsets.symmetric(horizontal: 10.w),  // Adjust margins
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,  // Adjust background color or use image
                      // Use DecorationImage if needed
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 170.h,  // Adjust height of image container
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/package.png'),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              topRight: Radius.circular(14),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        KText(
                          text: 'Premium',
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromRGBO(221, 209, 255, 1),
                          ),
                          height: 70.h,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              KText(
                                text: 'OFFER PRICE',
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  KText(
                                    text: 'BDT 500',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                  KText(
                                    text: controller.isMonthly.value ? '/Monthly' : '/Yearly',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Icon(Icons.done_outlined,color: Colors.white,),
                                  )),
                              SizedBox(width: 10.w,),
                              Expanded(child: KText(text: 'Unlimited product addition and orders',maxLines: 2))
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Icon(Icons.done_outlined,color: Colors.white,),
                                  )),
                              SizedBox(width: 10.w,),
                              Expanded(child: KText(text: 'Website link (<yourshop>.quicktech.com)',maxLines: 2))
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Icon(Icons.done_outlined,color: Colors.white,),
                                  )),
                              SizedBox(width: 10.w,),
                              Expanded(child: KText(text: 'Add your custom domain',maxLines: 2))
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Icon(Icons.done_outlined,color: Colors.white,),
                                  )),
                              SizedBox(width: 10.w,),
                              Expanded(child: KText(text: 'Theme customization',maxLines: 2))
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Icon(Icons.done_outlined,color: Colors.white,),
                                  )),
                              SizedBox(width: 10.w,),
                              Expanded(child: KText(text: 'Track customer loyalty & customer list',maxLines: 2))
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.green),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Icon(Icons.done_outlined,color: Colors.white,),
                                  )),
                              SizedBox(width: 10.w,),
                              Expanded(child: KText(text: 'Alerts enabled',maxLines: 2))
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding:  EdgeInsets.symmetric(
                              horizontal: 20.w
                          ),
                          child: GestureDetector(
                              onTap: (){
                                debugPrint('buy button tapped::');
                               Get.to(()=>CorporatePaymentScreen());
                              },
                              child: CustomCommonButton(icons: Icons.done, title: 'Buy',color: Colors.blue)),
                        ),
                        SizedBox(height: 10.h),
                        // Include other features as per your design
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        )

        ],
              )),
        ),
      ),
    );
  }
}
