import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/guide%20line/aboutus_controller.dart';
import 'package:pickup_load_update/src/models/guide_lines_model.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import '../../widgets/text/kText.dart';

class FaqPage extends StatefulWidget {
  @override
  State<FaqPage> createState() => FaqPageState();
}

class FaqPageState extends State<FaqPage> {
  final AboutUsController aboutUsController = Get.put(AboutUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: 'Frequently Asked Questions'),
      body: Obx(() {
        if (aboutUsController.isLoading.value) {
          return Center(child: loader());
        } else {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 125.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.h,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                      AssetImage('assets/images/icon-logo.png'),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 177.h,
                      ),
                      KText(
                        text: "Frequently Asked Questions",
                        fontWeight: FontWeight.bold,
                        fontSize: 19.h,
                      ),
                      SizedBox(height: 15.h),
                      SizedBox(
                        height: 500.h,
                        child: ListView.builder(
                          itemCount: aboutUsController.faq.length,
                          itemBuilder: (BuildContext context, index) {
                            Faq faqData = aboutUsController.faq[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpansionTile(
                                title: Text(
                                  faqData.question ?? 'Question',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                collapsedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Colors.grey.shade300,
                                collapsedBackgroundColor: Colors.grey.shade300,
                                children: [
                                  Container(
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(18.0.h),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("Answer: ${faqData.answer ?? 'No answer available'}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

