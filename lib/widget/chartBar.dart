import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int spending;
  final double spendingPerc;

  ChartBar(this.label, this.spending, this.spendingPerc);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 7,
        ),
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '₹${spending.toStringAsFixed(0)}',
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPerc,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
        SizedBox(
          height: 7,
        ),
      ],
    );
  }
}
