// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemOptionModel _$ItemOptionModelFromJson(Map<String, dynamic> json) =>
    ItemOptionModel(
      optionId: (json['optionId'] as num).toInt(),
      optionNm: json['optionNm'] as String,
      optionPrice: (json['optionPrice'] as num).toInt(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$ItemOptionModelToJson(ItemOptionModel instance) =>
    <String, dynamic>{
      'optionId': instance.optionId,
      'optionNm': instance.optionNm,
      'optionPrice': instance.optionPrice,
      'quantity': instance.quantity,
    };
