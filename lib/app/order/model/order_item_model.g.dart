// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      orderItemId: json['orderItemId'] as String,
      orderItemNm: json['orderItemNm'] as String,
      price: (json['price'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      itemOptionList: (json['itemOptionList'] as List<dynamic>?)
              ?.map((e) => ItemOptionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'orderItemId': instance.orderItemId,
      'orderItemNm': instance.orderItemNm,
      'price': instance.price,
      'quantity': instance.quantity,
      'itemOptionList': instance.itemOptionList,
    };
