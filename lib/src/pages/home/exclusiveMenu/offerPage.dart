import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/configs/date_format.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/offers%20controller/get_offers_controller.dart';
import 'package:pickup_load_update/src/pages/home/exclusiveMenu/offer_details_page.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class OfferPage extends StatelessWidget {
  final OfferController offerController = Get.put(OfferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appbarTitle: 'offer'.tr),
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
                  return GestureDetector(
                    onTap: () {
                    Get.to(()=>OfferDetailsPage());
                    },
                    child: CustomCardWidget(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          sizeH10,
                          Padding(
                            padding: paddingH20,
                            child: KText(
                              text: offerData.name.toString(),
                              textAlign: TextAlign.justify,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: paddingH20,
                            child: KText(
                              text: offerData.description.toString(),
                              color: black45,
                              fontSize: 14,
                            ),
                          ),
                          sizeH10,
                          Padding(
                            padding: paddingH20,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 20,
                                  color: Colors.black26,
                                ),
                                KText(
                                  text:
                                      ' ${formatDateTime(offerData.createdAt.toString())}',
                                  color: black54,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                          sizeH20,
                        ],
                      ),
                    ),
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
