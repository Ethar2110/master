import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/dart/cart_cubit.dart';
import '../models/cart_item.dart';

class BestPrice extends StatefulWidget {
  final String image;
  final String name;
  final double price;

  const BestPrice({
    super.key,
    required this.image,
    required this.price,
    required this.name,
  });

  @override
  State<BestPrice> createState() => _BestPriceState();
}

class _BestPriceState extends State<BestPrice> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.image,
                  width: 120.w,
                  height: 120.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 1.h,
                right: 1.w,
                child: IconButton(
                  onPressed: () {
                    final cartCubit = context.read<CartCubit>();
                    cartCubit.addItem(
                      CartItem(
                        image: widget.image,
                        name: widget.name,
                        price: widget.price,
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${widget.name} added to cart"),backgroundColor: Colors.green,),
                    );
                  },
                  icon: Icon(Icons.add),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: CircleBorder(),
                    iconSize: 16.sp,
                    minimumSize: Size(30.h, 30.w),
                  ),
                ),
              ),
            ],
          ),
          Text(widget.name, style: TextStyle(fontSize: 18.sp)),
          Text(
            "\$${widget.price.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
