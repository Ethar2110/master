import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState>{
  int selectedIndex = -1;
  CategoryCubit():
      super(
        CategoryState(
          categories: [
            {
              "text": "specials_of_the_week",
              "image": "assets/images/categories/discount.png",
              "isSpecial": true,
            },
            {
              "text": "cookies",
              "image": "assets/images/categories/cookies.png",
            },
            {
              "text": "drinks",
              "image": "assets/images/categories/colawater.png",
            },
            {
              "text": "desserts",
              "image": "assets/images/categories/desert.png",
            },
            {
              "text": "pizza",
              "image": "assets/images/categories/pizzaa.png",
            },
            {
              "text": "salads",
              "image": "assets/images/categories/salad.png",
            },
          ],
        ),
      );

  void selectIndex(int index) {
    selectedIndex = index;
    emit(CategoryState(categories: state.categories)); // just re-emit
  }
}