import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/product/model/product_option_model.dart';
import 'package:gu_pos/app/product/repository/product_repository.dart';
import 'package:gu_pos/app/product/repository/request/product_option_group_edit_provider_model_request.dart';
import 'package:uuid/v1.dart';

final productOptionGroupEditProvider = AutoDisposeStateNotifierProvider<ProductOptionGroupEditNotifier, ProductOptionGroupEditProviderModel>((ref) {
  final repository = ref.read(productRepositoryProvider);
  return ProductOptionGroupEditNotifier(repository, ref);
});


class ProductOptionGroupEditNotifier extends StateNotifier<ProductOptionGroupEditProviderModel> {
  final ProductRepository repository;
  final Ref ref;

  ProductOptionGroupEditNotifier(this.repository, this.ref)
    : super(ProductOptionGroupEditProviderModel(
        optionGroupNm: '',
        optionList: [ProductOptionModel(productOptionId: DateTime.now().millisecondsSinceEpoch, productOptionNm: '', optionPrice: 0, sortOrder: 0)]
      )
    );

  void saveOptionGroup() async {
    final json = state.toCreateRequestJson();

    await repository.createProductOptionGroup(json);
  }

  void addOption() {
    final newList = [...state.optionList];
    final option = ProductOptionModel(productOptionId: DateTime.now().millisecondsSinceEpoch, productOptionNm: '', optionPrice: 0, sortOrder: 0);
    newList.add(option);
    state = state.copyWith(optionList: newList);
  }

  void removeOption(int index) {
    if(state.optionList.length == 1) return;

    final newList = [...state.optionList];
    newList.removeAt(index);

    state = state.copyWith(optionList: newList);
  }

  void changeValue({
    String? optionGroupNm,
    String? requiredAt,
    int? maxSelectionCount,
  }) {
    state = state.copyWith(optionGroupNm: optionGroupNm, requiredAt: requiredAt, maxSelectionCount: maxSelectionCount);
  }

  void changeOptionValue(int index, {
    String? productOptionNm,
    int? optionPrice,
  }) {
    final newList = [...state.optionList];
    final option = state.optionList[index].copyWith(productOptionNm: productOptionNm, optionPrice: optionPrice);
    newList[index] = option;

    state = state.copyWith(optionList: newList);
  }

  bool isReadyForSave() {
    if(state.optionGroupNm.isEmpty) return false;

    if(state.optionList.where((o) => o.productOptionNm.isEmpty).length > 0) return false;

    return true;
  }

}

class ProductOptionGroupEditProviderModel {
  final String optionGroupNm;
  final String requiredAt;
  final int maxSelectionCount;

  final List<ProductOptionModel> optionList;

  ProductOptionGroupEditProviderModel({
    required this.optionGroupNm,
    this.requiredAt = "N",
    this.maxSelectionCount = 1,
    this.optionList = const []
  });

  ProductOptionGroupEditProviderModel copyWith({
    String? optionGroupNm,
    String? requiredAt,
    int? maxSelectionCount,
    List<ProductOptionModel>? optionList,
  }) {
    return ProductOptionGroupEditProviderModel(
      optionGroupNm: optionGroupNm ?? this.optionGroupNm,
      requiredAt: requiredAt ?? this.requiredAt,
      maxSelectionCount: maxSelectionCount ?? this.maxSelectionCount,
      optionList: optionList ?? this.optionList,
    );
  }

}