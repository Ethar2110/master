
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/best_price_item.dart';

class BestPriceCubit extends Cubit<List<BestPriceItem>> {
  BestPriceCubit()
      : super([
    BestPriceItem(
      image: "assets/images/BestPrice/cheescake.webp",
      name: "cheese_cake",
      price: 2.00,
    ),
    BestPriceItem(
      image: "assets/images/BestPrice/Capuccino.jpg",
      name: "cappuccino",
      price: 1.80,
    ),
    BestPriceItem(
      image: "assets/images/BestPrice/MangoJuice.jpg",
      name: "mango",
      price: 1.95,
    ),
  ]);

}
