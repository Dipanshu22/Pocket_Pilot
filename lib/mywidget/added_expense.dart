import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:pocket_pilot/models/expense.dart';

class AddedExpense extends StatefulWidget {
  const AddedExpense({super.key, required this.onNewExpense});

  final void Function(Expense expense) onNewExpense;

  @override
  State<AddedExpense> createState() {
    return _AddedExpenseState();
  }
}

class _AddedExpenseState extends State<AddedExpense> {
  final _titleControl = TextEditingController();
  final _amountControl = TextEditingController();
  DateTime? _selectDate;
  Category _selectCategory = Category.travel;

  void _datePicker() async {
    final curr = DateTime.now();
    final firstDate = DateTime(curr.year - 1, curr.month, curr.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: curr,
        firstDate: firstDate,
        lastDate: curr);
    setState(() {
      _selectDate = pickedDate;
    });
  }
  void _showDialog(){
    if(Platform.isIOS){
          showCupertinoDialog(
            context: context,
             builder: (ctxt) => CupertinoAlertDialog(
             title: const Text('Invalid input'),
          content: const Text(
              'Please enter a valid title, amount ,date and category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctxt);
              },
              child: const Text('Okay'),
            ),
          ],
          ));
    }
      
        else{
           showDialog(
        context: context,
        builder: (ctxt) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please enter a valid title, amount ,date and category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctxt);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
        }
      
  }

  void _submitData() {
    final enteredAmount = double.tryParse(_amountControl.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleControl.text.trim().isEmpty ||
        amountInvalid ||
        _selectDate == null) {
          
         _showDialog();
      return;
    }
    widget.onNewExpense(
      Expense(
          title: _titleControl.text,
          amount: enteredAmount,
          date: _selectDate!,
          category: _selectCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleControl.dispose();
    _amountControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx,constraints){
      
       final width = constraints.maxWidth;
      
       return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(16,48,16, keyboardSpace + 16),
          child: Column(
            children: [
              if(width>=600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Expanded(
                    child: TextField(
                controller: _titleControl,
                maxLength: 30,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
                   ),
              const SizedBox(width: 24),
              Expanded(
                    child: TextField(
                      controller: _amountControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '₹ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
              ],
              )
              else
               TextField(
                controller: _titleControl,
                maxLength: 30,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              if(width>= 600)
               Row(children: [
                 DropdownButton(
                      value: _selectCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectCategory = value;
                        });
                      }),
                      const SizedBox(width: 24),
                Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectDate == null
                              ? 'Select Date'
                              : formatter.format(
                                  _selectDate!), // ! here forces dart to assume that there won't be any null value in this
                        ),
                        IconButton(
                          onPressed: _datePicker,
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                      ],
                    ),
                  ),
               ],
               )
            else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountControl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '₹ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectDate == null
                              ? 'Select Date'
                              : formatter.format(
                                  _selectDate!), // ! here forces dart to assume that there won't be any null value in this
                        ),
                        IconButton(
                          onPressed: _datePicker,
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if(width >=600)
                 Row(children: [
                   const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitData,
                    child: const Text('Save Expense'),
                  ),
                 ],)
              else
              Row(
                children: [
                  DropdownButton(
                      value: _selectCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectCategory = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitData,
                    child: const Text('Save Expense'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  

    });
    }
  }
   
   
   
   
   