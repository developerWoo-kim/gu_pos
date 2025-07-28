

import 'package:gu_pos/app/product/provider/product_option_group_edit_provider.dart';

extension ProductOptionGroupEditProviderModelRequest on ProductOptionGroupEditProviderModel {
  Map<String, dynamic> toCreateRequestJson() {
    return {
      'optionGroupNm': optionGroupNm,
      'requiredAt': requiredAt,
      'maxSelectionCount': maxSelectionCount,
      'optionList': optionList.map((p) => {
        'productOptionNm': p.productOptionNm,
        'optionPrice': p.optionPrice,
      }).toList(),
    };
  }
}