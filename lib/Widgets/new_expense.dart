import 'package:flutter/material.dart';

import '../models/expense.dart';
import './expenses.dart';

class NewExpense extends StatefulWidget {
  NewExpense({required this.createExpense, super.key});

  final void Function(Expense expense) createExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _inputTitleController = TextEditingController();
  final _inputAmountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_inputAmountController.text);
    final amountIsInvalid = (enteredAmount == null || enteredAmount <= 0);
    if (_inputTitleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid input"),
                content:
                    const Text("Please enter a valid title, amount and date"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("OK"))
                ],
              ));
      return;
    }
    Expense newExpense = Expense(
        amount: double.tryParse(_inputAmountController.text)!,
        category: _selectedCategory,
        title: _inputTitleController.text,
        date: _selectedDate!);
    widget.createExpense(newExpense);
    Navigator.pop(context);
  }

  void _datePicker() async {
    final currentDate = DateTime.now();
    final firstDate =
        DateTime(currentDate.year - 1, currentDate.month, currentDate.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: firstDate,
        lastDate: currentDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _inputTitleController.dispose();
    _inputAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 32, 16, 16 + keyboardHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _inputTitleController,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text("Title")),
                          cursorColor: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _inputAmountController,
                          cursorColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                          decoration: const InputDecoration(
                              prefixText: "₹ ", label: Text("Amount")),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _inputTitleController,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text("Title")),
                    cursorColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                    style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: _datePicker,
                                icon: const Icon(Icons.calendar_today)),
                            Text(_selectedDate == null
                                ? "No Date Selected"
                                : formatter.format(_selectedDate!))
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _inputAmountController,
                          cursorColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                          decoration: const InputDecoration(
                              prefixText: "₹ ", label: Text("Amount")),
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat.name.toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value;
                            });
                          })
                    ],
                  ),
                if (width < 600)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: _datePicker,
                            icon: const Icon(Icons.calendar_today)),
                        Text(_selectedDate == null
                            ? "No Date Selected"
                            : formatter.format(_selectedDate!))
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense")),
                      const SizedBox(
                        width: 12,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                    ],
                  ),
                )
              ],
            )),
      );
    });
  }
}
