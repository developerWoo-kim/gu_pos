import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_model.dart';
import 'package:gu_pos/app/product/model/product_category_model.dart';
import 'package:gu_pos/app/product/model/product_model.dart';

import 'package:retrofit/retrofit.dart';
import '../../../common/const/data.dart';
import '../../../common/dio/dio.dart';

part 'product_category_repository.g.dart';

final productCategoryRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  final repository = ProductCategoryRepository(dio, baseUrl: '$ip/api/v1/pos/categories');
  return repository;
});

@RestApi()
abstract class ProductCategoryRepository {
  factory ProductCategoryRepository(Dio dio, {String baseUrl})
  = _ProductCategoryRepository;

  @GET('/products/list')
  Future<List<ProductCategoryModel>> getCategoryListWithProducts();

  @POST('/{categoryNm}')
  Future<ProductCategoryModel> createCategory({@Path() required String categoryNm});

  @PUT('/category-name')
  Future<void> updateCategoryName(@Body() Map<String, dynamic> json);

  @PUT('/sort-order')
  Future<void> updateCategorySortOrder(@Body() Map<String, dynamic> json);

  @DELETE('/{categoryId}')
  Future<void> deleteCategoryId({@Path() required int categoryId});


}