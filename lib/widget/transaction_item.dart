import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required Transaction userTransactionList,
    @required Function deleteTransaction,
  })  : _userTransactionList = userTransactionList,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _userTransactionList;
  final Function _deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.orange,
      Colors.red,
      Colors.black,
      Colors.purple,
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('₹${widget._userTransactionList.amount}'),
            ),
          ),
        ),
        title: Text(
          widget._userTransactionList.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget._userTransactionList.timeStamp),
        ),
        trailing: MediaQuery.of(context).size.width >= 360
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                onPressed: () =>
                    widget._deleteTransaction(widget._userTransactionList.id),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () =>
                    widget._deleteTransaction(widget._userTransactionList.id),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
