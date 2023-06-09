import 'package:bigfoot/app/modules/cart/cart_screen.dart';
import 'package:bigfoot/app/shared/bloc/cart_bloc.dart';
import 'package:bigfoot/app/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {

  const ProductScreen({
    required this.product,
    super.key
  });

  final Map<String, dynamic> product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  int selectedIndex = -1;

  static const List<String> sizes = [
    's',
    'm',
    'L',
    'XL',
    'XXL',
  ];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        children: [

          /// UPPER BOX
          Expanded(
            flex: 4,
            child: Stack(
              children: [

                /// BACKGROUND
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),

                /// UPPER BAR
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.screenSize.height * .08,
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// TM LOGO
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: context.colorScheme.surface,
                          border: Border.all(
                            color: context.colorScheme.outline,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          onPressed: Navigator.of(context).pop,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      /// TM LOGO
                      // const Icon(
                      //   Icons.nine_k,
                      //   color: Colors.black,
                      //   size: 72,
                      // ),

                      /// LIKE BUTTON
                      // Container(
                      //   width: 60,
                      //   height: 60,
                      //   decoration: BoxDecoration(
                      //     color: context.colorScheme.surface,
                      //     border: Border.all(
                      //       color: context.colorScheme.outline,
                      //       width: 1,
                      //     ),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: IconButton(
                      //     onPressed: () {},
                      //     icon: const Icon(
                      //       Icons.favorite_outline,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),


                    ],
                  ),
                ),

                /// THE THREE SQUARES
                Positioned(
                  right: 30,
                  top: context.screenSize.height * .15,
                  child: Column(
                    children: [
                      for (var i = 0; i < 3; i++)
                        Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                /// PRODUCT IMAGE
                Positioned(
                  top: context.screenSize.height * .2,
                  left: 30,
                  right: context.screenSize.width * .25,
                  bottom: context.screenSize.height * .1,
                    child: Image.network(widget.product['image'])
                ),

                /// LIKE BUTTON
                Positioned(
                  bottom: 30,
                  right: 20,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product['name'],
                            style: TextStyle(
                              color: context.colorScheme.background,
                              fontSize: 32,
                              fontFamily: 'Abril Fatface',
                              letterSpacing: -1,
                              height: 1,
                            ),
                          ),
                          Text(
                            "Combo",
                            style: TextStyle(
                              color: context.colorScheme.background,
                              fontSize: 18,
                              letterSpacing: -1,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "E£${widget.product['price']}",
                        style: TextStyle(
                          color: context.colorScheme.background,
                          fontSize: 32,
                          fontFamily: 'Abril Fatface',
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          /// LOWER DETAILS
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    ///
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      widget.product['desc'],
                      style: const TextStyle(fontSize: 12, height: 1.2),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "Select Size",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {

                          final selected = index == selectedIndex;

                          return InkWell(
                            onTap: () async {

                              setState(() {
                                selectedIndex = index;
                              });

                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: selected ? context.colorScheme.errorContainer : null,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(child: Text(sizes[index])),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [

                        /// CHAT BUTTON
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(child: Icon(Icons.chat_outlined)),
                        ),

                        /// SPACING
                        const SizedBox(width: 16),

                        /// ADD TO CART BUTTON
                        Expanded(
                          child: TextButton(
                            onPressed: () {

                              final cart = context.read<CartCubit>();
                              cart.addToCart(product: widget.product);

                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (_) => const CartScreen(),
                              ));

                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.0),
                              child: Text(
                                "Add to cart",
                                style:
                                TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

}
