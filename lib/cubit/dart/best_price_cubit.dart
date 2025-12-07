
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/best_price_item.dart';

class BestPriceCubit extends Cubit<List<BestPriceItem>> {
  BestPriceCubit()
      : super([
    BestPriceItem(
      image: "assets/images/BestPrice/cheescake.webp",
      name: "Cheese cake",
      price: 2.00,
    ),
    BestPriceItem(
      image: "assets/images/BestPrice/Capuccino.jpg",
      name: "Cappuccino",
      price: 1.80,
    ),
    BestPriceItem(
      image: "assets/images/BestPrice/MangoJuice.jpg",
      name: "Mango",
      price: 1.95,
    ),
  ]);

}
