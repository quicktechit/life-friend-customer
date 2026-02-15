import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appBaseUrls.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/slider%20controller/slider_controller.dart';
import 'package:pickup_load_update/src/models/slider_model.dart';

class SliderWidget extends StatelessWidget {
  final SliderController controller = Get.put(SliderController());

  SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sliderData = controller.sliderData;

      if (controller.isLoading.value) {
        return Center(child: loader());
      } else if (sliderData.isEmpty) {
        return Center(child: Text('No images available'));
      } else {
        return CarouselSlider.builder(
          itemCount: sliderData.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final SliderData data = sliderData[index];
            // log(Urls.getImageURL(endPoint: data.image ?? ''));
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                Urls.getImageURL(endPoint: data.image ?? ''),
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Icon(Icons.image_not_supported),
                    ),
                  );
                },
              ),
            );
          },
          options: CarouselOptions(
            height: 160,
            viewportFraction: 1,
            pageSnapping: true,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        );
      }
    });
  }
}
