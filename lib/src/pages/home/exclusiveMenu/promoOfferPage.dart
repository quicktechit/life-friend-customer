import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/date_format.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/promo%20code%20controller/get_promo_code_controller.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class PromoOfferPage extends StatelessWidget {
  final PromoController promoController = Get.put(PromoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(appbarTitle: 'promoCode'),
      body: Obx(
        () => promoController.isLoading.value
            ? Center(child: loader())
            : Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: promoController.promoData.isEmpty
                        ? Center(
                            child: KText(
                              text: 'No promo codes available yet!',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : ListView.builder(
                            itemCount: promoController.promoData.length,
                            itemBuilder: (context, index) {
                              var promoData = promoController.promoData[index];
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      KText(
                                        text: 'Name of Promo Code: ',
                                        fontWeight: FontWeight.bold,
                                      ),
                                      KText(
                                        text: promoData.name ?? '',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      KText(
                                        text: "Date: ",
                                        fontWeight: FontWeight.bold,
                                      ),
                                      KText(
                                        text: formatDateTime(
                                            promoData.createdAt.toString()),
                                      ),
                                    ],
                                  ),
                                  Divider()
                                ],
                              );
                            },
                          ),
                  ),
                ),
              ),
      ),
    );
  }
}
