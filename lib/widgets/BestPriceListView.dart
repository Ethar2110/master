import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/dart/best_price_cubit.dart';
import '../models/best_price_item.dart';
import '../view/datailsPage.dart';
import 'best_price.dart';

class BestPriceList extends StatefulWidget {
  const BestPriceList({super.key});

  @override
  State<BestPriceList> createState() => _BestPriceListState();
}

class _BestPriceListState extends State<BestPriceList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: BlocBuilder<BestPriceCubit, List<BestPriceItem>>(
        builder: (context, bestPrices) {
          return ListView.builder( // <- must RETURN this
            scrollDirection: Axis.horizontal,
            itemCount: bestPrices.length,
            itemBuilder: (context, index) {
              final item = bestPrices[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        image: item.image,
                        name: item.name,
                        price : item.price,
                      ),
                    ),
                  );
                },
                child:  BestPrice(
                    image: item.image,
                    price: item.price,
                    name: item.name,
                  ),

              );
            },
          );
        },
      ),
    );
  }
}
