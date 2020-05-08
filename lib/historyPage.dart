import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart' as Constants;
import 'dataClasses.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({@required this.history});
  final Set<Product> history;

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = history.map((Product prod) {
      return ListTile(
        title: Text(
          prod.name,
        ),
        onTap: () => Constants.pushDetail(context, prod),
      );
    });

    Widget historyChild;

    if (tiles.length == 0) {
      historyChild = Center(
        child: Text('Engar vörur í sögu'),
      );
    } else {
      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();
      historyChild = ListView(children: divided);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: historyChild,
    );
  }
}