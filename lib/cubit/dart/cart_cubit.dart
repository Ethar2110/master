import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log/cubit/dart/cart_state.dart';
import 'package:log/models/cart_item.dart';


class CartCubit extends Cubit<CartState>{
  CartCubit() : super(CartState(items: []));

  void addItem(CartItem item){
    final newList = List<CartItem>.from(state.items);
    final index = newList.indexWhere((e) => e.name == item.name);

    if(index != -1){
      newList[index].quantity++;
    }else {
      newList.add(item);
    }
    emit(CartState(items: newList));

  }


  void increaseQuantity (int index){
    final newList = List<CartItem>.from(state.items);

    newList[index].quantity++;
    emit(CartState(items: newList));
  }

  void decreaseQuantity (int index){
    final newList = List<CartItem>.from(state.items);

    if(newList[index].quantity > 1){
      newList[index].quantity--;
    } else{
      newList.removeAt(index);
    }

    emit(CartState(items: newList));
  }


}