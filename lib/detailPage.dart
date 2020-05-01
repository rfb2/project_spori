import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dataClasses.dart';

class DetailPage extends StatelessWidget {
  DetailPage({@required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${product.name}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('Nafn á vöru: ${product.name}'),
          ),
          Center(
            child: Row(
              children: <Widget>[
                Text('Einkunn: '),
                Text(
                  '${product.grade.toStringAsPrecision(3)}',
                  style: (() {
                    if (product.grade < 3.33) {
                      return TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24, color: Colors.red);
                    } else if (product.grade < 6.66) {
                      return TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24, color: Colors.yellow);
                    } else {
                      return TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24, color: Colors.green);
                    }
                  }()),
                ),
              ],
            ),
          ),
          Center(
            child: Text('Nafn á vöru: ${product.name}'),
          ),
        ],
      ),
    );
  }
}
