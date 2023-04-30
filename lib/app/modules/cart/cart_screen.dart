import 'package:bigfoot/app/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final list = List.generate(20, (index) => index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, index) {
                return Slidable(
                  closeOnScroll: false,
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(
                      onDismissed: () {
                        setState(() {
                          list.removeAt(index);
                        });
                      },
                    ),
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit_note_sharp,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (_) => setState(() => list.removeAt(index)),
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
                        Text(
                          "New Balance 574",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.background,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "L | 42",
                          style: TextStyle(
                            color: context.colorScheme.secondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          r"$99.99",
                          style: TextStyle(
                            color: context.colorScheme.background,
                            fontSize: 18,
                            fontFamily: 'Abril Fatface',
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                    trailing: Image.network(
                      "https://www.pngall.com/wp-content/uploads/13/Nike-Shoes-PNG-Cutout.png",
                      width: 120,
                    ),
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
              r"$999.99",
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
      ),
    );
  }
}
