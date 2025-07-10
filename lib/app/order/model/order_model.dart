import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String orderType;
  final List<OrderItemModel> orderItemList;

  OrderModel({
    required this.orderType,
    required this.orderItemList,
  });

  OrderModel copyWith({
    String? orderType,
    List<OrderItemModel>? orderItemList,
  }) {
    return OrderModel(
      orderType: orderType ?? this.orderType,
      orderItemList: orderItemList ?? this.orderItemList,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}