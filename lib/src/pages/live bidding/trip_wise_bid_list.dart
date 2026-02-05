import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../configs/appBaseUrls.dart';
import '../../configs/appColors.dart';
import '../../configs/empty_box_widget.dart';
import '../../controllers/cancel Controller/cancel_controller.dart';
import '../../controllers/live bidding controller/live_bidding_controller.dart';
import '../../controllers/rental trip request controllers/rental_trip_bid_confirm_controller.dart';
import '../../controllers/rental trip request controllers/rental_trip_req_submit_controller.dart';
import '../../controllers/single trip details controller/single_trip_details_controller.dart';
import '../../controllers/truck/truck_controller.dart';
import '../../models/live_bidding_model.dart';
import '../../widgets/button/primaryButton.dart';
import '../../widgets/car_live_bidding_widget.dart';
import '../../widgets/divider_widget.dart';
import '../../widgets/slider/slider_widget.dart';
import '../../widgets/text/kText.dart';
import 'bidding_confirm_screen.dart';

class TripWiseBidList extends StatefulWidget {
  final String id;
  final String amount;
  final List<TripBids> data;
  const TripWiseBidList({super.key, required this.data, required this.id, required this.amount});

  @override
  State<TripWiseBidList> createState() => _TripWiseBidListState();
}

class _TripWiseBidListState extends State<TripWiseBidList> {
  int? selectedCarIndex;
  final pric=TextEditingController();
  var box=GetStorage();
  final CancelController cancelController = Get.put(CancelController());
  final TruckController truckController=Get.find();
  final LiveBiddingController liveBiddingController =
  Get.put(LiveBiddingController());
  final RentalTripSubmitController _rentalTripSubmitController =
  Get.put(RentalTripSubmitController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:"Bid List".text.make()),
        body: RefreshIndicator(
          onRefresh: ()async{
            Future.delayed(Duration(seconds:1),(){
              Get.back();
            });

          },
          child: ListView(
            children: [
              widget.data.isEmpty
                  ? EmptyBoxWidget(
                      title: "noLiveMessage".tr,
                      truckImage: 'assets/images/pickup-truck-svgrepo-com.png',
                    )
                  : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              shrinkWrap: true,
              itemCount: widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                bool isSelected = selectedCarIndex == index;
                final TripBids data = widget.data[index];

                        return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCarIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: isSelected
                          ? Border.all(
                        color: Colors.green,
                        width: 1.5,
                      )
                          : null,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarLiveBiddingContainerWidget2(
                        img: Urls.getImageURL(
                            endPoint: data.getBrand?.image?.toString() ?? ''),
                        carName: data.getBrand?.name?.toString() ??
                            data.getvehicle?.model ??
                            '',
                        capacity:
                        '${data.getBrand?.capacity?.toString() ?? ''} ton',
                        rating: '',
                        fare:
                        'Fare: ${data.amount?.toString() ?? '0'} TK',
                        carNumber:
                        '${data.getvehicle?.metro?.toString() ?? ''}\n${data.getvehicle?.metroNo?.toString() ?? ''}',
                        onTap: () {
                          // Navigate to car details if needed
                        },
                      ),
                    ),
                  ),
                );
              },
            ).h(context.screenHeight/2.5),
            if (selectedCarIndex == null&&widget.amount == "0")
              SizedBox(height: context.screenHeight*0.17,),

            if (selectedCarIndex == null)
             Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.heightBox,
                    Container(
                      width: 150,
                      child: primaryButton(
                          icon: Icons.arrow_circle_right_outlined,
                          buttonName: 'Cancel'.tr,
                          onTap: () {
                            cancelTripRequestReason(
                              context,
                              widget.id.toString(),
                            );
                          }),
                    ),
                    if (widget.amount != "0") 40.heightBox,
                    if (widget.amount != "0")
                      KText(text: 'addmoremoney'),
                    if (widget.amount != "0")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          KText(text: "total"),
                          5.widthBox,
                          "${widget.amount}৳".text
                              .semiBold
                              .lg
                              .make()
                        ],
                      ).paddingSymmetric(horizontal: 20),
                    if (widget.amount != "0") 10.heightBox,
                    if (widget.amount != "0")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            child: TextField(
                              controller: pric,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Enter Amount',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () {
                              Get.back();
                              // Close the modal when Submit is clicked
                              truckController
                                  .sendExtraMoney(
                                  tripId: widget.id,
                                  extendedAmount: pric.text)
                                  .then((value) => {pric.clear()});
                            },
                            child: "Submit".text.white.make(),
                          ),
                        ],
                      ),
                    50.heightBox,
                    DividerWidget(title: 'Ongoing Offer'.tr),
                    20.heightBox,
                    SliderWidget().h(120),
                  ],
                ),


            if (selectedCarIndex != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.screenWidth / 2.2,
                    child: primaryButton(
                      icon: Icons.arrow_circle_right_outlined,
                      buttonName: 'Continue',
                      onTap: () async {
                        if (selectedCarIndex != null &&
                            selectedCarIndex! <
                                  liveBiddingController
                                      .filteredLiveBidDataTruck.length) {
                            var  selectedBidData = widget.data[selectedCarIndex!];

                            final ReturnBidConfirmController confirmController =
                          ReturnBidConfirmController();

                          await confirmController.bidConfirm(
                            bidId: selectedBidData.id.toString(),
                            tripId: selectedBidData.tripId.toString(),
                          );

                          if (confirmController
                              .bidConfirmModel.value.status ==
                              "success") {
                            _rentalTripSubmitController.liveBidTruckStart.value=false;
                            Get.to(() => LiveBiddingConfirmScreen(
                              rentalBidConfirm: confirmController
                                  .bidConfirmModel.value.data!,
                            ));
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: context.screenWidth / 2.2,
                    child: primaryButton(
                        icon: Icons.arrow_circle_right_outlined,
                        buttonName: 'cancel'.tr,
                        onTap: () {
                          cancelTripRequestReason(
                            context,
                            widget.id.toString(),
                          );
                        }),
                  )
                ],
              ),
          ],
                ),
        ));

  }
  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return '$hours hrs $minutes min $seconds sec';
  }

  var isOther = false;

  void cancelTripRequestReason(BuildContext context, String tripId) {
    isOther = false;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          // This allows us to call setState inside the modal
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Cancel trip?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Why do you want to cancel?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                    liveBiddingController.beforeCancelList.length,
                    itemBuilder: (context, index) {
                      var item =
                      liveBiddingController.beforeCancelList[index];
                      return ListTile(
                        leading: Icon(Icons.no_crash),
                        title: Text(item.title.toString()),
                        onTap: () {
                          if (item.id == 14) {
                            // Update the state to show the "Other" input
                            setModalState(() {
                              isOther = true;
                            });
                          } else {
                            cancelController.sendBeforeCancel(
                                tripId, item.id.toString());
                          }
                        },
                      );
                    },
                  ),
                  if (isOther)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter text',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Close the modal when Submit is clicked
                            cancelController.sendBeforeCancel(tripId, '14');
                          },
                          child: Text("Submit"),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Keep my trip"),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}
