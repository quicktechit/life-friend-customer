import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/auth%20controllers/registration_controller.dart';
import 'package:pickup_load_update/src/pages/auth/benefits_screen.dart';
import 'package:pickup_load_update/src/pages/auth/otp_input_page.dart';
import 'package:pickup_load_update/src/pages/auth/quicktech_registration_rules.dart';

import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/text/custom_text_filed_widget.dart';

class AuthStartPage extends StatefulWidget {
  const AuthStartPage({super.key});

  @override
  State<AuthStartPage> createState() => _AuthStartPageState();
}

class _AuthStartPageState extends State<AuthStartPage> {
  final TextEditingController mobileController = TextEditingController();
  final RegistrationController _controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 40.0.h),
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors: [
          //       primaryColor.withAlpha(15),
          //       Colors.white.withAlpha(250),
          //       bgColor,
          //     ],
          //   ),
          // ),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                // Center(
                //   child: Column(
                //     children: [
                //       // Container(
                //       //   padding: EdgeInsets.all(20.0.h),
                //       //   decoration: BoxDecoration(
                //       //     color: primaryColor.withAlpha(20),
                //       //     shape: BoxShape.circle,
                //       //     border: Border.all(
                //       //       color: primaryColor.withAlpha(40),
                //       //       width: 2.0,
                //       //     ),
                //       //   ),
                //       //   child: Image.asset(
                //       //     'assets/images/Login_Page_Vector.png',
                //       //     width: 150.0.w,
                //       //     height: 150.0.h,
                //       //     fit: BoxFit.contain,
                //       //   ),
                //       // ),
                //       // SizedBox(height: 30.0.h),
                //       Container(
                //         padding: EdgeInsets.symmetric(
                //           horizontal: 20.0.w,
                //           vertical: 10.0.h,
                //         ),
                //         decoration: BoxDecoration(
                //           color: primaryColor.withAlpha(10),
                //           borderRadius: BorderRadius.circular(20.0),
                //           border: Border.all(
                //             color: primaryColor.withAlpha(30),
                //           ),
                //         ),
                //         child: Column(
                //           children: [
                //             Text(
                //            'স্বাগতম! লাইফ ফ্রেন্ড স্মার্ট অ্যাপের সাথে শুরু হোক আপনার স্মার্ট যাত্রা',
                //               textAlign: TextAlign.center,
                //               style: GoogleFonts.ubuntu(
                //                 textStyle: TextStyle(
                //                   color: Colors.black,
                //                   fontSize: 22.0.h,
                //                   fontWeight: FontWeight.w600,
                //                   height: 1.3,
                //                 ),
                //               ),
                //             ),
                //             SizedBox(height: 8.0.h),
                //             // Text(
                //             //   "Please input your Mobile Number to Continue",
                //             //   textAlign: TextAlign.center,
                //             //   style: TextStyle(
                //             //     color: Colors.grey.shade700,
                //             //     fontSize: 14.0.h,
                //             //   ),
                //             // ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(height: 40.0.h),

                // Input Section
                // Container(
                //   padding: EdgeInsets.all(15.0.w),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(20.0),
                //     boxShadow: [
                //       BoxShadow(
                //         color: primaryColor.withAlpha(30),
                //         blurRadius: 15.0,
                //         offset: Offset(0, 5),
                //       ),
                //     ],
                //     border: Border.all(
                //       color: primaryColor.withAlpha(50),
                //     ),
                //   ),
                //   child: Column(
                //     children: [
                //       // Mobile Number Field
                //       CustomTextFieldWithIcon(
                //         label: 'মোবাইল নাম্বার দিন',
                //         icon: Icons.phone_android,
                //
                //         keyboardType: TextInputType.number,
                //         controller: mobileController,
                //         hinttext: '০১xxxxxxxxx',
                //
                //       ),
                //
                //       SizedBox(height: 25.0.h),
                //
                //       // Terms & Conditions Checkbox
                //       Row(
                //         children: [
                //           Container(
                //             decoration: BoxDecoration(
                //               shape: BoxShape.circle,
                //               color: primaryColor.withAlpha(10),
                //             ),
                //             child: Obx(
                //                   () => Checkbox(
                //                 value: _controller.isChecked.value,
                //                 onChanged: (v) {
                //                   _controller.isChecked.value = v!;
                //                 },
                //                 activeColor: primaryColor,
                //                 checkColor: Colors.white,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(6.0),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           SizedBox(width: 12.0.w),
                //           Expanded(
                //             child: RichText(
                //               text: TextSpan(
                //                 style: TextStyle(
                //                   color: Colors.grey.shade700,
                //                   fontSize: 14.0.h,
                //                 ),
                //                 children: [
                //                   TextSpan(text: 'আমি '),
                //                   TextSpan(
                //                     text: 'রেজিস্ট্রেশনের শর্তাবলি ',
                //                     style: TextStyle(
                //                       color: primaryColor,
                //                       fontWeight: FontWeight.w600,
                //                       decoration: TextDecoration.underline,
                //                     ),
                //                     recognizer: TapGestureRecognizer()
                //                       ..onTap = () {
                //                         Get.to(
                //                               () => QuickTechRegistrationRules(),
                //                           transition: Transition.rightToLeft,
                //                           duration: Duration(milliseconds: 400),
                //                         );
                //                       },
                //                   ),
                //                   TextSpan(text: 'সম্মতি দিচ্ছি'),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //
                //       SizedBox(height: 25.0.h),
                //
                //       // Login Button
                //       Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(15.0),
                //           boxShadow: [
                //             BoxShadow(
                //               color: primaryColor.withAlpha(50),
                //               blurRadius: 10.0,
                //               offset: Offset(0, 4),
                //             ),
                //           ],
                //         ),
                //         child: _controller.isLoading.value
                //             ? Center(child: loader())
                //             : primaryButton(
                //           icon: Icons.arrow_forward,
                //
                //           buttonName: 'লগইন করুন',
                //
                //           onTap: () {
                //             if (mobileController.text.isEmpty) {
                //               Get.snackbar(
                //                 'Sorry',
                //                 'Mobile Number is Required',
                //                 colorText: Colors.white,
                //                 backgroundColor: Colors.redAccent,
                //                 snackPosition: SnackPosition.BOTTOM,
                //               );
                //             } else if (mobileController.text.length != 11) {
                //               Get.snackbar(
                //                 'Sorry',
                //                 'Mobile Number must be 11 digits',
                //                 colorText: Colors.white,
                //                 backgroundColor: Colors.redAccent,
                //                 snackPosition: SnackPosition.BOTTOM,
                //               );
                //             } else if (_controller.isChecked.value == false) {
                //               Get.snackbar(
                //                 'Sorry',
                //                 'শর্তাবলি টিক দিন!',
                //                 colorText: Colors.white,
                //                 backgroundColor: Colors.redAccent,
                //                 snackPosition: SnackPosition.BOTTOM,
                //               );
                //             } else {
                //               _controller.registerMethod(
                //                 customerPhone: mobileController.text.trim(),
                //               );
                //             }
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),


                Column(
                  children: [
                    // Mobile Number Field
                    CustomTextFieldWithIcon(
                      label: 'মোবাইল নাম্বার দিন',
                      icon: Icons.phone_android,

                      keyboardType: TextInputType.number,
                      controller: mobileController,
                      hinttext: '০১xxxxxxxxx',

                    ),

                    SizedBox(height: 25.0.h),

                    // Terms & Conditions Checkbox
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withAlpha(10),
                          ),
                          child: Obx(
                                () => Checkbox(
                              value: _controller.isChecked.value,
                              onChanged: (v) {
                                _controller.isChecked.value = v!;
                              },
                              activeColor: primaryColor,
                              checkColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0.w),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14.0.h,
                              ),
                              children: [
                                TextSpan(text: 'আমি '),
                                TextSpan(
                                  text: 'রেজিস্ট্রেশনের শর্তাবলি ',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(
                                            () => QuickTechRegistrationRules(),
                                        transition: Transition.rightToLeft,
                                        duration: Duration(milliseconds: 400),
                                      );
                                    },
                                ),
                                TextSpan(text: 'সম্মতি দিচ্ছি'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 25.0.h),

                    // Login Button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withAlpha(50),
                            blurRadius: 10.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _controller.isLoading.value
                          ? Center(child: loader())
                          : primaryButton(
                        icon: Icons.arrow_forward,

                        buttonName: 'লগইন করুন',

                        onTap: () {
                          if (mobileController.text.isEmpty) {
                            Get.snackbar(
                              'Sorry',
                              'Mobile Number is Required',
                              colorText: Colors.white,
                              backgroundColor: Colors.redAccent,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else if (mobileController.text.length != 11) {
                            Get.snackbar(
                              'Sorry',
                              'Mobile Number must be 11 digits',
                              colorText: Colors.white,
                              backgroundColor: Colors.redAccent,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else if (_controller.isChecked.value == false) {
                            Get.snackbar(
                              'Sorry',
                              'শর্তাবলি টিক দিন!',
                              colorText: Colors.white,
                              backgroundColor: Colors.redAccent,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else {
                            _controller.registerMethod(
                              customerPhone: mobileController.text.trim(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 25.0.h),

                // Benefits Button
                // primaryButton(
                //   buttonName: 'লাইফ ফ্রেন্ড সুবিধাসমূহ',
                //
                //   onTap: () {
                //     Get.to(
                //           () => QuickTechBenefitsScreen(),
                //       transition: Transition.rightToLeft,
                //       duration: Duration(milliseconds: 400),
                //     );
                //   },
                // ),

                SizedBox(height: 30.0.h),

                // Footer Note
                // Center(
                //   child: Text(
                //     "সকল সুবিধা এক অ্যাপেই",
                //     style: TextStyle(
                //       color: Colors.grey.shade600,
                //       fontSize: 13.0.h,
                //       fontStyle: FontStyle.italic,
                //     ),
                //   ),
                // ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
