import 'package:bigfoot/app/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.screenSize.height * .08,
                    horizontal: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      const Icon(
                        Icons.nine_k,
                        color: Colors.black,
                        size: 72,
                      ),
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 30,
                  top: context.screenSize.height * .2,
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
                Positioned(
                  top: context.screenSize.height * .2,
                  left: 30,
                  right: context.screenSize.width * .25,
                  bottom: context.screenSize.height * .1,
                  child: const Placeholder(),
                ),
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
                            "StandardRX",
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
                        r"$99.99",
                        style: TextStyle(
                          color: context.colorScheme.background,
                          fontSize: 32,
                          fontFamily: 'Abril Fatface',
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Lorem Ipsum " * 30,
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
                        final selected = index == 3;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: selected
                                ? context.colorScheme.errorContainer
                                : null,
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(child: Text("XL")),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
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
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
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
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
