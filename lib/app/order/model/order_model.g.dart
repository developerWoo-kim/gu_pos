// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      orderIndex: (json['orderIndex'] as num?)?.toInt(),
      orderType: json['orderType'] as String,
      orderProductList: (json['orderProductList'] as List<dynamic>)
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderStatus:
          $enumDecodeNullable(_$OrderStatusEnumMap, json['orderStatus']),
      approvalStatus:
          $enumDecodeNullable(_$ApprovalStatusEnumMap, json['approvalStatus']),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderIndex': instance.orderIndex,
      'orderType': instance.orderType,
      'orderProductList': instance.orderProductList,
      'orderStatus': _$OrderStatusEnumMap[instance.orderStatus],
      'approvalStatus': _$ApprovalStatusEnumMap[instance.approvalStatus],
    };

const _$OrderStatusEnumMap = {
  OrderStatus.PROGRESS: 'PROGRESS',
  OrderStatus.COMPLETE: 'COMPLETE',
  OrderStatus.CANCEL: 'CANCEL',
};

const _$ApprovalStatusEnumMap = {
  ApprovalStatus.WAIT: 'WAIT',
  ApprovalStatus.COMPLETE: 'COMPLETE',
  ApprovalStatus.CANCEL: 'CANCEL',
};
