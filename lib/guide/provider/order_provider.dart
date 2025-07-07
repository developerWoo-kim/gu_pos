import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/guide/model/item_option_model.dart';
import 'package:gu_pos/guide/model/order_model.dart';

import '../model/order_item_model.dart';

final orderProvider = StateNotifierProvider<OrderStateNotifier, OrderModel>((ref) => OrderStateNotifier());

class OrderStateNotifier extends StateNotifier<OrderModel> {
  OrderStateNotifier()
      : super(OrderModel(orderType: '', orderItemList: []));

  void addItem(OrderItemModel item) {
    final existingIndex = state.orderItemList.indexWhere((e) => e.orderItemId == item.orderItemId);
    final updatedList = [...state.orderItemList];

    if (existingIndex != -1) {
      // 기존 아이템 업데이트 + 삭제 + 맨 앞에 추가
      final existingItem = updatedList.removeAt(existingIndex);
      final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + 1);
      updatedList.insert(0, updatedItem);
    } else {
      // 새 아이템 맨 앞에 추가
      updatedList.insert(0, item);
    }

    state = state.copyWith(orderItemList: updatedList);
  }

  void removeItem(int index) {
    final newList = [...state.orderItemList]..removeAt(index);
    state = state.copyWith(orderItemList: newList);
  }

  void clearItems() {
    state = state.copyWith(orderItemList: []);
  }

  void updateOrderList(List<OrderItemModel> newList) {
    state = state.copyWith(orderItemList: newList);
  }

  void addItemOption(String orderItemId, {
    required ItemOptionModel item,
  }) {
    final existingIndex = state.orderItemList.indexWhere((e) => e.orderItemId == orderItemId);
    if (existingIndex != -1) {
      final updatedOptionList = [...state.orderItemList[existingIndex].itemOptionList];
      // state.orderItemList[existingIndex].copyWith(itemOptionList: );
    }
    
  }
}