import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  EditProfilePage(
      {required this.firstName,
      required this.lastName,
      required this.address,
      required this.city,
      required this.dob,
      required this.email,
      this.image});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
      appBar: CustomAppBar(
        appbarTitle: 'updateProfile',
      ),
      body: Padding(
        padding: paddingH20,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      if (widget.image == null)
                        ImageCaptureWidget(
                          onImageCaptured: (XFile? image) {
                            setState(() {
                              profileImage = image;
                            });
                          },
                          text: 'pickImageMessage'.tr,
                          icon: Icons.person,
                        ),
                      if (widget.image != null)
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              Urls.getImageURL(endPoint: widget.image!)),
                        ),
                    ],
                  ),
                ],
              ),
              sizeH30,
              Row(
                children: [
                  Expanded(
                    child: CustomForm(
                      title: 'firstName'.tr,
                      requiredStar: '*',
                      controller: firstNameTextC!,
                    ),
                  ),

                ],
              ),
              sizeH30,
              CustomForm(
                title: 'address'.tr,
                requiredStar: '',
                controller: addressTextC!,
              ),
              sizeH30,
              CustomForm(
                title: 'city'.tr,
                requiredStar: '',
                controller: cityTextC!,
              ),
              sizeH30,
              CustomForm(
                title: 'email'.tr,
                requiredStar: '',
                controller: emailTextC!,
              ),
              sizeH30,
              CustomForm(
                title: 'dateOfBirth',
                requiredStar: '',
                controller: dateOfBirthTextC!,
              ),
              sizeH30,
              Row(
                children: [
                  KText(
                    text: 'gender',
                    color: black54,
                  ),
                  KText(
                    text: '*',
                    color: primaryColor,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => primaryColor),
                        focusColor: MaterialStateColor.resolveWith(
                            (states) => primaryColor),
                        value: 'male',
                        groupValue: selectedItem,
                        onChanged: (String? value) {
                          setState(() {
                            selectedItem = value;
                            print(selectedItem);
                          });
                        },
                      ),
                      KText(text: 'male'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => primaryColor),
                        focusColor: MaterialStateColor.resolveWith(
                            (states) => primaryColor),
                        value: 'female',
                        groupValue: selectedItem,
                        onChanged: (String? value) {
                          setState(() {
                            selectedItem = value;
                            print(selectedItem);
                          });
                        },
                      ),
                      KText(text: 'female'),
                    ],
                  ),
                ],
              ),
              sizeH20,
              primaryButton(
                buttonName: 'update',
                onTap: () {
                  EditProfileController().editProfileMethod(
                    name: firstNameTextC!.text,
                    email: emailTextC!.text,
                    address: addressTextC!.text,
                    city: cityTextC!.text,
                    gender: selectedItem!,
                    dob: dateOfBirthTextC!.text,
                    image: profileImage??null,
                  );
                  Get.offAll(() => DashboardView());
                },
              ),
              sizeH20,
            ],
          ),
        ),
      ),
    );
  }
}
