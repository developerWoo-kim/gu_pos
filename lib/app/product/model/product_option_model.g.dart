// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionModel _$ProductOptionModelFromJson(Map<String, dynamic> json) =>
    ProductOptionModel(
      productOptionId: (json['productOptionId'] as num).toInt(),
      productOptionNm: json['productOptionNm'] as String,
      optionPrice: (json['optionPrice'] as num).toInt(),
      sortOrder: (json['sortOrder'] as num).toInt(),
    );

Map<String, dynamic> _$ProductOptionModelToJson(ProductOptionModel instance) =>
    <String, dynamic>{
      'productOptionId': instance.productOptionId,
      'productOptionNm': instance.productOptionNm,
      'optionPrice': instance.optionPrice,
      'sortOrder': instance.sortOrder,
    };
