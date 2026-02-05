import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pickup_load_update/src/widgets/text/kText.dart';

class CorporatePaymentScreen extends StatelessWidget {
  const CorporatePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Payment ",
          style: TextStyle(color: Colors.white, fontSize: 17.h),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.pink,),
              height: 32.h,child: Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(text: 'Bkash',fontWeight: FontWeight.bold,),
                  SizedBox(width: 10.w,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/images/bkash.png'))
                ],
              ),),),
          SizedBox(height: 10.h,),

          SizedBox(height: 10.h,),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color.fromRGBO(241, 94,34, 1),),
            height: 32.h,child: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KText(text: 'Nagad',fontWeight: FontWeight.bold,),
              SizedBox(width: 10.w,),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/nagad.png'))
            ],
          ),),),
          SizedBox(height: 10.h,),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color.fromRGBO(135, 50,143, 1),),
            height: 32.h,child: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KText(text: 'Rocket',fontWeight: FontWeight.bold,),
              SizedBox(width: 10.w,),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/rocket.png'))
            ],
          ),),),
        ],),
      ),
    );
  }
}
