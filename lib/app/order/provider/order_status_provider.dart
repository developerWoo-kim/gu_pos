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
}