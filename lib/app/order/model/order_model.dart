import 'package:gu_pos/app/order/component/order_status_view.dart';
import 'package:gu_pos/app/order/model/order_product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int? orderId;
  final String orderType;
  final List<OrderProductModel> orderProductList;
  final OrderStatus? orderStatus;
  final ApprovalStatus? approvalStatus;

  OrderModel({
    this.orderId,
    required this.orderType,
    required this.orderProductList,
    this.orderStatus,
    this.approvalStatus,
  });

  OrderModel copyWith({
    int? orderId,
    String? orderType,
    List<OrderProductModel>? orderProductList,
    OrderStatus? orderStatus,
    ApprovalStatus? approvalStatus,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      orderType: orderType ?? this.orderType,
      orderProductList: orderProductList ?? this.orderProductList,
      orderStatus: orderStatus ?? this.orderStatus,
      approvalStatus: approvalStatus ?? this.approvalStatus,
    );
  }

  int get totalPrice =>
      orderProductList.fold(0, (sum, od) => sum + od.totalPrice);

  int get totalQuantity =>
      orderProductList.fold(0, (sum, od) => sum + od.quantity);

  String get totalOrderItemNm =>
      orderProductList.map((od) => '${od.productNm} x${od.quantity}').join(', ');

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