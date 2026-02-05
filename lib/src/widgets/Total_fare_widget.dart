import 'package:flutter/material.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class TotalFareWidget extends StatelessWidget {
  final String totalFare;
  final String cusotmerBid;
  final String insuranceFee;
  const TotalFareWidget(
      {super.key,
      required this.totalFare,
      required this.cusotmerBid,
       required this.insuranceFee});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KText(
            text: 'Total Fare :',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          KText(
            text: totalFare,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
      children: <Widget>[
        ListTile(
          title: KText(
            text: 'Your Bid',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          trailing: Text(
            cusotmerBid,
            style: TextStyle(fontSize: 14),
          ),
        ),
        ListTile(
          title: KText(
            text: 'Insurance  Fee',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          trailing: Text(
            insuranceFee,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
