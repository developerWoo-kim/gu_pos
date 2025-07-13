import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_model.dart';

final orderStatusProvider = StateNotifierProvider<OrderStatusStateNotifier, List<OrderModel>>((ref) => OrderStatusStateNotifier());

class OrderStatusStateNotifier extends StateNotifier<List<OrderModel>> {
  OrderStatusStateNotifier()
      : super([]);

  void addOrder(OrderModel model) {
    OrderModel order = model.copyWith(orderIndex: state.length + 1, orderStatus: OrderStatus.PROGRESS, approvalStatus: ApprovalStatus.COMPLETE);
    final updated = List<OrderModel>.from(state)..add(order);
    state = updated;
  }

  void completeOrder(int orderIndex) {
    final index = state.indexWhere((order) => order.orderIndex == orderIndex);
    final updatedList = [...state];
    final order = updatedList.removeAt(index);
    final updateOrder = order.copyWith(orderStatus: OrderStatus.COMPLETE);

    updatedList.insert(0, updateOrder);

    state = updatedList;
  }

  void completeCancelOrder(int orderIndex) {
    final index = state.indexWhere((order) => order.orderIndex == orderIndex);
    final updatedList = [...state];
    final order = updatedList.removeAt(index);
    final updateOrder = order.copyWith(orderStatus: OrderStatus.PROGRESS);

    updatedList.insert(0, updateOrder);

    state = updatedList;
  }
}