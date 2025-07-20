import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_product_model.dart';
import 'package:gu_pos/app/order/model/order_product_option_model.dart';
import 'package:gu_pos/app/order/provider/order_status_provider.dart';
import '../model/order_model.dart';

final orderProvider = StateNotifierProvider<OrderStateNotifier, OrderModel>((ref) => OrderStateNotifier(ref));

class OrderStateNotifier extends StateNotifier<OrderModel> {
  final Ref ref;

  OrderStateNotifier(this.ref)
      : super(OrderModel(orderType: '', orderProductList: []));

  void order() {
    ref.read(orderStatusProvider.notifier).createOrder(state);

    clearItems();
  }

  void addItem(OrderProductModel orderProduct) {
    final existingIndex = state.orderProductList.indexWhere((e) => e.productId == orderProduct.productId);

    final updatedList = [...state.orderProductList];

    if (existingIndex != -1) {
      // 기존 아이템 업데이트 + 삭제 + 맨 앞에 추가
      final existingItem = updatedList.removeAt(existingIndex);
      final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + 1);
      updatedList.insert(0, updatedItem);
    } else {
      // 새 아이템 맨 앞에 추가
      updatedList.insert(0, orderProduct);
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

  void updateOrderList(List<OrderProductModel> newList) {
    state = state.copyWith(orderProductList: newList);
  }

  void addItemOption(int orderItemIndex, {
    required OrderProductOption option,
  }) {
    final currentItem = state.orderProductList[orderItemIndex];
    final currentOptions = currentItem.optionList;

    final existingIndex = currentOptions.indexWhere((e) => e.optionId == option.optionId);

    List<OrderProductOption> updatedOptions;

    if (existingIndex != -1) {
      // 이미 있는 옵션: 수량 증가
      final existingOption = currentOptions[existingIndex];
      final updatedOption = existingOption.copyWith(
        quantity: existingOption.quantity + option.quantity,
      );

      updatedOptions = [...currentOptions];
      updatedOptions[existingIndex] = updatedOption;
    } else {
      // 없는 옵션: 새로 추가
      updatedOptions = [...currentOptions, option];
    }

    final updatedItem = currentItem.copyWith(optionList: updatedOptions);
    final updatedItemList = [...state.orderProductList];
    updatedItemList[orderItemIndex] = updatedItem;

    state = state.copyWith(orderProductList: updatedItemList);
  }
}