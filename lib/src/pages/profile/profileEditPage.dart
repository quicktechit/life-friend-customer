import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pickup_load_update/src/components/bottom%20navbar/bottom.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/profile%20controllers/edit_profile_controllers.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/button/primaryButton.dart';
import 'package:pickup_load_update/src/widgets/custom_form_widget.dart';
import 'package:pickup_load_update/src/widgets/image%20capture%20widget/image_capture_widget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class EditProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String address;
  final String city;
  final String dob;
  final String email;
  final String? image;

  EditProfilePage({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.dob,
    required this.email,
    this.image,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? firstNameTextC;
  TextEditingController? lastNameTextC;
  TextEditingController? addressTextC;
  TextEditingController? emailTextC;
  TextEditingController? cityTextC;
  TextEditingController? dateOfBirthTextC;

  String? selectedItem = 'male';
  XFile? profileImage;

  @override
  void initState() {
    super.initState();
    firstNameTextC = TextEditingController(text: widget.firstName);
    lastNameTextC = TextEditingController(text: widget.lastName);
    addressTextC = TextEditingController(text: widget.address);
    emailTextC = TextEditingController(text: widget.email);
    cityTextC = TextEditingController(text: widget.city);
    dateOfBirthTextC = TextEditingController(text: widget.dob);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          'updateProfile'.tr,
          style: GoogleFonts.ubuntu(
            fontSize: 20,color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(13),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          child: Column(
            children: [
              // Profile Image Section
              Container(
                margin: EdgeInsets.only(bottom: 30.h),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Profile Image Container
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: widget.image != null && profileImage == null
                            ? Image.network(
                          Urls.getImageURL(endPoint: widget.image!),
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(primaryColor),
                              ),
                            );
                          },
                        )
                            : profileImage != null
                            ? Image.file(
                          File(profileImage!.path),
                          fit: BoxFit.cover,
                        )
                            : Container(
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),

                    // Change Photo Button
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _showImageSourceDialog(),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Tap to change text
              GestureDetector(
                onTap: () => _showImageSourceDialog(),
                child: Text(
                  'tap_to_change_photo'.tr,
                  style: GoogleFonts.ubuntu(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // Form Fields Card
              Container(
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
                child: Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Column(
                    children: [
                      // Name Section
                      _buildFormField(
                        icon: Icons.person_outline,
                        label: 'firstName'.tr,
                        controller: firstNameTextC!,
                        isRequired: true,
                        keyboardType: TextInputType.name,
                      ),

                      SizedBox(height: 20.h),

                      // Email Section
                      _buildFormField(
                        icon: Icons.email_outlined,
                        label: 'email'.tr,
                        controller: emailTextC!,
                        isRequired: false,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(height: 20.h),

                      // Address Section
                      _buildFormField(
                        icon: Icons.location_on_outlined,
                        label: 'address'.tr,
                        controller: addressTextC!,
                        isRequired: false,
                        keyboardType: TextInputType.streetAddress,
                      ),

                      SizedBox(height: 20.h),

                      // City Section
                      _buildFormField(
                        icon: Icons.location_city_outlined,
                        label: 'city'.tr,
                        controller: cityTextC!,
                        isRequired: false,
                        keyboardType: TextInputType.text,
                      ),

                      SizedBox(height: 20.h),

                      // Date of Birth Section
                      _buildDateOfBirthField(),

                      SizedBox(height: 20.h),

                      // Gender Selection
                      _buildGenderSelection(),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // Action Buttons
              Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor.withAlpha(150), width: 2),
                      ),
                      child: TextButton(
                        onPressed: () => Get.back(),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'cancel'.tr,
                          style: GoogleFonts.ubuntu(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 15.h),

                  // Update Button
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor,
                          primaryColor,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withAlpha(50),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => _updateProfile(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'update'.tr,
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required bool isRequired,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: 8.h),
            Text(
              label,
              style: GoogleFonts.ubuntu(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: GoogleFonts.ubuntu(
              fontSize: 16,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 14.h,
              ),
              border: InputBorder.none,
              hintStyle: GoogleFonts.ubuntu(
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateOfBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: 8.h),
            Text(
              'dateOfBirth'.tr,
              style: GoogleFonts.ubuntu(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _selectDate(),
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    dateOfBirthTextC!.text.isNotEmpty
                        ? dateOfBirthTextC!.text
                        : 'select_date'.tr,
                    style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      color: dateOfBirthTextC!.text.isNotEmpty
                          ? Colors.black
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_month,
                  color: Colors.blue.shade700,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.transgender,
              color: primaryColor,
              size: 20,
            ),
            SizedBox(width: 8.h),
            Text(
              'gender'.tr,
              style: GoogleFonts.ubuntu(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildGenderOption(
                value: 'male',
                label: 'male'.tr,
                icon: Icons.male,
                color: Colors.blue.shade700,
              ),
            ),
            SizedBox(width: 15.h),
            Expanded(
              child: _buildGenderOption(
                value: 'female',
                label: 'female'.tr,
                icon: Icons.female,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = value;
        });
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: selectedItem == value
              ? color.withOpacity(0.1)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedItem == value ? color : Colors.grey.shade300,
            width: selectedItem == value ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selectedItem == value ? color : Colors.grey.shade500,
              size: 30,
            ),
            SizedBox(height: 5.h),
            Text(
              label,
              style: GoogleFonts.ubuntu(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: selectedItem == value ? color : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('select_source'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue.shade700),
              title: Text('take_photo'.tr),
              onTap: () async {
                Get.back();
                // Implement camera functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.blue.shade700),
              title: Text('choose_from_gallery'.tr),
              onTap: () async {
                Get.back();
                // Implement gallery picker
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue.shade700,
            colorScheme: ColorScheme.light(primary: Colors.blue.shade700),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        dateOfBirthTextC!.text = formattedDate;
      });
    }
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      EditProfileController().editProfileMethod(
        name: firstNameTextC!.text,
        email: emailTextC!.text,
        address: addressTextC!.text,
        city: cityTextC!.text,
        gender: selectedItem!,
        dob: dateOfBirthTextC!.text,
        image: profileImage,
      );
      Get.offAll(() => DashboardView());
    }
  }
}
