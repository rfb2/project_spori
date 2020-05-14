import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectspori/detailPage.dart';

import 'fetchData.dart';
import 'dataClasses.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<Set<Product>> _results;

  @override
  void initState() {
    super.initState();
    searchProducts("");
  }

  Widget _buildForm(AsyncSnapshot<Set<Product>> snapshot) {
    final Iterable<Card> tiles = snapshot.data.map((Product prod) {
      return Card(
        child: ListTile(
          title: Text(
            prod.name,
          ),
          onTap: () => pushDetail(prod),
        ),
      );
    });
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();
    return ListView(
        children: divided,
        padding: const EdgeInsets.all(8.0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              autofocus: true,
              onChanged: (String value) => searchProducts(value),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
          Expanded(
            child: FutureBuilder<Set<Product>>(
              future: _results,
              builder:
                  (BuildContext context, AsyncSnapshot<Set<Product>> snapshot) {
                Widget children;

                if (snapshot.hasData) {
                  children = _buildForm(snapshot);
                } else if (snapshot.hasError) {
                  children = Column(children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Engar vörur fundust'),
                    )
                  ]);
                } else if (snapshot.connectionState == ConnectionState.none) {
                  children = Column(children: <Widget>[
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFF228B22),
                      size: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Vinsamlegast sláðu inn vöruheiti.'),
                    )
                  ]);
                } else {
                  children = Column(children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Bíðið andartak...'),
                    )
                  ]);
                }
                return Center(
                  child: children,
                );
              },
            )
          ),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom)),
        ],
      ),
    );
  }

  void searchProducts(String name) async {
    setState(() {
      _results = fetchProductsFromName(name);
    });
  }

  void pushDetail(Product prod) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DetailPage(product: prod)));
  }
}
