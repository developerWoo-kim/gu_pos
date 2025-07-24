import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/product/model/product_category_model.dart';
import 'package:gu_pos/app/product/model/product_model.dart';
import 'package:gu_pos/app/product/repository/product_category_repository.dart';

final productCategoryProvider = AsyncNotifierProvider<ProductCategoryAsyncNotifier, List<ProductCategoryModel>>(() {
  return ProductCategoryAsyncNotifier();
});

class ProductCategoryAsyncNotifier extends AsyncNotifier<List<ProductCategoryModel>> {
  late final ProductCategoryRepository repository;

  @override
  Future<List<ProductCategoryModel>> build() async {
    repository = ref.read(productCategoryRepositoryProvider);
    return await _fetchCategoryList();
  }

  Future<List<ProductCategoryModel>> _fetchCategoryList() async {
    try {
      final categories = await repository.getCategoryListWithProducts();
      return categories;
    } catch (e, st) {
      // 상태를 error로 설정
      state = AsyncError(e, st);
      return [];
    }
  }

  /// 필요 시 새로고침 기능 제공
  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await _fetchCategoryList());
  }

  /// 카테고리 추가
  Future<void> addCategory(ProductCategoryModel category) async {
    final categoryList = state.value ?? [];
    categoryList.add(category);
    state = AsyncData(categoryList);
  }

  /// 카테고리 삭제
  Future<void> removeCategory(int categoryId) async {
    final currentState = state.value;
    if(currentState == null) return;
    final index = currentState.indexWhere((e) => e.categoryId == categoryId);
    final newList = [...currentState]..removeAt(index);
    state = AsyncData(newList);
  }

  /// 카테고리명 변경
  Future<void> changeCategoryName(int categoryId,{
    required String categoryNm
  }) async {
    final categoryList = state.value ?? [];
    final index = categoryList.indexWhere((e) => e.categoryId == categoryId);

    final newCategory = categoryList[index].copyWith(categoryNm: categoryNm);

    categoryList[index] = newCategory;

    state = AsyncData(categoryList);
  }

  /// 카테고리 정렬 순서 리프레시
  Future<void> refreshSortOrder(List<ProductCategoryModel> list) async {
    final newList = list;
    state = AsyncData(newList);
  }

  ProductModel? findSelectedProduct(int selectedProductId) {
    final categoryList = state.value ?? [];

    for (final category in categoryList) {
      for (final product in category.productList) {
        if (product.productId == selectedProductId) {
          return product;
        }
      }
    }

    return null;
  }
}