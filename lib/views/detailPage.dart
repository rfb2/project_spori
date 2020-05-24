import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

import '../dataClasses.dart';

class DetailPage extends StatelessWidget {
  DetailPage({@required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${product.name}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => _pushInfo(context),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('Nafn á vöru: ',
                              style: Constants.defaultTextStyle),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('${product.name}',
                              style: Constants.boldTextStyle),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('Einkunn: ',
                              style: Constants.defaultTextStyle),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Constants.gradeText(product.grade)
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('Upprunaland: ',
                              style: Constants.defaultTextStyle),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('${product.origin}',
                              style: Constants.boldTextStyle),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('Umbúðir: ',
                              style: Constants.defaultTextStyle),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('${product.packaging}',
                              style: Constants.boldTextStyle),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('Niðurbrotstími umbúða: ',
                              style: Constants.defaultTextStyle),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                              '${Constants.info[product.packagingBreakdownTime]}',
                              style: Constants.boldTextStyle),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('Endurnýtanleiki umbúða: ',
                              style: Constants.defaultTextStyle),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                              '${Constants.info[product.packagingReusability]}',
                              style: Constants.boldTextStyle),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _pushInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Upplýsingar'),
            ),
            body: Column(
              children: <Widget>[
                Center(
                  child: Text('Ble'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
