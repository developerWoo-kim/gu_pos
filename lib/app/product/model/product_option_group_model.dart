import 'package:gu_pos/app/product/model/product_option_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_option_group_model.g.dart';

@JsonSerializable()
class ProductOptionGroupModel {
  final int productOptionGroupId;
  final String productOptionGroupNm;
  final String requiredAt;
  final int maxSelectionCount;
  final int sortOrder;

  final List<ProductOptionModel> optionList;

  final bool isSelected;

  ProductOptionGroupModel({
    required this.productOptionGroupId,
    required this.productOptionGroupNm,
    required this.requiredAt,
    required this.maxSelectionCount,
    required this.sortOrder,
    required this.optionList,
    this.isSelected = false,
  });

  ProductOptionGroupModel copyWith({
    int? productOptionGroupId,
    String? productOptionGroupNm,
    String? requiredAt,
    int? maxSelectionCount,
    int? sortOrder,
    List<ProductOptionModel>? optionList,
    bool? isSelected,
  }) {
    return ProductOptionGroupModel(
      productOptionGroupId: productOptionGroupId ?? this.productOptionGroupId,
      productOptionGroupNm: productOptionGroupNm ?? this.productOptionGroupNm,
      requiredAt: requiredAt ?? this.requiredAt,
      maxSelectionCount: maxSelectionCount ?? this.maxSelectionCount,
      sortOrder: sortOrder ?? this.sortOrder,
      optionList : optionList ?? this.optionList,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory ProductOptionGroupModel.fromJson(Map<String, dynamic> json) => _$ProductOptionGroupModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOptionGroupModelToJson(this);


}