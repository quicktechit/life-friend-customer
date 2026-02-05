//
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:pickup_load_update/src/configs/appColors.dart';
// import 'package:pickup_load_update/src/configs/appUtils.dart';
// import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';
// import 'package:pickup_load_update/src/widgets/text/kText.dart';
//
// import 'src/controllers/live location controller/live_location_controller.dart';
//
//
// class ReturnTripLocationSelect extends StatelessWidget {
//   ReturnTripLocationSelect({super.key});
//
//   final LocationController locationController = Get.put(LocationController());
//   final TextEditingController pickUpTextController = TextEditingController();
//   final TextEditingController dropTextController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: KText(
//         text: 'রিটার্ন ট্রিপ',
//         color: white,
//         fontSize: 18,
//       ),),
//       body: CustomCardWidget(
//
//           elevation: 0,
//           child: Obx(() => SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 sizeH10,
//                 KText(
//                   text: 'আপনার লোকেশন ও গন্তব্য প্ৰদান করুন',
//                   fontSize: 14,
//                   color: black54,
//                 ),
//                 sizeH20,
//                 SizedBox(
//                   height: 100,
//                   child: Row(
//                     children: [
//                       Column(
//                         children: [
//                           Icon(
//                             Icons.location_pin,
//                             size: 15,
//                           ),
//                           sizeH5,
//                           Container(
//                             height: 50,
//                             width: .5,
//                             color: grey,
//                           ),
//                           sizeH5,
//                           Icon(
//                             Icons.location_pin,
//                             size: 15,
//                           ),
//                         ],
//                       ),
//                       sizeW20,
//                       Expanded(
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 45,
//                               child: TextField(
//                                 controller: pickUpTextController,
//                                 onChanged: (value){
//                                   //  locationController.suggestionsDrop.clear();
//                                   value.isEmpty? locationController.fetchPickSuggestions("Bangladesh")
//                                       : locationController.fetchPickSuggestions(value);
//                                 },
//                                 //  maxLength: 10,
//
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//
//                                     hintText: 'পিকআপ',
//                                     counterText: '',
//                                     //  contentPadding: EdgeInsetsGeometry
//                                     labelStyle: TextStyle(
//                                       color: black54,
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: BorderSide.none
//
//                                     ),
//
//                                     disabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide:  BorderSide.none
//                                     ),
//                                     fillColor: greyBackgroundColor,
//                                     filled: true
//                                 ),
//                                 //  inputFormatters: [LengthLimitingTextInputFormatter(12)],
//                               ),
//                             ),
//                             sizeH10,
//                             SizedBox(
//                               height: 45,
//                               child: TextField(
//                                 controller: dropTextController,
//                                 onChanged: (value){
//                                   //  locationController.suggestionsPickUp.clear();
//                                   value.isEmpty? locationController.fetchDropSuggestions("Bangladesh")
//                                       : locationController.fetchDropSuggestions(value);
//                                 },
//                                 decoration: InputDecoration(
//                                     border: InputBorder.none,
//                                     hintText: 'গন্তব্য',
//                                     // counterText: '',
//                                     //  contentPadding: EdgeInsetsGeometry
//                                     enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide: BorderSide.none
//
//                                     ),
//                                     labelStyle: TextStyle(
//                                       color: black54,
//                                     ),
//                                     disabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                         borderSide:  BorderSide.none
//                                     ),
//                                     fillColor: greyBackgroundColor,
//                                     filled: true
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 sizeH10,
//                 locationController.isLoading.value == true? Center(child: SpinKitDoubleBounce(
//                   color: primaryColor,
//                   size: 50.0,
//                 ),): locationController.suggestionsPickUp.isNotEmpty
//                     ? SizedBox(
//                   height: Get.height,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: locationController.suggestionsPickUp.length,
//                     physics: ScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(locationController.suggestionsPickUp[index].description,),
//                         onTap: () {
//                           pickUpTextController.text = locationController.suggestionsPickUp[index].description;
//                           locationController.selectPikUpAddress(locationController.suggestionsPickUp[index]);
//
//                           locationController.suggestionsPickUp.clear();
//
//                         },
//                       );
//                     },
//                   ),
//                 )
//                     : Container(),
//
//
//
//                 locationController.isLoadingDrop.value == true? Center(child: SpinKitDoubleBounce(
//                   color: primaryColor,
//                   size: 50.0,
//                 ),): locationController.suggestionsDrop.isNotEmpty
//                     ? SizedBox(
//                   height: Get.height,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: locationController.suggestionsDrop.length,
//                     physics: ScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(locationController.suggestionsDrop[index].description,),
//                         onTap: () {
//                           dropTextController.text = locationController.suggestionsDrop[index].description;
//                           locationController.selectDropAddress(locationController.suggestionsDrop[index]);
//
//                           locationController.suggestionsDrop.clear();
//                           Get.back();
//
//                         },
//                       );
//                     },
//                   ),
//                 )
//                     : Container(),
//               ],
//             ),
//           ),)
//       ),
//     );
//   }
// }
