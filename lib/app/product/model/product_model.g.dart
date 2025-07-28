// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: (json['productId'] as num).toInt(),
      productNm: json['productNm'] as String,
      simpleDescription: json['simpleDescription'] as String,
      description: json['description'] as String,
      productPrice: (json['productPrice'] as num).toInt(),
      stockAt: json['stockAt'] as String,
      stockCount: (json['stockCount'] as num?)?.toInt(),
      optionGroupList: (json['optionGroupList'] as List<dynamic>?)
          ?.map((e) =>
              ProductOptionGroupModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productNm': instance.productNm,
      'simpleDescription': instance.simpleDescription,
      'description': instance.description,
      'productPrice': instance.productPrice,
      'stockAt': instance.stockAt,
      'stockCount': instance.stockCount,
      'optionGroupList': instance.optionGroupList,
    };
