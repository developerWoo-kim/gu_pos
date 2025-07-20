import 'package:gu_pos/app/order/model/order_product_option_model.dart';
import 'package:gu_pos/app/product/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_product_model.g.dart';

@JsonSerializable()
class OrderProductModel {
  final int? orderProductId;
  final int productId;
  final String productNm;
  final int productPrice;
  final int orderProductPrice;
  final int quantity;

  final List<OrderProductOption> optionList;

  OrderProductModel({
    this.orderProductId,
    required this.productId,
    required this.productNm,
    required this.productPrice,
    required this.orderProductPrice,
    required this.quantity,
    this.optionList = const []
  });

  OrderProductModel copyWith({
    int? orderProductId,
    int? productId,
    String? productNm,
    int? productPrice,
    int? orderProductPrice,
    int? quantity,
    List<OrderProductOption>? optionList,
  }) {
    return OrderProductModel(
      orderProductId: orderProductId ?? this.orderProductId,
      productId: productId ?? this.productId,
      productNm: productNm ?? this.productNm,
      productPrice: productPrice ?? this.productPrice,
      orderProductPrice: orderProductPrice ?? this.orderProductPrice,
      quantity: quantity ?? this.quantity,
      optionList: optionList ?? this.optionList,
    );
  }

  OrderProductModel addOption(OrderProductOption option) {
    return copyWith(optionList: [...optionList, option]);
  }

  int get totalPrice =>
      orderProductPrice + optionList.fold(0, (sum, option) => sum + option.optionPrice);

  factory OrderProductModel.fromJson(Map<String, dynamic> json) => _$OrderProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}