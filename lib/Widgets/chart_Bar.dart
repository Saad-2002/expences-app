import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double spending;
  final double spendingsPrecent;
  final String dayLabel;

  ChartBar(
      {@required this.spending,
      @required this.spendingsPrecent,
      @required this.dayLabel});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        children: <Widget>[
          Text('\$${spending.toStringAsFixed(0)}'),
          SizedBox(
            height: 4,
          ),
          Stack(
            children: <Widget>[
              Container(
                height: 60,
                width: 13,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey[800], width: 1),
                ),
              ),
              Container(
                height: 60,
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: spendingsPrecent,
                  child: Container(
                    width: 13,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            dayLabel,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
