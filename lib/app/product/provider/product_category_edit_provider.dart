import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/product/provider/product_category_provider.dart';
import 'package:gu_pos/app/product/repository/request/product_category_model_request.dart';

import '../model/product_category_model.dart';
import '../repository/product_category_repository.dart';

final productCategoryEditProvider = AsyncNotifierProvider.autoDispose<ProductCategoryEditAsyncNotifier, List<ProductCategoryModel>>(() =>
    ProductCategoryEditAsyncNotifier()
);

final categoryEditBufferProvider = StateProvider.autoDispose<List<ProductCategoryModel>>((ref) => []);

class ProductCategoryEditAsyncNotifier extends AutoDisposeAsyncNotifier<List<ProductCategoryModel>> {
  late final ProductCategoryRepository repository;

  @override
  Future<List<ProductCategoryModel>> build() async {
    repository = ref.read(productCategoryRepositoryProvider);
    return await _fetchCategoryList();
  }

  Future<List<ProductCategoryModel>> _fetchCategoryList() async {
    try {
      final categoryList = ref.read(productCategoryProvider).value ?? [];
      final editList = [...categoryList];
      return editList;
    } catch (e, st) {
      // 상태를 error로 설정
      state = AsyncError(e, st);
      return [];
    }
  }

  Future<void> createCategory(String categoryNm) async{
    final savedCategory = await repository.createCategory(categoryNm: categoryNm);

    final currentState = state.value ?? [];
    currentState.add(savedCategory);
    state = AsyncData(currentState);

    ref.read(productCategoryProvider.notifier).addCategory(savedCategory);
  }

  Future<void> removeCategory(int categoryId) async{
    final currentState = state.value;
    if (currentState == null) return;
    final index = currentState.indexWhere((e) => e.categoryId == categoryId);

    await repository.deleteCategoryId(categoryId: categoryId);

    final newList = [...currentState]..removeAt(index);
    state = AsyncData(newList);

    ref.read(productCategoryProvider.notifier).removeCategory(categoryId);
  }

  Future<void> editing(int categoryId) async {
    final currentState = state.value;
    if (currentState == null) return;
    final index = currentState.indexWhere((e) => e.categoryId == categoryId);

    final newList = [...currentState];
    newList[index] = newList[index].copyWith(isEditing: true);

    state = AsyncData(newList);
  }

  Future<void> updateCategoryName(int categoryId,{
    required String categoryNm
  }) async {
    final currentState = state.value;
    if (currentState == null) return;
    final index = currentState.indexWhere((e) => e.categoryId == categoryId);

    final newList = [...currentState];

    final newCategory = newList[index].copyWith(categoryNm: categoryNm, isEditing: false);
    newList[index] = newCategory;

    final json = newCategory.toUpdateRequestJson();
    await repository.updateCategoryName(json);

    ref.read(productCategoryProvider.notifier).changeCategoryName(categoryId, categoryNm: categoryNm);

    state = AsyncData(newList);
  }

  Future<void> updateCategorySortOrder() async {
    final currentState = state.value;
    if (currentState == null) return;

    Map<String, dynamic> json = {
      'categorySortOrderList': List.generate(currentState.length, (index) {
        final item = currentState[index];
        return item.toUpdateSortOrderJson(index+1);
      })
    };

    await repository.updateCategorySortOrder(json);

    ref.read(productCategoryProvider.notifier).refreshSortOrder(currentState);
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

  Future<void> refreshSortOrder() async {
    final currentState = state.value;
    if (currentState == null) return;

    final categoryState = ref.read(productCategoryProvider).value;
    if (categoryState == null) return;

    final newList = categoryState;

    state = AsyncData(newList);

    // repository에도 변경 순서 반영
    // await repository.updateCategoryOrder(newList);
  }

}