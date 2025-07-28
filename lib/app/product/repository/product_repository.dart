import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_model.dart';
import 'package:gu_pos/app/product/model/product_model.dart';

import 'package:retrofit/retrofit.dart';
import '../../../common/const/data.dart';
import '../../../common/dio/dio.dart';
import '../model/product_option_group_model.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final repository = ProductRepository(dio, baseUrl: '$ip/api/v1/pos/product');
  return repository;
});

@RestApi()
abstract class ProductRepository {
  factory ProductRepository(Dio dio, {String baseUrl})
  = _ProductRepository;

  @GET('/list')
  Future<List<ProductModel>> getProductList();

  @GET('/option/group/list')
  Future<List<ProductOptionGroupModel>> getProductOptionGroupList();
  
  @POST('/option/group')
  Future<ProductOptionGroupModel> createProductOptionGroup(@Body() Map<String, dynamic> json);

}