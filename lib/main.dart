import 'package:expens_tracker/models/transaction.dart';
import 'package:expens_tracker/widgets/chart.dart';
import 'package:expens_tracker/widgets/new_transaction.dart';
import 'package:expens_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApplication());

class MyApplication extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: 'OpenSans', fontSize: 20.0),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
//    Transaction(id: 't1', title: 'shoes', amount: 50.0, date: DateTime.now()),
//    Transaction(id: 't2', title: 'shirt', amount: 150.0, date: DateTime.now()),
//    Transaction(
//        id: 't3', title: 'grocery', amount: 100.0, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addnewTransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txtitle,
        amount: txamount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAdTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addnewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransanction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _startAdTransaction(context),
          ),
        ],
        title: Center(
          child: Text(
            'Expense Tracker',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Card(
            elevation: 8.0,
            color: Colors.white,
            child: Chart(_recentTransactions),
          ),
          TransactionList(
              transactions: _userTransactions, delteTx: _deleteTransanction),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAdTransaction(context),
        elevation: 8.0,
        hoverColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
