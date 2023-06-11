import 'package:bigfoot/app/modules/chat/models/chat.dart';
import 'package:bigfoot/app/modules/listing/widgets/filter_item.dart';
import 'package:bigfoot/app/modules/listing/widgets/search_bar.dart';
import 'package:bigfoot/app/shared/extensions/context_extensions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // check if user already has a chat with us
          final query = await FirebaseFirestore.instance
              .collection('chats')
              .where('clientId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();

          if (query.docs.isNotEmpty) {
            final chat = Chat.fromJson(query.docs.first.data());
            if (context.mounted) {
              Navigator.of(context).pushNamed('/chat', arguments: {
                'chat': chat,
                'chatId': query.docs.first.id,
              });
            }
            return;
          }

          final chat = Chat(
            clientId: FirebaseAuth.instance.currentUser!.uid,
            clientName: FirebaseAuth.instance.currentUser?.email ?? '',
            productId: null,
            lastMessage: null,
          );

          final doc = await FirebaseFirestore.instance
              .collection('chats')
              .add(chat.toJson());

          if (context.mounted) {
            Navigator.of(context).pushNamed('/chat', arguments: {
              'chat': chat,
              'chatId': doc.id,
            });
          }
        },
        backgroundColor: context.colorScheme.errorContainer,
        icon: const Icon(Icons.chat),
        label: const Text('Chat with us'),
      ),
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
                Navigator.of(context).pushNamed('/cart');
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
              child: FirestoreQueryBuilder(
                  pageSize: 10,
                  query: FirebaseFirestore.instance
                      .collection("products")
                      .orderBy('name'),
                  builder: (context, snapshot, _) {
                    if (snapshot.docs.isEmpty) {
                      return const Center(child: Text("No products found"));
                    }
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 30,
                      ),
                      itemCount: snapshot.docs.length,
                      itemBuilder: (context, index) {
                        if (snapshot.hasMore &&
                            index + 1 == snapshot.docs.length) {
                          snapshot.fetchMore();
                        }

                        final product = snapshot.docs[index].data();
                        product['id'] = snapshot.docs[index].id;
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                                    product['name'] ?? '',
                                    style: TextStyle(
                                      color: context.colorScheme.surface,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -1,
                                    ),
                                  ),
                                  Expanded(
                                    child: Image.network(product['image']),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "\$ ${product['price']}",
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
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  '/product',
                                  arguments: product,
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
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
