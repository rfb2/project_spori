import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fetchData.dart';
import 'dataClasses.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<Set<Product>> _results;

  Widget _buildForm(AsyncSnapshot<Set<Product>> snapshot) {
    final Iterable<ListTile> tiles = snapshot.data.map((Product prod) {
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
    return ListView(children: divided, shrinkWrap: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            onChanged: (String value) => searchProducts(value),
          ),
          FutureBuilder<Set<Product>>(
            future: _results,
            builder:
                (BuildContext context, AsyncSnapshot<Set<Product>> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                children = <Widget>[_buildForm(snapshot)];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Engar vörur fundust'),
                  )
                ];
              } else if (snapshot.connectionState == ConnectionState.none) {
                children = <Widget>[
                  Icon(
                    Icons.info_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Vinsamlegast sláðu inn vöruheiti.'),
                  )
                ];
              } else {
                children = <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Bíðið andartak...'),
                  )
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void searchProducts(String name) async {
    setState(() {
      _results = fetchProductsFromName(name);
    });
  }
}
