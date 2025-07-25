import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/product/component/product_category_edit_view.dart';
import 'package:gu_pos/app/product/provider/product_category_edit_provider.dart';
import 'package:gu_pos/app/product/provider/product_category_provider.dart';
import 'package:gu_pos/app/product/provider/product_option_group_provider.dart';
import 'package:gu_pos/common/component/button/basic_button_v2.dart';
import 'package:gu_pos/common/component/button/hover_button.dart';
import 'package:gu_pos/common/utils/dialog/dialog_util.dart';

import '../../../common/component/form/basic_text_form_field.dart';
import '../../../common/component/text/body_text.dart';
import '../../../common/const/colors.dart';

class ProductEditView extends StatefulWidget {
  const ProductEditView({super.key});

  @override
  State<ProductEditView> createState() => _ProductEditViewState();
}

class _ProductEditViewState extends State<ProductEditView> {
  @override
  Widget build(BuildContext context) {
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
                        child: BodyText("원", textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_03,),
                      ),
                    ),
                  ),
                ],
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
                        BodyText("카테고리", textSize: BodyTextSize.REGULAR, color: COLOR_505967,),
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
                                  textSize: BodyTextSize.REGULAR,
                                  color: category.isSelected ? PRIMARY_COLOR_01 : null,
                              ),
                              onTap: () {
                                ref.read(productCategoryEditProvider.notifier).select(category.categoryId);
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
                            icon: Icon(Icons.add, size: 14,),
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
                            return HoverButton(
                              text: BodyText(optionGroups[index].productOptionGroupNm, textSize: BodyTextSize.SMALL),
                              onTap: () {},
                              radius: BorderRadius.circular(30),
                              backgroundColor: COLOR_f3f4f6,
                              hoverColor: COLOR_e6e8ea,
                            );
                          }),
                          HoverButton(
                            text: BodyText('새 옵션 등록',
                              textSize: BodyTextSize.SMALL,
                            ),
                            icon: Icon(Icons.add, size: 14,),
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
}
