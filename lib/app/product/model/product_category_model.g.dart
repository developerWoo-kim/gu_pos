// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryModel _$ProductCategoryModelFromJson(
        Map<String, dynamic> json) =>
    ProductCategoryModel(
      categoryId: (json['categoryId'] as num).toInt(),
      categoryNm: json['categoryNm'] as String,
      sortOrder: (json['sortOrder'] as num).toInt(),
      productList: (json['productList'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isEditing: json['isEditing'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductCategoryModelToJson(
        ProductCategoryModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryNm': instance.categoryNm,
      'sortOrder': instance.sortOrder,
      'productList': instance.productList,
      'isEditing': instance.isEditing,
      'isSelected': instance.isSelected,
    };
