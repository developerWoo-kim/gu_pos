import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/provider/order_status_provider.dart';
import '../model/item_option_model.dart';
import '../model/order_item_model.dart';
import '../model/order_model.dart';

final orderProvider = StateNotifierProvider<OrderStateNotifier, OrderModel>((ref) => OrderStateNotifier(ref));

class OrderStateNotifier extends StateNotifier<OrderModel> {
  final Ref ref;

  OrderStateNotifier(this.ref)
      : super(OrderModel(orderType: '', orderProductList: []));

  void order() {
    Map<String, dynamic> json = state.toJson();
    ref.read(orderStatusProvider.notifier).addOrder(state);

    clearItems();
  }

  void addItem(OrderItemModel item) {
    final existingIndex = state.orderProductList.indexWhere((e) => e.orderItemId == item.orderItemId);
    final updatedList = [...state.orderProductList];

    if (existingIndex != -1) {
      // 기존 아이템 업데이트 + 삭제 + 맨 앞에 추가
      final existingItem = updatedList.removeAt(existingIndex);
      final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + 1);
      updatedList.insert(0, updatedItem);
    } else {
      // 새 아이템 맨 앞에 추가
      updatedList.insert(0, item);
    }

    state = state.copyWith(orderProductList: updatedList);
  }

  void removeItem(int index) {
    final newList = [...state.orderProductList]..removeAt(index);
    state = state.copyWith(orderProductList: newList);
  }

  void clearItems() {
    state = state.copyWith(orderProductList: []);
  }

  void updateOrderList(List<OrderItemModel> newList) {
    state = state.copyWith(orderProductList: newList);
  }

  void addItemOption(int orderItemIndex, {
    required ItemOptionModel item,
  }) {
    final currentItem = state.orderProductList[orderItemIndex];
    final currentOptions = currentItem.itemOptionList;

    final existingIndex = currentOptions.indexWhere((e) => e.optionId == item.optionId);

    List<ItemOptionModel> updatedOptions;

    if (existingIndex != -1) {
      // 이미 있는 옵션: 수량 증가
      final existingOption = currentOptions[existingIndex];
      final updatedOption = existingOption.copyWith(
        quantity: existingOption.quantity + item.quantity,
      );

      updatedOptions = [...currentOptions];
      updatedOptions[existingIndex] = updatedOption;
    } else {
      // 없는 옵션: 새로 추가
      updatedOptions = [...currentOptions, item];
    }

    final updatedItem = currentItem.copyWith(itemOptionList: updatedOptions);
    final updatedItemList = [...state.orderProductList];
    updatedItemList[orderItemIndex] = updatedItem;

    state = state.copyWith(orderProductList: updatedItemList);
  }
}