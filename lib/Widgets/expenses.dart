import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/Chart/chart.dart';
import 'package:todo_app/Widgets/expenses_list/expenses_list.dart';

import '../models/expense.dart';
import 'new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final maxWidth = 600;
  final List<Expense> _registeredExpense = [
    Expense(
        amount: 750,
        date: DateTime.now(),
        title: "Cafeteria",
        category: Category.food),
    Expense(
        amount: 150,
        date: DateTime.now(),
        title: "Auto",
        category: Category.travel),
  ];

  void addNewExpense(Expense newExpense) {
    setState(() {
      _registeredExpense.add(newExpense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense deleted"),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpense.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  void _createNewExpense() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (ctx) => NewExpense(
              createExpense: addNewExpense,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = Center(
        child: Text(
      "No expenses. Try adding some!",
      style: Theme.of(context).textTheme.titleMedium,
    ));
    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpense,
        removeExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _createNewExpense,
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text("Expense Tracker"),
      ),
      body: width < maxWidth
          ? Column(
              children: [
                Chart(expenses: _registeredExpense),
                Expanded(child: mainContent)
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpense)),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}
