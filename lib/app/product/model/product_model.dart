import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int productId;
  final String productNm;
  final String simpleDescription;
  final String description;
  final int productPrice;
  final String stockAt;
  final int? stockCount;

  ProductModel({
    required this.productId,
    required this.productNm,
    required this.simpleDescription,
    required this.description,
    required this.productPrice,
    required this.stockAt,
    this.stockCount
});

  ProductModel copyWith({
    int? productId,
    String? productNm,
    String? simpleDescription,
    String? description,
    int? productPrice,
    String? stockAt,
    int? stockCount,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productNm: productNm ?? this.productNm,
      simpleDescription: simpleDescription ?? this.simpleDescription,
      description: description ?? this.description,
      productPrice: productPrice ?? this.productPrice,
      stockAt: stockAt ?? this.stockAt,
      stockCount: stockCount ?? this.stockCount,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}