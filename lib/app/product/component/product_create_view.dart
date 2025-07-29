import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/product/component/option_group_create_view.dart';
import 'package:gu_pos/app/product/component/product_category_edit_view.dart';
import 'package:gu_pos/app/product/provider/product_category_edit_provider.dart';
import 'package:gu_pos/app/product/provider/product_category_provider.dart';
import 'package:gu_pos/app/product/provider/product_edit_provider.dart';
import 'package:gu_pos/app/product/provider/product_option_group_provider.dart';
import 'package:gu_pos/common/component/button/basic_button_v2.dart';
import 'package:gu_pos/common/component/button/hover_button.dart';
import 'package:gu_pos/common/utils/dialog/dialog_util.dart';

import '../../../common/component/form/basic_text_form_field.dart';
import '../../../common/component/text/body_text.dart';
import '../../../common/const/colors.dart';
import '../../../common/utils/toast/toast_util.dart';

class ProductCreateView extends ConsumerStatefulWidget {
  const ProductCreateView({super.key});

  @override
  ConsumerState<ProductCreateView> createState() => _ProductCreateViewState();
}

class _ProductCreateViewState extends ConsumerState<ProductCreateView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productEditProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 45, bottom: 50, left: 60, right: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BodyText("상품 추가", textSize: BodyTextSize.LARGE_HALF, fontWeight: FontWeight.w500,),
            ],
          ),
          const SizedBox(height: 40,),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  BodyText("상품이름", textSize: BodyTextSize.REGULAR, color: COLOR_505967,),
                                  BodyText("・", textSize: BodyTextSize.LARGE, color: COLOR_d23e41,),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              Row(
                                children: [
                                  Expanded(
                                    child: BasicTextFormField(
                                      hintText: '상품이름',
                                      onChanged: (value) {
                                        ref.read(productEditProvider.notifier).changeValue(productNm: value);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 30,),
                          _buildCategoryEditView(),
                          const SizedBox(height: 30,),
                          _buildOptionGroupEditView(),
                          const SizedBox(height: 30,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  BodyText("기본가격", textSize: BodyTextSize.REGULAR, color: COLOR_505967,),
                                  BodyText("・", textSize: BodyTextSize.LARGE, color: COLOR_d23e41,),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              Row(
                                children: [
                                  Expanded(
                                    child: BasicTextFormField(
                                      hintText: '0',
                                      suffixWidget: Padding(
                                        padding: const EdgeInsets.only(right: 16),
                                        child: BodyText("원", textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_02,),
                                      ),
                                      onChanged: (value) {
                                        int? intValue = int.tryParse(value);
                                        if (intValue != null) {

                                        }
                                        ref.read(productEditProvider.notifier).changeValue(productPrice: intValue);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 30,),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BodyText("재고관리", textSize: BodyTextSize.MEDIUM_HALF, color: COLOR_505967, fontWeight: FontWeight.w500,),
                                  CupertinoSwitch(
                                    value: ref.read(productEditProvider).stockAt == 'N' ? false : true,
                                    activeColor: CupertinoColors.activeBlue,
                                    onChanged: (bool value) {
                                      final stockAt = value ? 'Y' : 'N';
                                      ref.read(productEditProvider.notifier).changeValue(stockAt: stockAt);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: BasicButtonV2(
                        text: BodyText("취소",
                          textSize: BodyTextSize.HUGE,
                          color: COLOR_505967,
                          fontWeight: FontWeight.w500,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        backgroundColor: COLOR_f3f4f6,
                      ),
                    ),
                    const SizedBox(width: 8,),
                    InkWell(
                      onTap: ref.read(productEditProvider.notifier).isReadyForSave()
                          ? () async {
                            await ref.read(productEditProvider.notifier).saveProduct();
                            Navigator.pop(context);
                            ToastUtil.showToast(context);
                          }
                          : null,
                      child: BasicButtonV2(
                        text: BodyText("등록",
                          textSize: BodyTextSize.HUGE,
                          color: PRIMARY_COLOR_04,
                          fontWeight: FontWeight.w500,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        backgroundColor: ref.read(productEditProvider.notifier).isReadyForSave() ? PRIMARY_COLOR_01 : COLOR_d0e1fd,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      )
    );
  }

  Widget _buildCategoryEditView() {
    return Consumer(
        builder: (context, ref, child) {
          final categoryState = ref.watch(productCategoryEditProvider);
          return categoryState.when(
              error: (e, _) => const Text('오류'),
              loading: () => const CircularProgressIndicator(),
              data: (categories) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BodyText("카테고리 선택", textSize: BodyTextSize.REGULAR, color: COLOR_505967,),
                        BodyText("・", textSize: BodyTextSize.LARGE, color: COLOR_d23e41,),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Wrap(
                        spacing: 8, // 버튼 간 가로 간격
                        runSpacing: 8, // 줄바꿈 시 세로 간격
                        children: [
                          ...List.generate(categories.length, (index) {
                            final category = categories[index];
                            return HoverButton(
                              text: BodyText(
                                  category.categoryNm,
                                  textSize: BodyTextSize.SMALL,
                                  color: category.isSelected ? PRIMARY_COLOR_01 : null,
                              ),
                              onTap: () async {
                                ref.read(productCategoryEditProvider.notifier).select(category.categoryId);
                                ref.read(productEditProvider.notifier).changeValue(categoryId: category.categoryId);
                              },
                              radius: BorderRadius.circular(30),
                              backgroundColor: category.isSelected ? COLOR_eaf3fe : COLOR_f3f4f6,
                              hoverColor: category.isSelected ? COLOR_d0e1fd : COLOR_e6e8ea,
                            );
                          }),
                          HoverButton(
                            text: BodyText('새 카테고리 등록',
                              textSize: BodyTextSize.REGULAR,
                            ),
                            icon: Icon(Icons.add, size: 16,),
                            onTap: () {
                              DialogUtil.basicLayout(context,
                                  content: ProductCategoryEditView()
                              );
                            },
                            radius: BorderRadius.circular(30),
                            backgroundColor: COLOR_eaf3fe,
                            hoverColor: PRIMARY_COLOR_01,
                          ),
                        ]
                    )
                  ],
                );
              }
          );
        }
    );
  }

  Widget _buildOptionGroupEditView() {
    return Consumer(
        builder: (context, ref, child) {
          final optionGroupState = ref.watch(productOptionGroupProvider);
          return optionGroupState.when(
              error: (e, _) => const Text('오류'),
              loading: () => const CircularProgressIndicator(),
              data: (optionGroups) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        BodyText("상품에 넣을 옵션을 선택하세요", textSize: BodyTextSize.REGULAR, color: COLOR_505967,),
                      ],
                    ),
                    const SizedBox(height: 12,),
                    Wrap(
                        spacing: 8, // 버튼 간 가로 간격
                        runSpacing: 8, // 줄바꿈 시 세로 간격
                        children: [
                          ...List.generate(optionGroups.length, (index) {
                            final optionGroup = optionGroups[index];
                            return HoverButton(
                              text: BodyText(
                                optionGroups[index].productOptionGroupNm,
                                textSize: BodyTextSize.SMALL,
                                color: optionGroup.isSelected ? PRIMARY_COLOR_01 : null,
                              ),
                              onTap: () {
                                ref.read(productOptionGroupProvider.notifier).select(optionGroup.productOptionGroupId);
                              },
                              radius: BorderRadius.circular(30),
                              backgroundColor: optionGroup.isSelected ? COLOR_eaf3fe : COLOR_f3f4f6,
                              hoverColor: optionGroup.isSelected ? COLOR_d0e1fd : COLOR_e6e8ea,
                            );
                          }),
                          HoverButton(
                            text: BodyText('새 옵션 등록',
                              textSize: BodyTextSize.REGULAR,
                            ),
                            icon: Icon(Icons.add, size: 16,),
                            onTap: () {
                              DialogUtil.basicLayout(context,
                                content: OptionGroupCreateView()
                              );
                            },
                            radius: BorderRadius.circular(30),
                            backgroundColor: COLOR_eaf3fe,
                            hoverColor: PRIMARY_COLOR_01,
                          ),
                        ]
                    )
                  ],
                );
              }
          );
        }
    );
  }
}
