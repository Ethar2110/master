import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomGridItem extends StatelessWidget {
  final String text;
  final String imagePath;
  final bool isSpecial;
  final bool isSelected;

  const CustomGridItem({
    super.key,
    required this.text,
    required this.imagePath,
    this.isSpecial = false,
    this.isSelected = false
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color backgroundColor =
    isSpecial
        ? (isSelected ? Colors.orange[800]! : Colors.orange)
        : isDark
        ? (isSelected
        ? Colors.grey[700]!
        : Colors.grey[800]!)
        : (isSelected
        ? Colors.pink[400]!.withOpacity(0.3)
        : Colors.pink[50]!);



    final Color textColor = isSpecial
        ? Colors.white
        : isDark
        ? Colors.white
        : Colors.black;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      transform: isSelected ? Matrix4.identity().scaled(1.03) : Matrix4.identity(),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ]
            : [],
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
