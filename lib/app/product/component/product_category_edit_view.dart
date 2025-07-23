import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/component/button/basic_button_v2.dart';
import '../../../common/component/form/basic_radio_button.dart';
import '../../../common/component/form/basic_text_form_field.dart';
import '../../../common/component/text/body_text.dart';
import '../../../common/const/colors.dart';
import '../provider/product_category_edit_provider.dart';

class ProductCategoryEditView extends StatefulWidget {
  const ProductCategoryEditView({super.key});

  @override
  State<ProductCategoryEditView> createState() => _ProductCategoryEditViewState();
}

class _ProductCategoryEditViewState extends State<ProductCategoryEditView> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  void _onTabTapped(int index) {
    _pageController.jumpToPage(index);
  }

  int _categoryId = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45, bottom: 50, left: 60, right: 14),
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildCategoriesEditView(),
          _buildCategoriesDeleteView(),
          _buildCategoriesSortOrderView(),
        ],
      ),
    );
  }

  Widget _buildCategoriesEditView() {
    return Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(productCategoryEditProvider);
          return state.when(
              error: (e, _) => const Text('오류'),
              loading: () => const CircularProgressIndicator(),
              data: (categories) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BodyText("카테고리 관리", textSize: BodyTextSize.LARGE_HALF, fontWeight: FontWeight.w500,),
                        Container(
                          width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  _onTabTapped(1);
                                },
                                child: BodyText("삭제",
                                  textSize: BodyTextSize.MEDIUM,
                                  color: TEXT_COLOR_03,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _onTabTapped(2);
                                },
                                child: BodyText("순서편집",
                                  textSize: BodyTextSize.MEDIUM,
                                  color: TEXT_COLOR_03,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40,),
                    Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: BasicTextFormField(
                            hintText: '새로운 카테고리 이름',
                          ),
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                            flex : 2,
                            child: InkWell(
                              onTap: () {

                              },
                              child: BasicButtonV2(
                                text: BodyText('저장',
                                  textSize: BodyTextSize.MEDIUM,
                                  color: PRIMARY_COLOR_01,
                                ),
                                radius: BorderRadius.circular(15),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                backgroundColor: COLOR_eaf3fe,
                              ),
                            )
                        )
                      ],
                    ),

                    const SizedBox(height: 16,),

                    /// 카테고리 수정 뷰
                    Expanded(
                      child: Container(
                          child: ListView(
                              children: _buildListWithDividers(
                                  categories.map((category) {
                                    final isEditing = category.isEditing;
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 26, bottom: 26, left: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex : 8,
                                              child: BodyText(category.categoryNm, textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w500,)
                                          ),
                                          const SizedBox(width: 16,),
                                          Expanded(
                                            flex : 2,
                                            child: isEditing
                                                ? InkWell(
                                                  onTap: () {
                                                    final notifier = ref.read(productCategoryEditProvider.notifier);
                                                    if (isEditing) {
                                                      // TODO: 실제 저장 처리 수행
                                                    } else {

                                                    }
                                                  },
                                                  child: BasicButtonV2(
                                                      text: BodyText('저장',
                                                        textSize: BodyTextSize.MEDIUM,
                                                        color: PRIMARY_COLOR_01,
                                                      ),
                                                      radius: BorderRadius.circular(15),
                                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                                      backgroundColor: COLOR_eaf3fe,
                                                    ),
                                                )
                                                : BasicButtonV2(
                                                    text: BodyText('수정',
                                                      textSize: BodyTextSize.MEDIUM,
                                                      color: TEXT_COLOR_01,
                                                    ),
                                                    radius: BorderRadius.circular(15),
                                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                                    backgroundColor: COLOR_f3f4f6,
                                                  )
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()
                              )
                          )
                      ),
                    )
                  ],
                );
              }
          );
        }
    );
  }

  /// 카테고리 수정 뷰
  Widget _buildCategoriesDeleteView() {
    return Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(productCategoryEditProvider);
          return state.when(
              error: (e, _) => const Text('오류'),
              loading: () => const CircularProgressIndicator(),
              data: (categories) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _onTabTapped(0);
                          },
                          child: const SizedBox(width: 35, height: 30, child: Icon(Icons.arrow_back_ios_new, color: TEXT_COLOR_04,)),
                        ),
                        BodyText("카테고리 삭제", textSize: BodyTextSize.LARGE_HALF, fontWeight: FontWeight.w500,),
                      ],
                    ),

                    const SizedBox(height: 40,),

                    Expanded(
                      child: Container(
                          child: ListView(
                              children: _buildListWithDividers(
                                  categories.map((category) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 26, bottom: 26, left: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex : 8,
                                              child: BodyText(category.categoryNm, textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w500,)
                                          ),
                                          const SizedBox(width: 16,),
                                          Expanded(
                                            flex : 2,
                                            child: BasicButtonV2(
                                              text: BodyText('삭제',
                                                textSize: BodyTextSize.MEDIUM,
                                                color: PRIMARY_COLOR_02,
                                              ),
                                              radius: BorderRadius.circular(15),
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              backgroundColor: COLOR_d23e41,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()
                              )
                          )
                      ),
                    )
                  ],
                );
              }
          );
        }
    );
  }

  /// 카테고리 순서 편집 뷰
  Widget _buildCategoriesSortOrderView() {
    return Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(productCategoryEditProvider);
          return state.when(
              error: (e, _) => const Text('오류'),
              loading: () => const CircularProgressIndicator(),
              data: (categories) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  _onTabTapped(0);
                                },
                                child: const SizedBox(width: 35, height: 30, child: Icon(Icons.arrow_back_ios_new, color: TEXT_COLOR_04,)),
                              ),
                              BodyText("카테고리 순서편집", textSize: BodyTextSize.LARGE_HALF, fontWeight: FontWeight.w500,),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Opacity(
                                opacity: _categoryId != 0 ? 1.0 : 0.6, // 흐려짐 처리
                                child: InkWell(
                                  onTap: _categoryId != 0
                                    ? () {
                                      ref.read(productCategoryEditProvider.notifier).moveUp(_categoryId);
                                    }
                                    : null,
                                  child: BasicButtonV2(
                                    text: BodyText("위로",
                                      textSize: BodyTextSize.REGULAR,
                                      color: PRIMARY_COLOR_01,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    padding: const EdgeInsets.only(left:2, right: 14, top: 4, bottom: 4),
                                    backgroundColor: COLOR_eaf3fe,
                                    icon: const Icon(Icons.arrow_drop_up_sharp, color: PRIMARY_COLOR_01, size: 42, applyTextScaling: true),
                                  )
                                ),
                              ),
                              const SizedBox(width: 8,),
                              Opacity(
                                opacity: _categoryId != 0 ? 1.0 : 0.6, // 흐려짐 처리
                                child: InkWell(
                                    onTap: _categoryId != 0
                                      ? () {
                                        ref.read(productCategoryEditProvider.notifier).moveDown(_categoryId);
                                      }
                                      : null,
                                    child: BasicButtonV2(
                                      text: BodyText("아래로",
                                        textSize: BodyTextSize.REGULAR,
                                        color: PRIMARY_COLOR_01,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      padding: const EdgeInsets.only(left:2, right: 14, top: 4, bottom: 4),
                                      backgroundColor: COLOR_eaf3fe,
                                      icon: const Icon(Icons.arrow_drop_down_sharp, color: PRIMARY_COLOR_01, size: 42, applyTextScaling: true),
                                    )
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 40,),

                    Expanded(
                      child: Container(
                          child: ListView(
                              children: _buildListWithDividers(
                                  categories.map((category) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          if(_categoryId == category.categoryId) {
                                            _categoryId = 0;
                                          } else {
                                            _categoryId = category.categoryId;
                                          }
                                        });
                                      },
                                      child: Container(
                                        color: _categoryId == category.categoryId ? PRIMARY_COLOR_02 : null,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 26, bottom: 26, left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex : 9,
                                                  child: BodyText(category.categoryNm, textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w500,)
                                              ),
                                              const SizedBox(width: 16,),
                                              Expanded(
                                                flex : 1,
                                                child: CustomRadioButton(
                                                  isSelected: _categoryId == category.categoryId,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()
                              )
                          )
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
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
                                onTap: () {
                                },
                                child: BasicButtonV2(
                                  text: BodyText("저장",
                                    textSize: BodyTextSize.HUGE,
                                    color: PRIMARY_COLOR_02,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                  backgroundColor: PRIMARY_COLOR_01,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }
          );
        }
    );
  }

  List<Widget> _buildListWithDividers(List<Widget> items) {
    List<Widget> children = [];

    Widget divider = const Divider(
        height: 1,      // 전체 높이 = 마진 제거
        thickness: 1,   // 실제 선 두께
        color: PRIMARY_COLOR_02
   );

    // 첫 번째 Divider
    children.add(Row(
      children: [
        Expanded(child: divider),
      ],
    ));

    for (var item in items) {
      // 아이템
      children.add(item);

      // 각 아이템 아래 Divider
      children.add(Row(
        children: [
          Expanded(child: divider),
        ],
      ));
    }

    return children;
  }
}
