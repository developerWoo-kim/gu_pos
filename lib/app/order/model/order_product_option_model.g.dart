// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductOption _$OrderProductOptionFromJson(Map<String, dynamic> json) =>
    OrderProductOption(
      optionId: (json['optionId'] as num).toInt(),
      optionNm: json['optionNm'] as String,
      optionPrice: (json['optionPrice'] as num).toInt(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$OrderProductOptionToJson(OrderProductOption instance) =>
    <String, dynamic>{
      'optionId': instance.optionId,
      'optionNm': instance.optionNm,
      'optionPrice': instance.optionPrice,
      'quantity': instance.quantity,
    };
