import 'dart:ui';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense/amount_input.dart';
import 'package:expense_tracker/widgets/new_expense/category_dropdown.dart';
import 'package:expense_tracker/widgets/new_expense/datepicker.dart';
import 'package:expense_tracker/widgets/new_expense/title_input.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onSaveExpense});

  final void Function(Expense expense) onSaveExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure valid Title, Amount and D ate is entered.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            )
          ],
        ),
      );
      return;
    }

    widget.onSaveExpense(Expense(
      title: _titleController.text,
      amount: double.tryParse(_amountController.text)!,
      date: _selectedDate!,
      category: _selectedCategory,
    ));
    Navigator.pop(context);
  }

  void _selectCategory(Category? value) {
    if (value != null) {
      setState(() {
        _selectedCategory = value;
      });
    }
  }

  @override
  void dispose() {
    _titleController
        .dispose(); // Because controller does not get deleted from memory itself
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; // amount of space taken by keyboard

    return LayoutBuilder(builder: (ctx, contraints) {
      final width = contraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TitleInput(titleController: _titleController),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: AmountInput(amountController: _amountController),
                      ),
                    ],
                  )
                else
                  TitleInput(titleController: _titleController),
                if (width >= 600)
                  Row(
                    children: [
                      CategoryDrodown(
                        _selectedCategory,
                        onCategorySelect: _selectCategory,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: DatePicker(
                          selectedDate: _selectedDate,
                          onIconPressed: _showDatePicker,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: AmountInput(amountController: _amountController),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: DatePicker(
                          selectedDate: _selectedDate,
                          onIconPressed: _showDatePicker,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      CategoryDrodown(
                        _selectedCategory,
                        onCategorySelect: _selectCategory,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
