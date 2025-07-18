import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_model.dart';
import 'package:gu_pos/app/order/repository/order_repository.dart';

final orderStatusProvider = AsyncNotifierProvider<OrderAsyncNotifier, List<OrderModel>>(() {
  return OrderAsyncNotifier();
});

class OrderAsyncNotifier extends AsyncNotifier<List<OrderModel>> {
  late final OrderRepository repository;

  @override
  FutureOr<List<OrderModel>> build() async {
    repository = ref.read(orderRepositoryProvider);
    return await _fetchList();
  }

  Future<List<OrderModel>> _fetchList() async {
    try {
      final orders = await repository.getOrderList();
      return orders;
    } catch (e, st) {
      // 상태를 error로 설정
      state = AsyncError(e, st);
      return [];
    }
  }

  // 필요 시 새로고침 기능 제공
  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await _fetchList());
  }


  void addOrder(OrderModel model) {
    // OrderModel order = model.copyWith(orderIndex: state.length + 1, orderStatus: OrderStatus.PROGRESS, approvalStatus: ApprovalStatus.COMPLETE);
    // final updated = List<OrderModel>.from(state)..add(order);
    // state = updated;
  }

  void completeOrder(int orderIndex) {
    // final index = state.indexWhere((order) => order.orderIndex == orderIndex);
    // final updatedList = [...state];
    // final order = updatedList.removeAt(index);
    // final updateOrder = order.copyWith(orderStatus: OrderStatus.COMPLETE);
    //
    // updatedList.insert(0, updateOrder);
    //
    // state = updatedList;
  }

  void completeCancelOrder(int orderIndex) {
    // final index = state.indexWhere((order) => order.orderIndex == orderIndex);
    // final updatedList = [...state];
    // final order = updatedList.removeAt(index);
    // final updateOrder = order.copyWith(orderStatus: OrderStatus.PROGRESS);
    //
    // updatedList.insert(0, updateOrder);
    //
    // state = updatedList;
  }
}