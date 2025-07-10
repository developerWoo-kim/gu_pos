import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gu_pos/common/component/app/order/order_status_view.dart';

import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String orderType;
  final List<OrderItemModel> orderItemList;
  final OrderStatus? orderStatus;
  final ApprovalStatus? approvalStatus;

  OrderModel({
    required this.orderType,
    required this.orderItemList,
    this.orderStatus,
    this.approvalStatus,
  });

  OrderModel copyWith({
    String? orderType,
    List<OrderItemModel>? orderItemList,
    OrderStatus? orderStatus,
    ApprovalStatus? approvalStatus,
  }) {
    return OrderModel(
      orderType: orderType ?? this.orderType,
      orderItemList: orderItemList ?? this.orderItemList,
      orderStatus: orderStatus ?? this.orderStatus,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }

  int get totalPrice =>
      orderItemList.fold(0, (sum, item) => sum + item.totalPrice);


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