import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/product/model/product_model.dart';
import 'package:gu_pos/app/product/repository/product_repository.dart';

final productProvider = AsyncNotifierProvider<ProductAsyncNotifier, List<ProductModel>>(() {
  return ProductAsyncNotifier();
});

class ProductAsyncNotifier extends AsyncNotifier<List<ProductModel>> {
  late final ProductRepository repository;

  @override
  Future<List<ProductModel>> build() async {
    repository = ref.read(productRepositoryProvider);
    return await _fetchProductList();
  }

  Future<List<ProductModel>> _fetchProductList() async {
    try {
      final products = await repository.getProductList();
      return products;
    } catch (e, st) {
      // 상태를 error로 설정
      state = AsyncError(e, st);
      return [];
    }
  }

  // 필요 시 새로고침 기능 제공
  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await _fetchProductList());
  }
}