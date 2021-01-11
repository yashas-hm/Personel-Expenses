import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                children: <Widget>[
                  Text(
                    'No Transactions added yet',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('₹${_userTransactionList[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    _userTransactionList[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd()
                        .format(_userTransactionList[index].timeStamp),
                  ),
                  trailing: MediaQuery.of(context).size.width >= 360
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text("Delete"),
                          onPressed: () => _deleteTransaction(
                              _userTransactionList[index].id),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteTransaction(
                              _userTransactionList[index].id),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: _userTransactionList.length,
          );
  }
}
