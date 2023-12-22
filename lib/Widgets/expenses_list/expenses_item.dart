import 'package:flutter/material.dart';

import 'package:todo_app/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(categoryIcons[expense.category]),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text((expense.category).toString()),
                Text(
                  expense.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(expense.formattedDate),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("₹ ${expense.amount.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleSmall),
              ],
            )
          ],
        ),
      ),
    );
  }
}
