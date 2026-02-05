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
        child: Padding(
          padding: EdgeInsets.all(15.0.h),
          child: Obx(() {
            return Column(
              children: [
                SizedBox(height: 80.h),
                Image.asset(
                  'assets/images/Login_Page_Vector.png',
                  width: 500,
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    "লাইফ ফ্রেন্ড স্মার্ট অ্যাপ \nএ আপনাকে স্বাগতম",
                    style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0.h,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Please input your Mobile Number to Continue",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 22.h),
                CustomTextFieldWithIcon(
                  label: 'মোবাইল নাম্বার দিন',
                  icon: Icons.call,
                  keyboardType: TextInputType.number,
                  controller: mobileController,
                  hinttext: '০১xxxxxxx',
                ),
                SizedBox(height: 20.h),
                Container(
                  color: bgColor,
                  child: _controller.isLoading.value
                      ? loader()
                      : primaryButton(
                          icon: Icons.arrow_forward,
                          buttonName: 'লগইন করুন',
                          onTap: () {

                            if (mobileController.text.isEmpty) {
                              Get.snackbar('Sorry', 'Mobile Number is Required',
                                  colorText: white,
                                  backgroundColor: Colors.redAccent);
                            } else if (mobileController.text.length != 11) {
                              Get.snackbar(
                                  'Sorry', 'Mobile Number must be 11 digits',
                                  colorText: white,
                                  backgroundColor: Colors.redAccent);
                            }
                            else if(_controller.isChecked.value == false){
                              Get.snackbar(
                                  'Sorry', 'শর্তাবলি টিক দিন!',
                                  colorText: white,
                                  backgroundColor: Colors.redAccent);
                            }
                            else {
                              _controller.registerMethod(
                                  customerPhone: mobileController.text.trim());

                            }
                          },
                        ),
                ),
                SizedBox(height: 20.h),
                primaryButton(
                    buttonName: 'লাইফ ফ্রেন্ড সুবিধাসমূহ',
                    onTap: () {
                      Get.to(
                        () => QuickTechBenefitsScreen(),
                        transition: Transition.rightToLeft,
                        duration: Duration(milliseconds: 400),
                      );
                    }),
                sizeH10,
                Row(
                  children: [
                    Obx(() => Checkbox(value: _controller.isChecked.value, onChanged: (v){
                        _controller.isChecked.value = v!;
                    }),),
                    Text('আমি '),
                    GestureDetector(
                        onTap: (){
                          Get.to(()=>QuickTechRegistrationRules(), transition: Transition.rightToLeft,
                            duration: Duration(milliseconds: 400),);
                        },
                        child: Text('রেজিস্ট্রেশনের শর্তাবলি ',style: TextStyle(color: primaryColor,decoration: TextDecoration.underline),)),
                    Text('সম্মতি দিচ্ছি')
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
