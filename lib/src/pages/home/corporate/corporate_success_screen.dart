import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../widgets/text/kText.dart';

class CorporateSuccessScreen extends StatelessWidget {
  const CorporateSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KText(
              text: 'Please Wait for Admin Approval!!',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            Lottie.asset('assets/animations/success.json',repeat: false),

          ],
        ),
      ),
    );
  }
}
