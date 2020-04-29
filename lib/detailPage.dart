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
      body: Center(
        child: Text('${product.name}')
      ),
    );
  }
}