import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/product/model/product_option_group_model.dart';
import 'package:gu_pos/app/product/provider/product_category_provider.dart';
import 'package:gu_pos/app/product/provider/product_option_group_provider.dart';
import 'package:gu_pos/app/product/repository/request/product_edit_provider_model_request.dart';

import '../repository/product_repository.dart';

final productEditProvider = AutoDisposeStateNotifierProvider<ProductEditNotifier, ProductEditProviderModel>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return ProductEditNotifier(repository, ref);
});

class ProductEditNotifier extends StateNotifier<ProductEditProviderModel> {
  final ProductRepository repository;
  final Ref ref;

  ProductEditNotifier(this.repository, this.ref)
    : super(ProductEditProviderModel(optionGroupIds: []));

  void changeValue({
    String? productNm,
    int? categoryId,
    int? productPrice,
    String? stockAt,
    int? stockCount,
  }) {
    state = state.copyWith(
      productNm: productNm,
      categoryId: categoryId,
      productPrice: productPrice,
      stockAt: stockAt,
      stockCount: stockCount,
    );
  }

  Future<void> saveProduct() async {
    final optionGroupList = ref.read(productOptionGroupProvider).value ?? [];

    final selectedOptionGroupList = optionGroupList.where((e) => e.isSelected).toList();

    final json = state.toCreateRequestJson(selectedOptionGroupList);

    final model = await repository.createProduct(json);

    ref.read(productCategoryProvider.notifier).addProduct(state.categoryId!, model: model);
  }

  bool isReadyForSave() {
    if(state.productNm.isEmpty) return false;

    if(state.categoryId == null) return false;

    if(state.productPrice == 0) return false;

    return true;
  }
}

class ProductEditProviderModel {
  final String productNm;
  final int? categoryId;
  final List<int> optionGroupIds;
  final int productPrice;
  final String stockAt;
  final int stockCount;

  ProductEditProviderModel({
    this.productNm = '',
    this.categoryId,
    this.optionGroupIds = const [],
    this.productPrice = 0,
    this.stockAt = 'N',
    this.stockCount = 0,
  });

  ProductEditProviderModel copyWith({
    String? productNm,
    int? categoryId,
    List<int>? optionGroupIds,
    int? productPrice,
    String? stockAt,
    int? stockCount,
  }) {
    return ProductEditProviderModel(
      productNm: productNm ?? this.productNm,
      categoryId: categoryId ?? this.categoryId,
      optionGroupIds: optionGroupIds ?? this.optionGroupIds,
      productPrice: productPrice ?? this.productPrice,
      stockAt: stockAt ?? this.stockAt,
      stockCount: stockCount ?? this.stockCount,
    );
  }
}