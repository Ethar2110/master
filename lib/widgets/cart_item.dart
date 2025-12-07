import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/dart/cart_cubit.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final int index;

  const CartItemWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.read<CartCubit>();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              item.image,
              width: 120.w,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(item.name, style: TextStyle(fontSize: 20.sp)),
                    Text(
                      ",230g",
                      style: TextStyle(fontSize: 20.sp, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                      Text(
                        "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 18.sp, color: Colors.orange),
                      ),


                    Spacer(),



                       Container(
                         padding: EdgeInsets.symmetric(horizontal: 2.w),

                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.pink[50],
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(

                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, size: 15.sp),
                                onPressed: () => cartCubit.decreaseQuantity(index),
                              ),
                              Text(
                                item.quantity.toString(),
                                style: TextStyle(fontSize: 12.sp),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, size: 15.sp),
                                onPressed: () => cartCubit.increaseQuantity(index),
                              ),
                            ],
                          ),
                        ),


                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
