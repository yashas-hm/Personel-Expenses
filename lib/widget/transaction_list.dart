import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactionList;
  final Function _deleteTransaction;

  TransactionList(this._userTransactionList, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _userTransactionList.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No Transactions added yet',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    //alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: _userTransactionList
                .map(
                  (tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      userTransactionList: tx,
                      deleteTransaction: _deleteTransaction),
                )
                .toList(),
          );
  }
}
