import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:log/models/cart_item.dart';

import '../cubit/dart/cart_cubit.dart';
import '../widgets/BestPriceListView.dart';
import 'home_page.dart';

class DetailsPage extends StatefulWidget {
  final String image;
  final String name;
  final double price;

  const DetailsPage({
    super.key,
    required this.name,
    required this.image,
    required this.price,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          },
          icon: Icon(Icons.keyboard_arrow_left, size: 35.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 400.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(
                top: 10.h,
                left: 18.w,
                right: 18.w,
                bottom: 18.h,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(widget.name, style: TextStyle(fontSize: 30.sp)),
                      Text(
                        ", 110g",
                        style: TextStyle(color: Colors.grey, fontSize: 30.sp),
                      ),
                    ],
                  ),
                  Text(
                    "It’s a sweet dessert made of cream cheese, sugar, and eggs on a base of crushed cookies or graham crackers.",
                  ),

                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Best prices", style: TextStyle(fontSize: 25.sp)),
                  ),
                  SizedBox(height: 15.h),
                  BestPriceList(),
                  SizedBox(height: 15.h),
                  ElevatedButton(
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
                        SnackBar(
                          content: Text("${widget.name} added to cart"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
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
                            "\$${widget.price.toStringAsFixed(2)}",
                            style: TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                          Text(
                            "   |   ",
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            "Add to cart",
                            style: TextStyle(color: Colors.white, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
