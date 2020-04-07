class Product {
  final int id;
  final String name;
  final String code;
  final String packaging;
  final String origin;
  final num score;

  Product(
      {this.id, this.name, this.code, this.packaging, this.origin, this.score});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      packaging: json['packaging'],
      origin: json['origin'],
      score: json['score'],
    );
  }
}
