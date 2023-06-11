import 'package:bigfoot/app/modules/cart/cart_screen.dart';
import 'package:bigfoot/app/shared/bloc/cart_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  List<Map<String, dynamic>> products = [];

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  void addToCart(Map<String, dynamic> product) {
    products.add(product);
    emit(CartChangedState());
  }

  void removeFromCart(Map<String, dynamic> product) {
    products.remove(product);
    emit(CartChangedState());
  }

  void clearCart() {
    products.clear();
    emit(CartCheckout());
  }

  Future<void> checkout() async {
    emit(CartLoading());
    await FirebaseFirestore.instance.collection('orders').add({
      'name': nameController.text,
      'address': addressController.text,
      'phone': phoneController.text,
      'date': DateTime.now(),
      'status': 'pending',
      'items': products
          .map((e) => OrderItem(
                id: e['id'],
                name: e['name'],
                image: e['image'],
                price: e['price'],
                size: e['size'],
              ).toMap())
          .toList(),
    });
    clearCart();
  }

  double get total {
    double total = 0;
    for (final product in products) {
      total += product["price"];
    }
    return total;
  }
}
