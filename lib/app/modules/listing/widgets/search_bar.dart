import 'package:bigfoot/app/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: context.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          icon: Icon(Icons.search),
          iconColor: Colors.grey,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
