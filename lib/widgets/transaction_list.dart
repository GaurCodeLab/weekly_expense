import 'package:expens_tracker/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delteTx;

  TransactionList({@required this.transactions, @required this.delteTx});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transaction added yet',
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'images/emptylist.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () => delteTx(transactions[index].id),
                      ),
                      leading: CircleAvatar(
                        radius: 30.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: FittedBox(
                              child: Text('\$${transactions[index].amount}')),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
