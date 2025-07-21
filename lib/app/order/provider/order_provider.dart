import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_product_model.dart';
import 'package:gu_pos/app/order/model/order_product_option_model.dart';
import 'package:gu_pos/app/order/provider/order_status_provider.dart';
import '../../product/model/product_option_group_model.dart';
import '../../product/provider/product_provider.dart';
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

  void selectProduct(int productId) {
    final updatedList = state.orderProductList.map((e) {
      if (e.productId == productId) {
        return e.copyWith(isSelected: true);
      } else if (e.isSelected) {
        return e.copyWith(isSelected: false);
      }
      return e;
    }).toList();

    state = state.copyWith(orderProductList: updatedList);
  }

  void addItem(OrderProductModel orderProduct) {
    // 1. 기존 리스트에서 isSelected가 true인 항목 모두 false로 변경
    final deselectedList = state.orderProductList.map((e) {
      return e.isSelected ? e.copyWith(isSelected: false) : e;
    }).toList();

    // 2. 기존 리스트에서 productId 일치하는 항목 인덱스 찾기
    final existingIndex = deselectedList.indexWhere((e) => e.productId == orderProduct.productId);
    final updatedList = [...deselectedList];

    if (existingIndex != -1) {
      // 기존 아이템 업데이트 + 삭제 + 맨 앞에 추가
      final existingItem = updatedList.removeAt(existingIndex);
      final updatedItem = existingItem.copyWith(isSelected: true, quantity: existingItem.quantity + 1);
      updatedList.insert(0, updatedItem);
    } else {
      // 새 아이템 맨 앞에 추가
      updatedList.insert(0, orderProduct.copyWith(isSelected: true));
    }

    // 3. 상태 업데이트
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

  void addItemOption(int productId, {
    required OrderProductOption option,
  }) {
    final productIndex = state.orderProductList.indexWhere((e) => e.productId == productId);
    if (productIndex == -1) return;

    final currentItem = state.orderProductList[productIndex];
    final currentOptions = currentItem.optionList;

    // 1. 선택한 옵션이 속한 그룹 정보 찾기
    final product = ref.read(productProvider).value?.where((p) => p.productId == productId,).firstOrNull;

    if (product == null) return;

    ProductOptionGroupModel? targetGroup;
    for (final group in product.optionGroupList ?? []) {
      if (group.optionList.any((e) => e.productOptionId == option.optionId)) {
        targetGroup = group;
        break;
      }
    }

    if (targetGroup == null) return;

    final maxCount = targetGroup.maxSelectionCount;
    final groupOptionIds = targetGroup.optionList.map((e) => e.productOptionId).toSet();

    // 2. 현재 이 그룹에서 선택된 옵션들 필터링
    final currentGroupOptions = currentOptions.where((e) => groupOptionIds.contains(e.optionId)).toList();

    List<OrderProductOption> updatedOptions;

    if (maxCount == 1) {
      // 3.1 단일 선택 그룹: 기존 그룹 옵션 제거하고 새로 추가
      updatedOptions = [
        ...currentOptions.where((e) => !groupOptionIds.contains(e.optionId)),
        option
      ];
    } else {
      // 3.2 다중 선택 그룹
      if (currentGroupOptions.length >= maxCount &&
          currentOptions.indexWhere((e) => e.optionId == option.optionId) == -1) {
        // 최대 선택 수 초과 시 추가 차단
        return;
      }

      final existingIndex = currentOptions.indexWhere((e) => e.optionId == option.optionId);

      if (existingIndex != -1) {
        // 수량 증가
        final existingOption = currentOptions[existingIndex];
        final updatedOption = existingOption.copyWith(quantity: existingOption.quantity + option.quantity);
        updatedOptions = [...currentOptions];
        updatedOptions[existingIndex] = updatedOption;
      } else {
        // 새로 추가
        updatedOptions = [...currentOptions, option];
      }
    }

    final updatedItem = currentItem.copyWith(optionList: updatedOptions);
    final updatedItemList = [...state.orderProductList];
    updatedItemList[productIndex] = updatedItem;

    state = state.copyWith(orderProductList: updatedItemList);
  }
}