import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendinamount;
  final double spendingPctOfTotal;
  ChartBar(this.label, this.spendinamount, this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 20.0,
            child: FittedBox(
                child: Text('\$${spendinamount.toStringAsFixed(0)}'))),
        SizedBox(
          height: 4,
        ),
        Container(
            height: 60,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(210, 210, 210, 1),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                )
              ],
            )),
        Text(label),
      ],
    );
  }
}
