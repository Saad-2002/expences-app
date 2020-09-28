import 'package:exspenses/Widgets/chart_Bar.dart';
import 'package:flutter/material.dart';
import 'package:exspenses/Models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(// this is a dart method which we can use to generate a list of x items (we give it an integer and a function with the counter ((the index ))which will automatically increase by one after each time the function returns an object
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));//here we are storing the date for every item in our generated list so we begin with today ,yesterday... as the index go up
        double totalSum = 0;

        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum = totalSum + recentTransactions[i].amount;
          }
        }//here we are going through a loop in order to calculate all the transactions in that specific date we talked about
        return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};//finally we are storing the final information((the item)) as a map which holds the day name and total of he transactions that happened in that day so and as we said before we are returning a list of maps (Max way) :)  and the hall function name here is getter
      },
    );
  }

  double get totalWeekSpendings {
    return groupedTransactions.fold(
      0.0,
      (sum, element) {
        return sum + element['amount'];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions.map((e) {
              return ChartBar(
                dayLabel: e['day'],
                spending: e['amount'],
                spendingsPrecent: totalWeekSpendings == 0
                    ? 0.0
                    : (e['amount'] as double) / totalWeekSpendings,//this is the double that will be stored in the height factor of the Fractionally sized box and we divided the amount on the total week spendings to get a value between 0 and 1 (as the height factor demands)that will present a precent
              );
            }).toList()),
      ),
    );
  }
}
