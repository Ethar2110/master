import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:log/view/home_page.dart';
import '../cubit/dart/cart_cubit.dart';
import '../cubit/dart/cart_state.dart';
import '../widgets/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int? selectedOption;
  double shippingCost = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Row(
            children: [
              Text("${'cart'.tr()}, ", style: TextStyle(fontSize: 28.sp)),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Text(
                    "${state.items.length} "'${'item'.tr()}',
                    style: TextStyle(color: Colors.grey, fontSize: 28.sp),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 8.0.h),
            child: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false,
                );
              },
              icon: Icon(Icons.close, size: 30.sp),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(child: Text("your_cart_is_empty".tr() , style: TextStyle(fontSize: 20,color: Theme.of(context).textTheme.bodyLarge?.color),));
          }

          return Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "standard_delivery".tr(),
                      style: TextStyle(fontSize: 14.sp,color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: Colors.pink[50],
                      ),
                      child: Text("free".tr(),style: TextStyle(color: Colors.black),),
                    ),
                    // SizedBox(width: 30.w),
                    Spacer(),
                    Radio(
                      value: 1,
                      fillColor: MaterialStateProperty.resolveWith<Color>((
                        state,
                      ) {
                        if (state.contains(MaterialState.selected)) {
                          return Colors.orange;
                        }
                        return Colors.grey;
                      }),
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                          shippingCost = 0.0;
                        });
                      },
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  height: 1,
                  color: Colors.grey[300],
                ),

                Row(
                  children: [
                    Text(
                      "express_delivery".tr(),
                      style: TextStyle(fontSize: 14.sp,color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    Icon(Icons.bolt, color: Colors.orange),
                    SizedBox(width: 15.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: Colors.pink[50],
                      ),
                      child: Text("\$2.00".tr(),style: TextStyle(color: Colors.black),),
                    ),
                    // SizedBox(width: 30.w),
                    Spacer(),
                    Radio(
                      value: 2,
                      fillColor: MaterialStateProperty.resolveWith<Color>((
                        state,
                      ) {
                        if (state.contains(MaterialState.selected)) {
                          return Colors.orange;
                        }
                        return Colors.grey;
                      }),
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value;
                          shippingCost = 2.0;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  height: 1,
                  color: Colors.grey[300],
                ),

                SizedBox(height: 8.h),

                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return CartItemWidget(item: item, index: index);
                    },
                  ),
                ),

                SizedBox(height: 18.h),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Row(
                    children: [
                       Text(
                          "promocode".tr(),
                          style: TextStyle(color: Colors.grey.shade500),
                        ),

                      Spacer(),
                      Text("TASTE2025".tr(),style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),),
                      SizedBox(width: 5.w),
                      Icon(Icons.check, size: 20.sp, color: Colors.orange),
                    ],
                  ),
                  width: 500.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 1.w),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),

                SizedBox(height: 18.h),

                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    double totalPrice =
                        state.items.fold<double>(
                          0,
                          (double sum, item) =>
                              sum + item.price * item.quantity,
                        ) +
                        shippingCost;

                    return ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "\$${totalPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                              ),
                            ),
                            Text(
                              "   |   ",
                              style: TextStyle(
                                color: Colors.grey[200],
                                fontSize: 20.sp,
                              ),
                            ),
                            Text(
                              "confirm_order".tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
