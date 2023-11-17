import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class CategoryDrodown extends StatelessWidget {
  const CategoryDrodown(this.categories,
      {super.key, required this.onCategorySelect});

  final Category categories;
  final void Function(Category?) onCategorySelect;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: categories,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase()),
            ),
          )
          .toList(),
      onChanged: onCategorySelect,
    );
  }
}
