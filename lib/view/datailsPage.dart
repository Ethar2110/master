import 'package:easy_localization/easy_localization.dart';
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
        leading:
        Builder(
        builder: (context)
    {
      return
        IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false,
            );
          },
          icon: Icon(context.locale.languageCode == 'ar'
              ? Icons.keyboard_arrow_right
              : Icons.keyboard_arrow_left,
              size: 35.sp, color: Colors.white),
        );

    }
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
                      Text(widget.name, style: TextStyle(fontSize: 30.sp,color: Theme.of(context).textTheme.bodyLarge?.color)),
                      Text(
                        ", 110g".tr(),
                        style: TextStyle(color: Colors.grey, fontSize: 30.sp),
                      ),
                    ],
                  ),
                  Text(
                    "dessert_description".tr(),
                  ),

                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("best_prices".tr(), style: TextStyle(fontSize: 25.sp,color: Theme.of(context).textTheme.bodyLarge?.color)),
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

                      final messenger = ScaffoldMessenger.of(context);
                      messenger.hideCurrentSnackBar();
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text("${widget.name} " '${'added_to_cart'.tr()} '),
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
                            "\$${widget.price.toStringAsFixed(2)}".tr(),
                            style: TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                          Text(
                            "   |   ".tr(),
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 20.sp,
                            ),
                          ),
                          Text(
                            "add_to_cart".tr(),
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
