import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_option_model.g.dart';

@JsonSerializable()
class ItemOptionModel {
  final int optionId;
  final String optionNm;
  final int optionPrice;

  ItemOptionModel({
    required this.optionId,
    required this.optionNm,
    required this.optionPrice
  });

  ItemOptionModel copyWith({
    int? optionId,
    String? optionNm,
    int? optionPrice,
  }) {
    return ItemOptionModel(
      optionId: optionId ?? this.optionId,
      optionNm: optionNm ?? this.optionNm,
      optionPrice: optionPrice ?? this.optionPrice,
    );
  }

  factory ItemOptionModel.fromJson(Map<String, dynamic> json) => _$ItemOptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ItemOptionModelToJson(this);
}