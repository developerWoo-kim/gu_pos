import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/product/model/product_option_group_model.dart';
import 'package:gu_pos/app/product/repository/product_repository.dart';


final productOptionGroupProvider = AsyncNotifierProvider.autoDispose<ProductOptionGroupAsyncNotifier, List<ProductOptionGroupModel>>(() =>
    ProductOptionGroupAsyncNotifier()
);

class ProductOptionGroupAsyncNotifier extends AutoDisposeAsyncNotifier<List<ProductOptionGroupModel>> {
  late final ProductRepository repository;

  @override
  FutureOr<List<ProductOptionGroupModel>> build() async {
    repository = ref.read(productRepositoryProvider);
    return await _fetchList();
  }

  Future<List<ProductOptionGroupModel>> _fetchList() async {
    try {
      final optionGroupList = await repository.getProductOptionGroupList();
      return optionGroupList;
    } catch (e, st) {
      // 상태를 error로 설정
      state = AsyncError(e, st);
      return [];
    }
  }

  /// 필요 시 새로고침 기능 제공
  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await _fetchList());
  }

  Future<void> addOptionGroup(ProductOptionGroupModel model) async{
    final currentState = state.value ?? [];
    currentState.add(model);
    final newState = currentState;
    state = AsyncData(newState);
  }

  Future<void> select(int optionGroupId) async {
    final currentState = state.value ?? [];

    final index = currentState.indexWhere((e) => e.productOptionGroupId == optionGroupId);

    late ProductOptionGroupModel newOptionGroup;

    if(currentState[index].isSelected) {
      newOptionGroup = currentState[index].copyWith(isSelected: false);
    } else {
      newOptionGroup = currentState[index].copyWith(isSelected: true);
    }

    currentState[index] = newOptionGroup;

    final newState = currentState;

    state = AsyncData(newState);
  }

}