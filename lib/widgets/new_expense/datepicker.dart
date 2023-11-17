import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
      {super.key, required this.selectedDate, required this.onIconPressed});

  final DateTime? selectedDate;
  final void Function() onIconPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(selectedDate == null
            ? 'No date selected'
            : formatter.format(selectedDate!)),
        IconButton(
          onPressed: onIconPressed,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
