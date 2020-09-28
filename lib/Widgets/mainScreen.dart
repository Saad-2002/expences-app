import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';
import 'add_transaction.dart';
import 'chart.dart';
import 'dart:io';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Transaction> transactions = [];
  AddTransaction addTransaction = AddTransaction();
  Transaction newTransaction;

  void newTransactions(String txTitle, double txAmount, DateTime selectedDate) {
    newTransaction = Transaction(
        title: txTitle,
        amount: txAmount,
        date: selectedDate,
        id: DateTime.now().toString());
    print(newTransaction.amount);
    print(newTransaction.title);

    setState(() {
      transactions.add(newTransaction);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => id == element.id);
    });
  }

  List<Transaction> get _recentTransactions {
    //this is a getter constructed in order to create a list of transactions as the old one but only for the last 7 days in order to send it to the charter
    return transactions.where((element) {
      //where is a method that allows you to create a function which will be extracted for every element in the list so you can perform anything you like inside that function and depending on the result (true/false) you will add this element to your new list or not
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBody = SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Chart(_recentTransactions),
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: transactions.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      const Text('There is no Transactions! yet add some.',
                          style: TextStyle(fontSize: 20)),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Image.asset('assets/Images/waiting.png',
                            fit: BoxFit.fill),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => Card(
                      elevation: 5.0,
                      child: ListTile(
                        leading: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColorDark,
                                width: 3),
                          ),
                          child: Text('\$${transactions[index].amount}',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            deleteTransaction(transactions[index].id);
                          },
                        ),
                      ),
                    ),
                    itemCount: transactions.length,
                  ),
          ),
        ],
      ),
    );
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Colors.teal,
            middle: const Text(
              'expences',
              style: TextStyle(fontSize: 25),
            ),
            trailing: GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        AddTransaction(newTransactions: newTransactions));
              },
            ),
          )
        : AppBar(
            title: const Center(
              child: Text(
                'expences',
                style: TextStyle(fontSize: 25),
              ),
            ),
          );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: appBody,
          )
        : Scaffold(
            appBar: appBar,
            body: appBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              AddTransaction(newTransactions: newTransactions));
                    },
                  ),
          );
  }
}
