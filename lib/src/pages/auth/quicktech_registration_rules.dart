import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../configs/appColors.dart';
import '../../configs/appUtils.dart';
import '../../widgets/text/kText.dart';

class QuickTechRegistrationRules extends StatelessWidget {
  const QuickTechRegistrationRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
              ),
              sizeH10,
              Container(
                height: Get.height * 0.9,
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: 'রেজিস্ট্রেশনের শর্তাবলি :',
                      fontSize: 16.0.h,
                      fontWeight: FontWeight.w500,
                    ),
                    sizeH10,
                    Text(
                      "দৈনিক বা ঘণ্টা ভিত্তিক গাড়ী ভাড়া: অল্প সময়ের জন্য ব্যক্তিগত বা ব্যবসায়িক কাজের জন্য গাড়ী ভাড়া নেওয়া যায়, যা দৈনিক বা ঘণ্টা অনুযায়ী চার্জ করা হয়।\n\nদীর্ঘমেয়াদী গাড়ী ভাড়া: মাসিক বা বার্ষিক ভিত্তিতে গাড়ী ভাড়া নেওয়ার সুবিধা থাকে, যা কর্পোরেট প্রতিষ্ঠান বা ব্যক্তিগত ব্যবহারের জন্য উপযোগী।\n\nট্যুর এবং ট্রিপ সার্ভিস: ভ্রমণের জন্য বিভিন্ন রকমের গাড়ী ভাড়া নেওয়া যায় যেমন মাইক্রোবাস, মিনিবাস, বা এসইউভি, যা দূরপাল্লার ভ্রমণে সহায়ক।\n\nড্রাইভারসহ গাড়ী ভাড়া: এই সার্ভিসে গাড়ীর সাথে প্রশিক্ষিত ড্রাইভারও প্রদান করা হয়, যা যাত্রীদের জন্য আরও আরামদায়ক এবং নিরাপদ।\n\nবিয়ে বা বিশেষ অনুষ্ঠানের জন্য গাড়ী ভাড়া: বিশেষ উপলক্ষে যেমন বিয়ে, পার্টি বা কর্পোরেট ইভেন্টের জন্য লাক্সারি গাড়ী ভাড়া করা যায়।",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
