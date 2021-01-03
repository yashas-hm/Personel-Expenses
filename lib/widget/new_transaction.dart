import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;


  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _datePicked;

  void _submit() {
    final String title = _textController.text;
    final int amount = int.parse(_amountController.text);

    if (title.isEmpty || amount < 0 || _datePicked == null) {
      return;
    }

    widget.addTransaction(
      _textController.text,
      int.parse(_amountController.text),
      _datePicked
    );

    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _datePicked = value;
        });
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: _textController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submit(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submit(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _datePicked == null
                          ? 'No Date Chosen'
                          : 'Picked Date : ${DateFormat.yMd().format(_datePicked)}',
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: _submit,
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
          ],
        ),
      ),
    );
  }
}
