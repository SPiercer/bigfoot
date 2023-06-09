import 'package:bigfoot/app/shared/bloc/cart_bloc.dart';
import 'package:bigfoot/app/shared/bloc/cart_states.dart';
import 'package:bigfoot/app/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: false,
      ),
      body: BlocConsumer<CartCubit, CartStates>(
        listener: (context, state) {

          if (state is CartChangedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Cart changed"),
              ),
            );
          }

        },
        builder: (context, state) {

          final cubit = context.watch<CartCubit>();

          return Column(
            children: [

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: cubit.products.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (_, index) {

                    final Map<String, dynamic> product = cubit.products[index];

                    return Slidable(
                      closeOnScroll: false,
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(
                          onDismissed: () {
                            cubit.removeFromCart(product: product);
                          },
                        ),
                        children: [

                          /// Edit button
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.edit_note_sharp,
                            label: 'Edit',
                          ),

                          /// SLIDE TO DELETE
                          SlidableAction(
                            onPressed: (_) {
                              cubit.removeFromCart(product: product);
                              },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      key: UniqueKey(),
                      child: ListTile(
                        key: UniqueKey(),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        tileColor: Colors.white,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// NAME
                            Text(
                              product['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.background,
                              ),
                            ),

                            /// SPACING
                            const SizedBox(height: 4),

                            /// SIZE
                            Text(
                              "L | 42",
                              style: TextStyle(
                                color: context.colorScheme.secondary,
                                fontSize: 12,
                              ),
                            ),

                            /// SPACING
                            const SizedBox(height: 4),

                            /// PRICE
                            Text(
                              "\$${product['price']}",
                              style: TextStyle(
                                color: context.colorScheme.background,
                                fontSize: 18,
                                fontFamily: 'Abril Fatface',
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                        trailing: Image.network( product['image'], width: 120,),
                      ),
                    );
                  },
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.background,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Text(
                  "\$${cubit.total.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: context.colorScheme.onBackground,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
              ),

              const SizedBox(height: 20),

            ],
          );
        },
      ),
    );
  }
}
