import 'package:json_annotation/json_annotation.dart';

part 'product_option_model.g.dart';

@JsonSerializable()
class ProductOptionModel {
  final int productOptionId;
  final String productOptionNm;
  final int optionPrice;
  final int sortOrder;

  ProductOptionModel({
    required this.productOptionId,
    required this.productOptionNm,
    required this.optionPrice,
    required this.sortOrder
  });

  ProductOptionModel copyWith({
    int? productOptionId,
    String? productOptionNm,
    int? optionPrice,
    int? sortOrder,
  }) {
    return ProductOptionModel(
      productOptionId: productOptionId ?? this.productOptionId,
      productOptionNm: productOptionNm ?? this.productOptionNm,
      optionPrice: optionPrice ?? this.optionPrice,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) => _$ProductOptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOptionModelToJson(this);
}