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
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text(
       "profile".tr,
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(color: Colors.white, fontSize: 17.0),
        ),
      ),automaticallyImplyLeading: false,),
      body: Obx(() {
        if (_profileController.isLoading.value) {
          return Center(child: loader());
        } else {
          return Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height,
                color: Colors.white,
              ),
              Positioned(
                bottom: 420.h,
                left: 20.h,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 5),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      Urls.getImageURL(
                        endPoint: _profileController.image.toString(),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(110.h, 145.h, 3.h, 0),
                child: GestureDetector(
                  onTap: () async {
                    await Get.to(EditProfilePage(
                      firstName: _profileController.customerName.toString(),
                      lastName: '',
                      address: _profileController.address.toString(),
                      city: _profileController.city.toString(),
                      dob: _profileController.dob.toString(),
                      email: _profileController.email.toString(),
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(200.h, 140.h, 3.h, 0),
                child: Column(
                  children: [
                    Text(
                      _profileController.customerName.toString(),
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      _profileController.phone.toString(),
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 220.h),
                child: Column(
                  children: [
                    Divider(),
                    SizedBox(height: 30),
                    CustomListTile(
                      icons: Icons.alternate_email,
                      title: 'email',
                      content: _profileController.email.toString(),
                    ),
                    CustomListTile(
                      icons: Icons.transgender,
                      title: 'gender',
                      content: _profileController.gender.toString(),
                    ),
                    CustomListTile(
                      icons: Icons.date_range_outlined,
                      title: 'dateOfBirth',
                      content: _profileController.dob.toString(),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
