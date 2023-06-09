import 'package:bigfoot/app/shared/bloc/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates>{

  CartCubit() : super(CartInitialState());

  List<Map<String, dynamic>> products = [];

  void addToCart({
    required Map<String, dynamic> product,
  }){
    products.add(product);
    emit(CartChangedState());
  }

  void removeFromCart({
    required Map<String, dynamic> product,
  }){
    products.remove(product);
    emit(CartChangedState());
  }

  double get total {
    double total = 0;
    for (final product in products) {
      total += product["price"];
    }
    return total;
  }

}
