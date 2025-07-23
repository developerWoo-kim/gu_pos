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

  ProductCategoryModel({
    required this.categoryId,
    required this.categoryNm,
    required this.sortOrder,
    required this.productList,
    this.isEditing = false
  });

  ProductCategoryModel copyWith({
    int? categoryId,
    String? categoryNm,
    int? sortOrder,
    List<ProductModel>? productList,
    bool? isEditing,
  }) {
    return ProductCategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryNm: categoryNm ?? this.categoryNm,
      sortOrder: sortOrder ?? this.sortOrder,
      productList: productList ?? this.productList,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => _$ProductCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCategoryModelToJson(this);
}