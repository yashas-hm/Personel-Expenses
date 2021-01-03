import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final textController = TextEditingController();
  final amountController = TextEditingController();

  void submit() {
    final String title = textController.text;
    final int amount = int.parse(amountController.text);

    if(title.isEmpty||amount<0){
      return;
    }

    widget.addTransaction(
      textController.text,
      int.parse(amountController.text),
    );

    Navigator.of(context).pop();
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
              controller: textController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => submit(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submit(),
            ),
            FlatButton(
              onPressed: submit,
              child: Text('Add Transaction'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
