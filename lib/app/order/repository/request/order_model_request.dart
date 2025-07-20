import '../../model/order_model.dart';

extension OrderModelToRequestJson on OrderModel {
  Map<String, dynamic> toCreateRequestJson(String storeId) {
    return {
      'storeId': storeId,
      'orderType': orderType,
      'orderProductList': orderProductList.map((p) => {
        'productId': p.productId,
        'orderProductPrice': p.orderProductPrice,
        'quantity': p.quantity,
        'optionList': p.optionList.map((o) => {
          'optionId': o.optionId,
          'quantity': o.quantity,
        }).toList(),
      }).toList(),
    };
  }
}