import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Sizebox height
final sizeH5 = SizedBox(height: 5.h);
final sizeH10 = SizedBox(height: 10.h);
final sizeH20 = SizedBox(height: 20.h);
final sizeH30 = SizedBox(height: 30.h);
final sizeH40 = SizedBox(height: 40.h);
//sizeBox width
final sizeW5 = SizedBox(width: 5.w);
final sizeW10 = SizedBox(width: 10.w);
final sizeW20 = SizedBox(width: 20.w);
final sizeW30 = SizedBox(width: 30.w);
final sizeW40 = SizedBox(width: 40.w);
//Padding

final paddingH20V20 = EdgeInsets.symmetric(horizontal: 20, vertical: 20);
final paddingH10V10 = EdgeInsets.symmetric(horizontal: 10, vertical: 10);
final paddingH20V10 = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
final paddingH10V20 = EdgeInsets.symmetric(horizontal: 10, vertical: 20);
final paddingH20 = EdgeInsets.symmetric(horizontal: 20);
final paddingH10 = EdgeInsets.symmetric(horizontal: 10);
final paddingH5 = EdgeInsets.symmetric(horizontal: 5);
final paddingV10 = EdgeInsets.symmetric(vertical: 10);
final paddingV20 = EdgeInsets.symmetric(vertical: 20);
//

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

final physics = BouncingScrollPhysics();
