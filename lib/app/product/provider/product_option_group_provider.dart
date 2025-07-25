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

}