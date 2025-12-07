import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridItem extends StatelessWidget {
  final Color color;
  final String text;
  final String imagePath;
  final textColor;

  const CustomGridItem({
    Key? key,
    required this.color,
    required this.text,
    required this.imagePath,
    required this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5.h,
            left: 10.w,
            child:
             SizedBox(
               width: 70.w,
               child: Text(
                text,
                style: TextStyle(color: textColor, fontSize: 18.sp, fontWeight: FontWeight.bold),
                softWrap: true,
                textAlign: TextAlign.left,
                           ),
             ),
          ),


          Positioned(
            bottom: 0.1.h,
            right: 0.1.w,
            child: Image.asset(
              imagePath,
              width: 80.w,
              height: 80.h,
            ),
          ),
        ],
      ),
    );
  }
}
