library constants;

import 'package:flutter/material.dart';

import 'dataClasses.dart';
import 'detailPage.dart';
import 'historyPage.dart';
import 'searchPage.dart';

final List<String> info = ['Engar upplýsingar', 'lágt', 'miðlungs', 'hátt'];

final Color primaryColor = Color(0xFF228B22);

final TextStyle defaultTextStyle =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 20);

final TextStyle boldTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

void pushSearch(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => SearchPage()));
}

void pushDetail(BuildContext context, Product prod) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => DetailPage(product: prod)));
}

void pushHistory(BuildContext context, Set<Product> history) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => HistoryPage(history: history)));
}
