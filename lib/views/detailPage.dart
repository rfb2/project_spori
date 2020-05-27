import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../constants.dart' as Constants;

import '../dataClasses.dart';

class DetailPage extends StatelessWidget {
  DetailPage({@required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final List<charts.Series> seriesList = Constants.chartData(product);
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
                  children: <Widget>[
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width-50,
                      child: Center(
                        child: new charts.PieChart(
                          seriesList,
                          animate: true,
                          defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 60,
                              arcRendererDecorators: [
                                new charts.ArcLabelDecorator()
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text('${product.name}',
                              style: Constants.headerTextStyle),
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
                        Center(child: Constants.gradeText(product.grade)),
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
                              '${product.packagingBreakdownTime}',
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
