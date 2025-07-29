
import 'package:gu_pos/app/product/model/product_option_group_model.dart';
import 'package:gu_pos/app/product/provider/product_edit_provider.dart';

extension ProductEditProviderModelRequest on ProductEditProviderModel {
  Map<String, dynamic> toCreateRequestJson(List<ProductOptionGroupModel> optionGroups) {
    return {
      'productNm': productNm,
      'categoryId': categoryId,
      'productPrice': productPrice,
      'stockAt': stockAt,
      'stockCount': stockCount,
      'optionGroupIds': optionGroups.map((e) => e.productOptionGroupId).toList(),
    };
  }
}