import 'package:flutter/material.dart';
import 'package:pocket_pilot/mywidget/expense_list/expense_item.dart';
import 'package:pocket_pilot/mywidget/expenses.dart';
import 'package:pocket_pilot/models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expense,
    required this.onRemoveExpense,
  });

  final List<Expense> expense;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (contxt, index) => Dismissible(
        key: ValueKey(expense[index]),
        background: Container(
          color: Theme.of(context).colorScheme.errorContainer,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expense[index]);
        },
        child: ExpenseItem(expense[index]),
      ),
    );
  }
}
