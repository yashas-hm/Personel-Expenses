import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './model/transaction.dart';
import './widget/chart.dart';
import './widget/new_transaction.dart';
import './widget/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(
              color: Colors.white,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  final List<Transaction> _userTransactionList = [
    // Transaction(
    //   id: '1',
    //   title: 'First',
    //   amount: 1200,
    //   timeStamp: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'Second',
    //   amount: 1200,
    //   timeStamp: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransactionList.where((tx) {
      return tx.timeStamp.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactionList.removeWhere((element) => element.id == id);
    });
  }

  void _addNewTransaction(String title, int amount, DateTime datePicked) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      timeStamp: datePicked,
    );

    setState(() {
      _userTransactionList.add(newTx);
    });
  }

  List<Widget> _buildLandscapeContent(AppBar appBar, Widget listWidget) {
    return [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FittedBox(
              child: Text(
                "Show Chart",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              },
            )
          ],
        ),
      ),
      _showChart
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: Chart(_recentTransaction),
            )
          : listWidget
    ];
  }

  List<Widget> _buildPortraitContent(AppBar appBar, Widget listWidget) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
        child: Chart(_recentTransaction),
      ),
      listWidget
    ];
  }

  Widget _buildAppbar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    onTap: () => _startAddTransaction(context),
                    child: Icon(CupertinoIcons.add))
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () => _startAddTransaction(context),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAppbar();

    final listWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.65,
      alignment: Alignment.center,
      child: TransactionList(_userTransactionList, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (isLandscape) ..._buildLandscapeContent(appBar, listWidget),
            if (!isLandscape) ..._buildPortraitContent(appBar, listWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => _startAddTransaction(context),
                  ),
          );
  }
}
