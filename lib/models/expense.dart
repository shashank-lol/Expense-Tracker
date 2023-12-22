import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum Category { food, travel, shopping, leisure }

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.directions_bus,
  Category.leisure: Icons.celebration,
  Category.shopping: Icons.shopping_bag
};

const uuid = Uuid();

final formatter = DateFormat.yMd();

class Expense {
  Expense({required this.amount,
    required this.date,
    required this.title,
    required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category)
      .toList();

  List<Expense>expenses;
  Category category;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }

}
