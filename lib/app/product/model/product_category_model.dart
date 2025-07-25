import 'package:gu_pos/app/product/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_category_model.g.dart';

@JsonSerializable()
class ProductCategoryModel {
  final int categoryId;
  final String categoryNm;
  final int sortOrder;

  final List<ProductModel> productList;

  final bool isEditing;
  final bool isSelected;

  ProductCategoryModel({
      required this.categoryId,
      required this.categoryNm,
      required this.sortOrder,
      required this.productList,
      this.isEditing = false,
      this.isSelected = false,
  });

  ProductCategoryModel copyWith({
    int? categoryId,
    String? categoryNm,
    int? sortOrder,
    List<ProductModel>? productList,
    bool? isEditing,
    bool? isSelected,
  }) {
    return ProductCategoryModel(
        categoryId: categoryId ?? this.categoryId,
        categoryNm: categoryNm ?? this.categoryNm,
        sortOrder: sortOrder ?? this.sortOrder,
        productList: productList ?? this.productList,
        isEditing: isEditing ?? this.isEditing,
        isSelected: isSelected ?? this.isSelected,
    );
  }

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => _$ProductCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCategoryModelToJson(this);
}