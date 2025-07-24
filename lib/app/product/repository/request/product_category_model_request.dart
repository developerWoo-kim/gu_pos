import 'package:gu_pos/app/product/model/product_category_model.dart';

extension ProductCategoryMomelToRequestJson on ProductCategoryModel {
  Map<String, dynamic> toUpdateRequestJson() {
    return {
      'categoryId': categoryId,
      'categoryNm': categoryNm,
    };
  }

  Map<String, dynamic> toUpdateSortOrderJson(int index) {
    return {
      'categoryId': categoryId,
      'sortOrder': index,
    };
  }

}