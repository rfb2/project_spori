import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dataClasses.dart';

Future<Product> fetchProduct(String barcode) async {
  final response =
      await http.get('https://spori-backend.herokuapp.com/products/$barcode');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Product.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Product');
  }
}

Future<Set<Product>> fetchProductsFromName(String name) async {
  final response =
      await http.get('https://spori-backend.herokuapp.com/products?name=$name');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final Set<Product> _results = Set<Product>();
    final jsonProd = json.decode(response.body);
    for (Map prod in jsonProd) {
      _results.add(Product.fromJson(prod));
    }
    return _results;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Product');
  }
}
