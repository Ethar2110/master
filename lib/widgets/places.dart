import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceCard extends StatelessWidget {
  final String image;
  final String name;
  final String type;
  final String time;
  final double rating;

  const PlaceCard({
    super.key,
    required this.name,
    required this.image,
    required this.rating,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      margin: EdgeInsets.only(right: 8.w),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              image,
              width: 220.w,
              height: 140.h,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(height: 8.h),
           Row(
              children: [
                Expanded(child: Text(name.tr(), style: TextStyle(fontSize: 18.sp, color: Theme.of(context).textTheme.bodyLarge?.color))),

                Row(
                  children: [
                    Text(rating.toString().tr()),
                    Icon(Icons.star, color: Colors.orange, size: 16.sp),
                  ],
                ),
              ],
            ),

          Row(
            children: [
              Text(type.tr(), style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
              Text(" "),
              Text(time.tr(), style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
