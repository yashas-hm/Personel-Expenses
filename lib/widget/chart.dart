import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chartBar.dart';
import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transactionList;

  Chart(this._transactionList);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(
        Duration(days: index),
      );
      int total = 0;
      for (var i = 0; i < _transactionList.length; i++) {
        if (_transactionList[i].timeStamp.day == day.day &&
            _transactionList[i].timeStamp.month == day.month &&
            _transactionList[i].timeStamp.year == day.year) {
          total += _transactionList[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(day).substring(0, 1),
        'amount': total,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as int) / totalSpending),
          );
        }).toList(),
      ),
    );
  }
}
