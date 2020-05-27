class Product {
  final String name;
  final String code;
  final String origin;
  final num originDistance;
  final num score;
  final String packaging;
  final num packagingFootprint;
  final num packagingBreakdownTime;
  final int packagingReusability;
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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'origin': origin,
      'originDistance': originDistance,
      'score': score,
      'packaging': packaging,
      'packagingFootprint': packagingFootprint,
      'packagingBreakdownTime': packagingBreakdownTime,
      'packagingReusability': packagingReusability,
      'grade': grade,
    };
  }
}

class DataItem {
  final String label;
  final num data;

  DataItem(this.label, this.data);
}
