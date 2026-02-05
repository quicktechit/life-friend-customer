import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/date_format.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/offers%20controller/get_offers_controller.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class OfferDetailsPage extends StatelessWidget {
  final OfferController offerController = Get.put(OfferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: 'Offer Details'.tr),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Obx(
          () {
            if (offerController.isLoading.value) {
              return Center(
                child: loader(),
              );
            } else {
              return ListView.builder(
                itemCount: offerController.offerModelData.length,
                itemBuilder: (context, index) {
                  final offerData = offerController.offerModelData[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          Urls.getImageURL(
                              endPoint: offerData.image.toString()),
                          fit: BoxFit.cover,
                          height: 120,
                          width: Get.width,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: KText(
                          text: offerData.name.toString(),
                          textAlign: TextAlign.justify,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer,
                              size: 20,
                              color: Colors.black26,
                            ),
                            KText(
                              text:
                                  ' ${formatDateTime(offerData.createdAt.toString())}',
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            "Details: ${offerData.description.toString()}",
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.fromLTRB(18.0, 5, 18, 0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              KText(
                                text: 'Offer Price:',
                                fontWeight: FontWeight.bold,
                              ),
                              KText(
                                text: " ${offerData.price.toString()} TK",
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
