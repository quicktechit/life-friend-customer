import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/profile%20controllers/profile_get_controller.dart';
import 'package:pickup_load_update/src/pages/profile/profileEditPage.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/custom_list_tile.dart';

import '../../widgets/text/kText.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  ProfilePage({super.key});

  @override
  Widget build(BuildContext conKText) {
    return Scaffold(
      appBar: AppBar(
        title: KText(
          text:"profile".tr,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Obx(() {
        if (_profileController.isLoading.value) {
          return Center(child: loader());
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section with Profile Image
                Container(
                  height: 220.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [primaryColor, primaryColor50],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Profile Image with decorative border
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey.shade200],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  Urls.getImageURL(
                                    endPoint: _profileController.image
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            // Name and Phone with better typography
                            Column(
                              children: [
                                KText(
                                  text: _profileController.customerName
                                      .toString(),
                                ),
                                SizedBox(height: 5.h),
                                KText(
                                  text: _profileController.phone.toString(),

                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Edit Button positioned at top right
                      Positioned(
                        top: 20.h,
                        right: 20.h,
                        child: GestureDetector(
                          onTap: () async {
                            await Get.to(
                              EditProfilePage(
                                firstName: _profileController.customerName
                                    .toString(),
                                lastName: '',
                                address: _profileController.address.toString(),
                                city: _profileController.city.toString(),
                                dob: _profileController.dob.toString(),
                                email: _profileController.email.toString(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                // Profile Information Card
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Section Header
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 20.h,
                          horizontal: 20.h,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor50,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Colors.blue.shade700,
                              size: 24,
                            ),
                            SizedBox(width: 10.h),
                            KText(text: 'personal_info'.tr),
                          ],
                        ),
                      ),

                      // Information List
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Column(
                          children: [
                            _buildInfoTile(
                              icon: Icons.email_outlined,
                              title: 'email',
                              value: _profileController.email.toString(),
                              color: Colors.red.shade400,
                            ),
                            _buildDivider(),
                            _buildInfoTile(
                              icon: Icons.transgender,
                              title: 'gender',
                              value: _profileController.gender.toString(),
                              color: Colors.purple.shade400,
                            ),
                            _buildDivider(),
                            _buildInfoTile(
                              icon: Icons.calendar_today_outlined,
                              title: 'dateOfBirth',
                              value: _profileController.dob.toString(),
                              color: Colors.green.shade400,
                            ),
                            _buildDivider(),
                            _buildInfoTile(
                              icon: Icons.location_on_outlined,
                              title: 'address',
                              value: _profileController.address.toString(),
                              color: Colors.orange.shade400,
                            ),
                            _buildDivider(),
                            _buildInfoTile(
                              icon: Icons.location_city_outlined,
                              title: 'city',
                              value: _profileController.city.toString(),
                              color: Colors.teal.shade400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                // Additional Actions Card
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.h),clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
                        leading: Icon(
                          Icons.settings_outlined,
                          color: Colors.blue.shade700,
                        ),
                        title: KText(
                         text:  'settings'.tr,

                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade500,
                        ),
                        onTap: () {
                          // Navigate to settings
                        },
                      ),
                      Divider(height: 0),
                      ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(20)),
                        leading: Icon(
                          Icons.security_outlined,
                          color: Colors.blue.shade700,
                        ),
                        title: KText(
                         text:  'privacy'.tr,

                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade500,
                        ),
                        onTap: () {
                          // Navigate to privacy
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 100.h),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          SizedBox(width: 15.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                 text:  title.tr,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 4.h),
                KText(
                 text:  value,
                  fontSize: 13.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Divider(height: 1, color: Colors.grey.shade200),
    );
  }
}
