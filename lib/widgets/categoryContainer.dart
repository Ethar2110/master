import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridItem extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool isSpecial;

  const CustomGridItem({
    super.key,
    required this.text,
    required this.imagePath,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor = isSpecial
        ? Colors.orange
        : isDark
        ? Colors.grey[800]!
        : Colors.pink[50]!;

    final Color textColor = isSpecial
        ? Colors.white
        : isDark
        ? Colors.white
        : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5.h,
            left: 10.w,
            child: SizedBox(
              width: 70.w,
              child: Text(
                text.tr(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
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
