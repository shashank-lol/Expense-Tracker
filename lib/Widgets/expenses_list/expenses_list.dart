import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';

import '../../models/expense.dart';
import 'package:todo_app/Widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList(
      {required this.removeExpense, required this.expenses, super.key});

  List<Expense> expenses;
  final void Function(Expense expenseToBeRemoved) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.25),
              margin: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onDismissed: (direction) {
              removeExpense(expenses[index]);
            },
            key: ValueKey(expenses[index]),
            child: ExpenseItem(expenses[index])));
  }
}
