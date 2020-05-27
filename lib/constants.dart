library constants;

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'dataClasses.dart';
import 'views/detailPage.dart';
import 'views/historyPage.dart';
import 'views/searchPage.dart';

final List<String> info = ['Engar upplýsingar', 'lágt', 'miðlungs', 'hátt'];

final Color primaryColor = Color(0xFF43A047);
final Color secondaryColor = Color(0xFFA5D6A7);

final TextStyle defaultTextStyle =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 20);

final TextStyle boldTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

final TextStyle headerTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 26);

final Widget defaultDivider = Divider(
  color: primaryColor,
  thickness: 2,
  indent: 8,
  endIndent: 8,
);

final Widget thinDivider = Divider(color: primaryColor);

final ThemeData myTheme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.light,
  primaryColor: primaryColor,
  accentColor: secondaryColor,

  // Define the default font family.
  fontFamily: 'Roboto Slab',
);

Widget gradeText(double grade) {
  Color color;
  if (grade < 5.0) {
    color = Color.fromARGB(255, 255, (255 / 5 * grade).round(), 0);
  } else {
    color = Color.fromARGB(255, 255 - (255 / 5 * grade).round(), 255, 0);
  }
  return Stack(
    children: <Widget>[
      // Stroked text as border.
      Text(
        grade.toStringAsPrecision(3),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.black,
        ),
      ),
      // Solid text as fill.
      Text(
        grade.toStringAsPrecision(3),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: color,
        ),
      ),
    ],
  );
}

void pushSearch(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => SearchPage()));
}

void pushDetail(BuildContext context, Product prod) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => DetailPage(product: prod)));
}

void pushHistory(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => HistoryPage()));
}

List<charts.Series<DataItem, dynamic>> chartData(Product prod) {
  final data = [
    DataItem('Flutningur', prod.originDistance),
    DataItem('Umbúðir', prod.packagingFootprint),
  ];

  return [
    new charts.Series<DataItem, dynamic>(
      id: 'Sales',
      domainFn: (DataItem product, _) => product.label,
      measureFn: (DataItem product, _) => product.data,
      data: data,
      labelAccessorFn: (DataItem row, _) => '${row.label}: ${row.data}',
    )
  ];
}
