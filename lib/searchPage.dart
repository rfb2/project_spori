import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fetchData.dart';
import 'dataClasses.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Set<Product> _results = Set<Product>();

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = _results.map((Product prod) {
      return ListTile(
        title: Text(
          prod.name,
        ),
      );
    });
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (String value) => searchProducts(value),
          ),
          ListView(children: divided, shrinkWrap: true),
        ],
      ),
    );
  }

  Future<void> searchProducts(String name) async {
    Set<Product> results = await fetchProductsFromName(name);
    setState(() {
      _results = results;
    });
  }
}
