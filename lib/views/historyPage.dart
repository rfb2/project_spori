import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as Constants;
import '../dataClasses.dart';
import '../database.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Stream<List<Product>> _history;

  void deleteHistory() async {
    Widget cancelButton = FlatButton(
      child: Text("Nei, til baka!"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Já, eyða sögu!"),
      onPressed: () async {
        Navigator.of(context).pop();
        await clearSavedProducts();
        setState(() {
          _history = retrieveSavedProducts();
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Eyða sögu?"),
      content: Text(
          "Ertu viss um að þú viljir eyða allri sögunni? (Óafturkallanlegt)"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    setState(() {
      _history = retrieveSavedProducts();
    });
    super.initState();
  }

  Widget _buildHistory(AsyncSnapshot<List<Product>> snapshot) {
    final Iterable<ListTile> tiles = snapshot.data.map((Product prod) {
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
      historyChild = ListView.separated(
          separatorBuilder: (context, i) => Constants.defaultDivider,
          itemCount: tiles.length,
          itemBuilder: (context, i) {
            return tiles.elementAt(i);
          });
    }
    return historyChild;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saga'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deleteHistory,
          ),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: _history,
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          Widget children;

          if (snapshot.hasData) {
            children = _buildHistory(snapshot);
          } else if (snapshot.hasError) {
            children = Column(children: <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 80,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Villa að ná í sögu'),
              )
            ]);
          } else {
            children = Column(children: <Widget>[
              SizedBox(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Constants.primaryColor),
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
      ),
    );
  }
}
