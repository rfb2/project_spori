import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

import '../fetchData.dart';
import '../dataClasses.dart';

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
    final Iterable<ListTile> tiles = snapshot.data.map((Product prod) {
      return ListTile(
        title: Text(
          prod.name,
        ),
        onTap: () => Constants.pushDetail(context, prod),
      );
    });
    return ListView.separated(
        separatorBuilder: (context, i) => Constants.defaultDivider,
        itemCount: tiles.length,
        itemBuilder: (context, i) {
          return tiles.elementAt(i);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Leit'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              cursorColor: Color(0xFF006400),
              autofocus: true,
              onChanged: (String value) => searchProducts(value),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 8)),
          Constants.thinDivider,
          Expanded(
              child: FutureBuilder<Set<Product>>(
            future: _results,
            builder:
                (BuildContext context, AsyncSnapshot<Set<Product>> snapshot) {
              Widget children;

              if (snapshot.hasData) {
                children = _buildForm(snapshot);
              } else if (snapshot.hasError) {
                print(snapshot.error);
                children = Column(children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 80,
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
                    size: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Vinsamlegast sláðu inn vöruheiti.'),
                  )
                ]);
              } else {
                children = Column(children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Constants.primaryColor),
                    ),
                    width: 80,
                    height: 80,
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
          )),
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
}
