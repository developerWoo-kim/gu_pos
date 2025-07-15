import 'package:json_annotation/json_annotation.dart';

import 'item_option_model.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  final String orderItemId;
  final String orderItemNm;
  final int price;
  final int quantity;

  final List<ItemOptionModel> itemOptionList;

  OrderItemModel({
    required this.orderItemId,
    required this.orderItemNm,
    required this.price,
    required this.quantity,
    this.itemOptionList = const []
  });

  OrderItemModel copyWith({
    String? orderItemId,
    String? orderItemNm,
    int? price,
    int? quantity,
    List<ItemOptionModel>? itemOptionList,
  }) {
    return OrderItemModel(
      orderItemId: orderItemId ?? this.orderItemId,
      orderItemNm: orderItemNm ?? this.orderItemNm,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      itemOptionList: itemOptionList ?? this.itemOptionList,
    );
  }

  OrderItemModel addOption(ItemOptionModel option) {
    return copyWith(itemOptionList: [...itemOptionList, option]);
  }

  int get totalPrice =>
      price + itemOptionList.fold(0, (sum, option) => sum + option.optionPrice);

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => _$OrderItemModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

}