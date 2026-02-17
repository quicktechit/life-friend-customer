import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/controllers/truck/truck_controller.dart';
import 'package:pickup_load_update/src/widgets/loader_util.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/division controller/division_controller.dart';
import '../../../controllers/live location controller/live_location_controller.dart';
import '../../../models/truck_related_model/product_type_model.dart';
import '../../../widgets/text/custom_text_filed_widget.dart';
import '../../../widgets/text/kText.dart';

class ShippingDetails extends StatefulWidget {
  const ShippingDetails({super.key});

  @override
  State<ShippingDetails> createState() => _ShippingDetailsState();
}

class _ShippingDetailsState extends State<ShippingDetails> {
  final TruckController truckController = Get.find();
  final LocationController locationController = Get.put(LocationController());
  String? selectedValue;
  String promoCode = '';
  final DivisionController divisionController = Get.put(DivisionController());
  final TextEditingController addPromoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: KText(
          text: 'Extra details',
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizeH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/to-do-list.png',
                          width: 19,
                          color: Colors.grey.shade800,
                        ),
                        10.widthBox,
                        "Product type".tr.text.lg.semiBold.black.make()
                      ],
                    ).paddingSymmetric(horizontal: 14),
                    10.heightBox,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      height: 40.h,
                      color: Colors.grey.shade200,
                      child: DropdownButton<Datas>(
                        underline: SizedBox(),
                        isExpanded: true,
                        value: truckController.selectedCategory.value,
                        hint: Text('select'.tr),
                        onChanged: (Datas? newCategory) {
                          truckController.index = -1;
                          truckController.selectedCategory.value = newCategory;
                        },
                        items: truckController.product
                            .map<DropdownMenuItem<Datas>>((Datas category) {
                          return DropdownMenuItem<Datas>(
                            value: category,
                            child: Text(category.name ?? 'Unknown'),
                          );
                        }).toList(),
                      ),
                    ).paddingSymmetric(horizontal: 14),
                    10.heightBox,
                    GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 5.5,
                        ),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return truckController.product[index].nameBn
                              .toString()
                              .text
                              .normal
                              .makeCentered()
                              .box
                              .p4
                              .color(truckController.index == index
                                  ? Colors.orange
                                  : Colors.transparent)
                              .border(color: Colors.black87, width: 0.7)
                              .roundedLg
                              .make()
                              .onTap(() {
                            truckController.index = index;
                            truckController.selectedCategory.value =
                                truckController.product[index];
                          });
                        }).paddingSymmetric(horizontal: 14),
                    10.heightBox,
                    "product"
                        .tr
                        .text
                        .black
                        .make()
                        .paddingSymmetric(horizontal: 14),
                    3.heightBox,
                    TextField(
                      controller: truckController.productDetails,
                      onChanged: (value) {
                        truckController.validateInput(value);
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'write'.tr),
                    )
                        .box
                        .color(Vx.gray300)
                        .alignCenter
                        .padding(const EdgeInsets.symmetric(horizontal: 10))
                        .make()
                        .paddingSymmetric(horizontal: 14),
                    10.heightBox,
                    const Divider(
                      color: Colors.black38,
                      thickness: 7,
                    ),
                    Obx(
                      () => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: truckController.service.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              contentPadding: const EdgeInsets.only(left: 10),
                              title: truckController.service[index].nameBn
                                  .toString()
                                  .text
                                  .size(14)
                                  .make(),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // listPrice[index].text.size(14).make(),
                                  Checkbox(
                                    value: truckController
                                        .checkboxStates[index].value,
                                    onChanged: (bool? newValue) {
                                      setState(() {});

                                      final id =
                                          truckController.service[index].id;
                                      truckController.checkboxStates[index]
                                          .value = newValue!;
                                      final title =
                                          truckController.service[index].nameBn;
                                      log(id.toString());
                                      if (id != null) {
                                        if (newValue) {
                                          truckController.checkedIds.add(id);

                                          truckController.checkedTitle
                                              .add(title.toString());
                                        } else {
                                          truckController.checkedIds.remove(id);
                                          truckController.checkedTitle
                                              .remove(title.toString());
                                        }
                                      }
                                      // final applyExtra = truckController.checkedIds.contains(35);
                                      final applyExtra = truckController.checkedTitle.contains('আপ-ডাউন ট্রিপ');
                                      truckController.updateSubtotal(applyExtra);

                                      log(truckController.subtotal.value.toString());
                                      log(truckController.totalPrice.toString());
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const Divider(
                      color: Colors.black38,
                      thickness: 7,
                    ),
                    // ListTile(
                    //   dense: true,
                    //   contentPadding: const EdgeInsets.only(left: 10),
                    //   title: 'লেবার লাগবে'.text.size(14).make(),
                    //   trailing: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       'কোটেশন'.text.make(),
                    //       Checkbox(
                    //         value: truckController.isLaber.value,
                    //         onChanged: (bool? newValue) {
                    //           setState(() {
                    //             truckController.isLaber.value = newValue!;
                    //           });
                    //         },
                    //       )
                    //     ],
                    //   ),
                    // ),
                    const Divider(
                      color: Colors.black38,
                      thickness: 7,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/taka.png',
                  width: 14,
                ),
                7.widthBox,
                "Total Amount:".tr.text.black.make(),
                const Spacer(),
                "৳ ${truckController.totalPriceNew==""?truckController.totalPrice:truckController.totalPriceNew}".text.bold.size(14).make()
              ],
            ).paddingSymmetric(horizontal: context.screenWidth * 0.05),
            15.heightBox,
            TextButton(
                    onPressed: () {
                      if (truckController.selectedCategory.value == null) {
                        VxToast.show(context, msg: 'Select Product Type');
                        return;
                      }

                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            width: Get.width,
                            height: 600.h,
                            padding: EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      height: 3,
                                      width: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Center(
                                      child: Image.network(
                                    Urls.getImageURL(
                                        endPoint: truckController.image),
                                    height: 50,
                                    width: 50,
                                  )),
                                  Center(
                                    child: Text(
                                      truckController.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        truckController.selectedTime
                                            .format(context),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        DateFormat('MMMM dd, yyyy')
                                            .format(truckController.selectedDate),
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  sizeH10,
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: primaryColor),
                                              child: Icon(
                                                Icons.arrow_upward,
                                                size: 12,
                                                color: Colors.white,
                                              )),
                                          Container(
                                            height: 30,
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          Container(
                                              padding: EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.green),
                                              child: Icon(
                                                Icons.arrow_downward,
                                                size: 12,
                                                color: Colors.white,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                                  text: locationController
                                                      .pickUpLocation.value,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)
                                              .w(context.screenWidth / 1.6),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          for (var location
                                              in truckController.locationNames)
                                            KText(
                                                    text: location,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold)
                                                .w(context.screenWidth / 1.6),
                                        ],
                                      )
                                    ],
                                  ),
                                  sizeH10,
                                  Divider(
                                    height: 1,
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  sizeH10,
                                  Row(
                                    children: [
                                      Text(
                                        truckController
                                            .selectedCategory.value!.name
                                            .toString(),
                                        style: TextStyle(color: Colors.grey),
                                      )
                                          .box
                                          .border(color: Colors.black87)
                                          .rounded
                                          .padding(EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2))
                                          .make(),
                                      10.widthBox,
                                      Expanded(
                                          child: truckController
                                              .productDetails.text.text.black
                                              .maxLines(2)
                                              .overflow(TextOverflow.ellipsis)
                                              .make())
                                    ],
                                  ),
                                  sizeH10,
                                  // for (var name in truckController.checkedTitle)
                                  //   "$name"
                                  //       .text.color(Colors.grey)
                                  //       .make()
                                  //       .box
                                  //       .border(color: Colors.black87)
                                  //       .rounded
                                  //       .padding(EdgeInsets.symmetric(
                                  //           horizontal: 5, vertical: 2))
                                  //       .make(),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children:
                                        truckController.checkedTitle.map((name) {
                                      return "$name"
                                          .text
                                          .color(Colors.grey)
                                          .make()
                                          .box
                                          .border(color: Colors.black87)
                                          .rounded
                                          .padding(EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2))
                                          .make();
                                    }).toList(),
                                  ),
                                  sizeH10,
                                  if (truckController.isLaber.value)
                                    "লেবার লাগবে"
                                        .text
                                        .color(Colors.grey)
                                        .make()
                                        .box
                                        .border(color: Colors.black87)
                                      .rounded
                                      .padding(EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 2))
                                        .make(),
                                  sizeH10,
                                  Divider(
                                    thickness: 3,
                                  ),
                                  sizeH10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'rent'.tr,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        '${truckController.totalPriceNew!=''?truckController.totalPriceNew:truckController.totalPrice}'.tr,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  sizeH10,
                                  Divider(
                                    thickness: 3,
                                  ),
                                  sizeH10,
                                  Text(
                                    'Payment Method'.tr,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text(
                                    'Cash',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  15.heightBox,
                                  Container(
                                    color: white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 15,
                                      ),
                                      child: Row(
                                        children: [
                                          if (promoCode == '')
                                            KText(
                                              text: 'noPromoAdded',
                                              fontSize: 11,
                                              color: black54,
                                              fontWeight: FontWeight.w600,
                                            ),
                                         20.heightBox,
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      'addPromoCode'.tr,
                                                      style:
                                                          TextStyle(fontSize: 10),
                                                    ),
                                                    content: Container(
                                                      width: 300.w,
                                                      height: 100,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          CustomTextFieldWithIcon(
                                                            label: 'add code'.tr,
                                                            icon: Icons.password,
                                                            controller:
                                                                addPromoController,
                                                            hinttext:
                                                                "promoCode".tr,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('close'.tr),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            promoCode =
                                                                addPromoController
                                                                    .text;
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text('Apply'.tr),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue.shade50,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 5,
                                                ),
                                                child: Row(
                                                  children: [
                                                    if (promoCode == '')
                                                      Icon(
                                                        Icons.add,
                                                        size: 20,
                                                        color: Colors.blue,
                                                      ),
                                                    KText(
                                                      text: promoCode == ''
                                                          ? 'addPromoCode'
                                                          : promoCode,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Colors.blue,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                 20.heightBox,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.money,
                                            size: 18,
                                          ),
                                          sizeW5,
                                          Text(
                                            'Total'.tr,
                                            style: TextStyle(
                                                fontSize: 14, color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${truckController.totalPriceNew}'.tr,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          sizeW5,
                                          Icon(
                                            Icons.error_outline,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  sizeH20,
                                 Obx(() =>  TextButton(
                                     onPressed: () async {
                                       truckController.isLoading.value? debugPrint(''):  truckController.sendRequest(
                                         categoryId: '1',
                                         sizeCategoryId:
                                         truckController.sizeId,
                                         truckType:
                                         truckController.truck_type,
                                         vehicleId: truckController.id,
                                         pickupLocation: locationController
                                             .pickUpLocation.value,
                                         dateTime:
                                         "${DateFormat('yyyy-MM-dd').format(truckController.selectedDate)} ${truckController.selectedTime.format(context)}",
                                         map:
                                         "${locationController.selectedPickUpLat} ${locationController.selectedPickUpLng}",
                                         productType:
                                         "${truckController.selectedCategory.value?.id.toString()}",
                                         productDetails: truckController
                                             .productDetails.text,
                                         isLabour:
                                         truckController.isLaber.value,
                                         distance:
                                         truckController.distances.value,
                                         amount: truckController
                                             .totalPrice ==
                                             "Bid"
                                             ? "0"
                                             : truckController.totalPriceNew!=''?truckController.totalPriceNew:truckController.totalPrice,
                                         pickupDivision: locationController.pickupDivision.value,
                                         // dropOfDivision: "${divisionController.selectedDropDivision.value?.id}",
                                         tripService:
                                         truckController.checkedIds,
                                         multipleDropoffLocation:
                                         truckController.locationNames,
                                         multipleDropoffMap: truckController
                                             .multipleDropoffMap,
                                       );
                                     },
                                     child:
                                     truckController.isLoading.value? CircularProgressIndicator(): "trip confirm".tr.text.white.make())
                                     .box
                                     .width(context.screenWidth / 1.2)
                                     .color(primaryColor)
                                     .rounded
                                     .makeCentered(),)
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: "go next".tr.text.white.make())
                .box
                .width(context.screenWidth / 1.2)
                .color(primaryColor)
                .rounded
                .makeCentered(),
            20.heightBox,

          ],
        ),
      ),
    );
  }
}
