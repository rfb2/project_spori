class Product {
  final String name;
  final String code;
  final String origin;
  final num originDistance;
  final num score;
  final String packaging;
  final num packagingFootprint;
  final num packagingBreakdownTime;
  final num packagingReusability;
  final double grade;

  Product({
    this.name,
    this.code,
    this.origin,
    this.originDistance,
    this.score,
    this.packaging,
    this.packagingFootprint,
    this.packagingBreakdownTime,
    this.packagingReusability,
    this.grade,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      code: json['code'],
      origin: json['origin'],
      originDistance: json['origin_distance'],
      score: json['score'],
      packaging: json['packaging'],
      packagingFootprint: json['packaging_footprint'],
      packagingBreakdownTime: json['packaging_breakdown_time'],
      packagingReusability: json['packaging_reusability'],
      grade: json['grade'],
    );
  }
}
