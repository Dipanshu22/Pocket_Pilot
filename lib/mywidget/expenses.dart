import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocket_pilot/mywidget/added_expense.dart';
import 'package:pocket_pilot/mywidget/chart/chart.dart';
import 'package:pocket_pilot/mywidget/expense_list/expense_list.dart';
import 'package:pocket_pilot/models/expense.dart';
import 'package:pocket_pilot/mywidget/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Manali',
      amount: 4000,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Cinema',
      amount: 300,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openOverLay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddedExpense(onNewExpense: _newExpense),
    );
  }

  void _newExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 4),
        content: const Text('Expense Removed.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found.Add Some'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expense: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('PocketPilot'),
        actions: [
          IconButton(
            onPressed: _openOverLay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(children: [
              Expanded(
                child: Chart(expenses: _registeredExpenses),
              ),
              Expanded(
                child: mainContent,
              ),
            ]),
    );
  }
}
