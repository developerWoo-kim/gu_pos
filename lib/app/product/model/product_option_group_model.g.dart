// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOptionGroupModel _$ProductOptionGroupModelFromJson(
        Map<String, dynamic> json) =>
    ProductOptionGroupModel(
      productOptionGroupId: (json['productOptionGroupId'] as num).toInt(),
      productOptionGroupNm: json['productOptionGroupNm'] as String,
      requiredAt: json['requiredAt'] as String,
      maxSelectionCount: (json['maxSelectionCount'] as num).toInt(),
      sortOrder: (json['sortOrder'] as num).toInt(),
      optionList: (json['optionList'] as List<dynamic>)
          .map((e) => ProductOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductOptionGroupModelToJson(
        ProductOptionGroupModel instance) =>
    <String, dynamic>{
      'productOptionGroupId': instance.productOptionGroupId,
      'productOptionGroupNm': instance.productOptionGroupNm,
      'requiredAt': instance.requiredAt,
      'maxSelectionCount': instance.maxSelectionCount,
      'sortOrder': instance.sortOrder,
      'optionList': instance.optionList,
      'isSelected': instance.isSelected,
    };
