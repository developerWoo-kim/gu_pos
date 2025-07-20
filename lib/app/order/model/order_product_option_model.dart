import 'package:json_annotation/json_annotation.dart';

part 'order_product_option_model.g.dart';

@JsonSerializable()
class OrderProductOption {
  final int optionId;
  final String optionNm;
  final int optionPrice;
  final int quantity;

  OrderProductOption({
    required this.optionId,
    required this.optionNm,
    required this.optionPrice,
    this.quantity = 1,
  });

  OrderProductOption copyWith({
    int? optionId,
    String? optionNm,
    int? optionPrice,
    int? quantity,
  }) {
    return OrderProductOption(
      optionId: optionId ?? this.optionId,
      optionNm: optionNm ?? this.optionNm,
      optionPrice: optionPrice ?? this.optionPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  factory OrderProductOption.fromJson(Map<String, dynamic> json) => _$OrderProductOptionFromJson(json);
  Map<String, dynamic> toJson() => _$OrderProductOptionToJson(this);
}