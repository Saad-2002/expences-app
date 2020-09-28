import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function newTransactions;

  AddTransaction({this.newTransactions});

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      print('title is empty / entered amount<=0 / selectedTime is Empty');
      return;
    } else
      widget.newTransactions(enteredTitle, enteredAmount, selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            controller: titleController,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            controller: amountController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedDate == null
                    ? 'No selected Date!'
                    : DateFormat.yMMMd().format(selectedDate),
                style: TextStyle(fontSize: 15),
              ),
              FlatButton(
                color: Colors.tealAccent,
                child: Text(
                  'select Date',
                  style: TextStyle(fontSize: 15.0),
                ),
                onPressed: () => showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(2019),
                        lastDate: DateTime.now())
                    .then((value) {
                  setState(() {
                    selectedDate = value;
                  });
                }),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            textColor: Colors.white,
            child: Text(
              'Add Transaction',
            ),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              print(titleController.text);
              submitData();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
