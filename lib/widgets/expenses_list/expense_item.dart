import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expense.title),
            const SizedBox(height: 4),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(), // take all empty space between top and bottom widget
                Row(
                  children: [
                    Icon(Icons.ac_unit_rounded),
                    const SizedBox(width: 8),
                    Text(expense.date.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
