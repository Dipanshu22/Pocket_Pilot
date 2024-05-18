import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter =DateFormat.yMd();

const uuid =Uuid();

enum Category{food,travel,leisure,work,taxes,utilities}

const categoryIcons ={
  Category.food: Icons.lunch_dining,
  Category.travel:Icons.flight_takeoff,
  Category.leisure:Icons.movie,
  Category.work: Icons.work,
  Category.taxes: Icons.money,
  Category.utilities: Icons.settings_input_component,
};

 class Expense {
  Expense({required this.title,
   required this.amount,
    required this.date,
    required this.category,
    }) : id=uuid.v4();//initialiser list

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }
}

class ExpenseStore{
  const ExpenseStore({
    required this.category,
    required this.expense,
  });

  ExpenseStore.forCateg(List<Expense> allExpenses,this.category) 
  : expense=allExpenses
  .where((expen)=>expen.category == category)
  .toList();
  
  final Category category;
  final List<Expense> expense;

  double get totalExpense{
    double sum=0;
    for(final expens in expense){
       sum =sum+expens.amount;
    }
    return sum;
  }

}
