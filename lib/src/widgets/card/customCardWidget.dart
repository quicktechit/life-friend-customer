import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final Widget child;
  final double? elevation;
  final double? height;
  final double? width;
  final Color ? color;

  final void Function()? onTap;

  CustomCardWidget({
    required this.child,
    this.elevation,
    this.height,
    this.width,
    this.onTap,
    this.color
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(

        color: Color.fromRGBO(203, 203, 203, 0.8),
        elevation: .5,
        // elevation: elevation == null ? 5 : elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: height,
          width: width,
          child: child,
          decoration: BoxDecoration(border: Border.all(width: 2,color: color??Colors.grey,),borderRadius: BorderRadius.circular(10),color: Colors.white),
        ),
      ),
    );
  }
}
