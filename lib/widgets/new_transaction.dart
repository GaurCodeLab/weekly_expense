import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function adTx;

  NewTransaction(this.adTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    void submitted() {
      final enteredTitle = titleController.text;
      final entererdAmount = double.parse(amountController.text);

      if (enteredTitle.isEmpty || entererdAmount <= 0 || selectedDate == null)
        return;

      widget.adTx(enteredTitle, entererdAmount, selectedDate);
      Navigator.of(context).pop();
    }

    void presentDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          selectedDate = pickedDate;
        });
      });
    }

    return Card(
      elevation: 8.0,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration:
                  InputDecoration(labelText: 'Title', focusColor: Colors.red),
              onSubmitted: (_) => submitted(),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitted(),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(selectedDate == null
                      ? 'No Date selected'
                      : 'Picked Date : ${DateFormat.yMd().format(selectedDate)}'),
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    presentDatePicker();
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: submitted,
              child: Text(
                'Add Transaction',
              ),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
          ],
        ),
      ),
    );
  }
}
