import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_category_model.dart';
import '../repository/product_category_repository.dart';

final productCategoryEditProvider = AsyncNotifierProvider<ProductCategoryEditAsyncNotifier, List<ProductCategoryModel>>(() {
  return ProductCategoryEditAsyncNotifier();
});

class ProductCategoryEditAsyncNotifier extends AsyncNotifier<List<ProductCategoryModel>> {
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

  Future<void> moveUp(int categoryId) async {
    final currentState = state.value;
    if (currentState == null) return;

    final index = currentState.indexWhere((e) => e.categoryId == categoryId);
    if (index <= 0) return; // 첫 번째면 더 위로 못 감

    final newList = [...currentState];
    final temp = newList[index - 1];
    newList[index - 1] = newList[index];
    newList[index] = temp;

    state = AsyncData(newList);

    // repository에도 변경 순서 반영
    // await repository.updateCategoryOrder(newList);
  }

  Future<void> moveDown(int categoryId) async {
    final currentState = state.value;
    if (currentState == null) return;

    final index = currentState.indexWhere((e) => e.categoryId == categoryId);
    if (index == -1 || index >= currentState.length - 1) return;

    final newList = [...currentState];
    final temp = newList[index + 1];
    newList[index + 1] = newList[index];
    newList[index] = temp;

    state = AsyncData(newList);

    // repository에도 변경 순서 반영
    // await repository.updateCategoryOrder(newList);
  }

}