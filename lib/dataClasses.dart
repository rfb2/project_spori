import 'package:charts_flutter/flutter.dart';

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
  final num packagingWeight;
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
    this.packagingWeight,
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
      packagingWeight: json['packaging_weight'],
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
      'packagingWeight': packagingWeight,
      'grade': grade,
    };
  }
}

class DataItem {
  final String label;
  final num data;
  final Color color;

  DataItem(this.label, this.data, this.color);
}
