// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      orderProductId: (json['orderProductId'] as num?)?.toInt(),
      productId: (json['productId'] as num).toInt(),
      productNm: json['productNm'] as String,
      productPrice: (json['productPrice'] as num).toInt(),
      orderProductPrice: (json['orderProductPrice'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      optionList: (json['optionList'] as List<dynamic>?)
              ?.map(
                  (e) => OrderProductOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      'orderProductId': instance.orderProductId,
      'productId': instance.productId,
      'productNm': instance.productNm,
      'productPrice': instance.productPrice,
      'orderProductPrice': instance.orderProductPrice,
      'quantity': instance.quantity,
      'optionList': instance.optionList,
      'isSelected': instance.isSelected,
    };
