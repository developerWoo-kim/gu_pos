import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/order_provider_model.dart';

final orderProvider = StateNotifierProvider<OrderStateNotifier, OrderProviderModel>((ref) => OrderStateNotifier());

class OrderStateNotifier extends StateNotifier<OrderProviderModel> {
  OrderStateNotifier() : super(
      OrderProviderModel(depositorNm: '', accountNo: '', bankCode: '', businessNo: '', businessNm: '', ownerNm: '')
  );

}