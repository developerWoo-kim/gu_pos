import 'package:gu_pos/app/order/component/order_status_view.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int? orderIndex;
  final String orderType;
  final List<OrderItemModel> orderProductList;
  final OrderStatus? orderStatus;
  final ApprovalStatus? approvalStatus;

  OrderModel({
    this.orderIndex,
    required this.orderType,
    required this.orderProductList,
    this.orderStatus,
    this.approvalStatus,
  });

  OrderModel copyWith({
    int? orderIndex,
    String? orderType,
    List<OrderItemModel>? orderProductList,
    OrderStatus? orderStatus,
    ApprovalStatus? approvalStatus,
  }) {
    return OrderModel(
      orderIndex: orderIndex ?? this.orderIndex,
      orderType: orderType ?? this.orderType,
      orderProductList: orderProductList ?? this.orderProductList,
      orderStatus: orderStatus ?? this.orderStatus,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }

  int get totalPrice =>
      orderProductList.fold(0, (sum, item) => sum + item.totalPrice);

  int get totalQuantity =>
      orderProductList.fold(0, (sum, item) => sum + item.quantity);

  String get totalOrderItemNm =>
      orderProductList.map((item) => '${item.orderItemNm} x${item.quantity}').join(', ');


  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

enum OrderStatus {
  PROGRESS('진행'),
  COMPLETE('완료'),
  CANCEL('취소');

  final String label;
  const OrderStatus(this.label);
}

enum ApprovalStatus {
  WAIT('결제대기'),
  COMPLETE('결제완료'),
  CANCEL('취소');

  final String label;
  const ApprovalStatus(this.label);
}