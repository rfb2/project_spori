import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dataClasses.dart';

final Future<Database> database = openDatabase(
  'product_database.db',
  onCreate: (db, version) {
    return db.execute(
      "CREATE TABLE products (id SERIAL PRIMARY KEY, name VARCHAR(128), code VARCHAR(13) NOT NULL, origin VARCHAR(128), originDistance REAL, score REAL NOT NULL, packaging VARCHAR(128), packagingFootprint REAL, packagingBreakdownTime REAL, packagingReusability INTEGER, packagingWeight REAL, grade REAL);"
    );
  },
  version: 1,
);

Future<void> saveProduct(Product product) async {
  final Database db = await database;
  await db.insert('products', product.toMap());
}

Stream<List<Product>> retrieveSavedProducts() async* {
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query('products');
  yield List.generate(maps.length, (i) {
    return Product(
      name: maps[i]['name'],
      code: maps[i]['code'],
      origin: maps[i]['origin'],
      originDistance: maps[i]['originDistance'],
      score: maps[i]['score'],
      packaging: maps[i]['packaging'],
      packagingFootprint: maps[i]['packagingFootprint'],
      packagingBreakdownTime: maps[i]['packagingBreakdownTime'],
      packagingReusability: maps[i]['packagingReusability'],
      packagingWeight: maps[i]['packagingWeight'],
      grade: maps[i]['grade'],
    );
  });
}

Future<void> clearSavedProducts() async {
  final Database db = await database;
  await db.delete('Products');
}
