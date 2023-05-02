import 'package:bigfoot/app/modules/cart/cart_screen.dart';
import 'package:bigfoot/app/modules/listing/widgets/filter_item.dart';
import 'package:bigfoot/app/modules/listing/widgets/search_bar.dart';
import 'package:bigfoot/app/modules/product/product_screen.dart';
import 'package:bigfoot/app/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const filterList = [
      "All",
      "Man",
      "Woman",
      "Kids",
      "New",
    ];
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text("Home"),
              leading: const Icon(Icons.home),
              onTap: Navigator.of(context).pop,
            ),
            ListTile(
              title: const Text("Cart"),
              leading: const Icon(Icons.shopping_cart_outlined),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CartScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Search Products"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // search bar
          const SearchBar(),
          // categories
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = filterList[index];
                return FilterItem(item: item);
              },
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 30,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.onBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: context.colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              "Air Max 270 React",
                              style: TextStyle(
                                color: context.colorScheme.surface,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1,
                              ),
                            ),
                            Expanded(
                              child: Image.network(
                                  "https://www.pngall.com/wp-content/uploads/13/Nike-Shoes-PNG-Cutout.png"),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "\$ 200",
                                style: TextStyle(
                                  color: context.colorScheme.surface,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -1,
                                ),
                              ),
                            )
                          ],
                        ),
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
                          borderRadius: BorderRadius.circular(10) -
                              const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProductScreen(),
                            ),
                          ),
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
