import 'package:bigfoot/app/shared/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: item == "All"
            ? context.colorScheme.onError
            : context.colorScheme.onBackground,
      ),
      child: Center(
        child: Text(
          item,
          style: TextStyle(
            color: item == "All"
                ? context.colorScheme.onErrorContainer
                : context.colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
