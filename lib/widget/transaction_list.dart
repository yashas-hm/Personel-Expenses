import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactionList;

  TransactionList(this._userTransactionList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _userTransactionList.isEmpty
          ? Column(
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
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
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
                  ),
                );
                // return Card(
                //   margin: EdgeInsets.symmetric(
                //     horizontal: 20,
                //     vertical: 5,
                //   ),
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         constraints: BoxConstraints(minWidth: 80),
                //         child: Text(
                //           '₹${_userTransactionList[index].amount}',
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20,
                //               color: Theme.of(context).primaryColor),
                //         ),
                //         margin: EdgeInsets.symmetric(
                //           horizontal: 10,
                //           vertical: 15,
                //         ),
                //         padding: EdgeInsets.all(5),
                //         alignment: Alignment.center,
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //             color: Theme.of(context).primaryColor,
                //             width: 2,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         children: <Widget>[
                //           Text(
                //             _userTransactionList[index].title,
                //             style: Theme.of(context).textTheme.headline6,
                //           ),
                //           Text(
                //             DateFormat.yMMMd()
                //                 .format(_userTransactionList[index].timeStamp),
                //             style: TextStyle(
                //               fontSize: 12,
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ],
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //       ),
                //     ],
                //   ),
                // );
              },
              itemCount: _userTransactionList.length,
            ),
    );
  }
}
