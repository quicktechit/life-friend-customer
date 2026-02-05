import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';
class EmptyBoxWidget extends StatelessWidget {
  final String title;
  final String truckImage;

  const EmptyBoxWidget({super.key, required this.title, required this.truckImage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            truckImage
                // == false
                // ? "assets/images/empty.png"
                // : "assets/images/pickup-truck-svgrepo-com.png",
            ,
            width: 140,
          ),
          KText(
            text: title,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
