import 'package:gu_pos/app/product/model/product_option_group_model.dart';
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

  final List<ProductOptionGroupModel>? optionGroupList;

  ProductModel({
    required this.productId,
    required this.productNm,
    required this.simpleDescription,
    required this.description,
    required this.productPrice,
    required this.stockAt,
    this.stockCount,
    this.optionGroupList,
});

  ProductModel copyWith({
    int? productId,
    String? productNm,
    String? simpleDescription,
    String? description,
    int? productPrice,
    String? stockAt,
    int? stockCount,
    List<ProductOptionGroupModel>? optionGroupList,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productNm: productNm ?? this.productNm,
      simpleDescription: simpleDescription ?? this.simpleDescription,
      description: description ?? this.description,
      productPrice: productPrice ?? this.productPrice,
      stockAt: stockAt ?? this.stockAt,
      stockCount: stockCount ?? this.stockCount,
      optionGroupList: optionGroupList ?? this.optionGroupList,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}