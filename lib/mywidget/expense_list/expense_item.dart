import 'package:flutter/material.dart';
import 'package:pocket_pilot/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expensee, {super.key});

  final Expense expensee;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expensee.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('₹${expensee.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryIcons[expensee.category]),
                  const SizedBox(width: 8),
                  Text(expensee.formattedDate),
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
