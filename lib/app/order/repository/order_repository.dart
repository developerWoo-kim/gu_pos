import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_model.dart';

import 'package:retrofit/retrofit.dart';
import '../../../common/const/data.dart';
import '../../../common/dio/dio.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final repository = OrderRepository(dio, baseUrl: '$ip/api/v1/pos/order');
  return repository;
});

@RestApi()
abstract class OrderRepository {
  factory OrderRepository(Dio dio, {String baseUrl})
  = _OrderRepository;

  @GET('')
  Future<List<OrderModel>> createOrder(@Body() Map<String, dynamic> json);

  @GET('/list')
  Future<List<OrderModel>> getOrderList();
}