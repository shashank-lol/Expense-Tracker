import 'package:flutter/material.dart';

import 'package:todo_app/models/expense.dart';
import 'package:todo_app/theme.dart';
import 'data_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.shopping),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpense > maxTotalExpense)
        maxTotalExpense = bucket.totalExpense;
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.4),
            Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
      child: Column(
        children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final bucket in buckets)
                DataBar(
                  height: maxTotalExpense != 0
                      ? bucket.totalExpense / maxTotalExpense
                      : 0,
                ),
            ],
          )),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: buckets
                .map((bucket) => Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    )))
                .toList(),
          )
        ],
      ),
    );
  }
}
