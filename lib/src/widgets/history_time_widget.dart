import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class HistoryTimeWidget extends StatelessWidget {
  final String date;
  const HistoryTimeWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KText(
          text: date,
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}
