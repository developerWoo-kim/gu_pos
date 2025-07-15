
import 'package:json_annotation/json_annotation.dart';

part 'item_option_model.g.dart';

@JsonSerializable()
class ItemOptionModel {
  final int optionId;
  final String optionNm;
  final int optionPrice;
  final int quantity;

  ItemOptionModel({
    required this.optionId,
    required this.optionNm,
    required this.optionPrice,
    this.quantity = 1,
  });

  ItemOptionModel copyWith({
    int? optionId,
    String? optionNm,
    int? optionPrice,
    int? quantity,
  }) {
    return ItemOptionModel(
      optionId: optionId ?? this.optionId,
      optionNm: optionNm ?? this.optionNm,
      optionPrice: optionPrice ?? this.optionPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ItemOptionModel.fromJson(Map<String, dynamic> json) => _$ItemOptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemOptionModelToJson(this);
}