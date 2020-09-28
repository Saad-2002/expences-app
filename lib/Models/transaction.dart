import 'package:flutter/foundation.dart';

class Transaction{
  String title,id;
  double amount;
  DateTime date;

  Transaction({
    @required this.title,
    @required this.amount,
    @required this.date,
    @required this.id
});
}