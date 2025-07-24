import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_product_option_model.dart';
import 'package:gu_pos/app/product/component/product_grid_view.dart';
import 'package:gu_pos/app/product/provider/product_category_provider.dart';
import 'package:gu_pos/common/component/text/body_text.dart';

import '../../../common/component/button/basic_button.dart';
import '../../../common/component/button/number_stepper.dart';
import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../../../common/utils/dialog/dialog_util.dart';
import '../../../common/utils/format_util.dart';
import '../../product/component/product_category_edit_view.dart';
import '../../product/provider/product_provider.dart';
import '../provider/order_provider.dart';

class OrderScreen extends ConsumerStatefulWidget {
  const OrderScreen({super.key});

  @override
  ConsumerState<OrderScreen> createState() => _OrderTestScreenState();
}

enum SegmentType { news, map, paper }
enum TestType { segmentation, max, news }

class _OrderTestScreenState extends ConsumerState<OrderScreen> with TickerProviderStateMixin {
  // late TabController _tabController;
  late PageController _pageController;

  TestType initialTestType = TestType.max;
  int initial = 1;
  bool isPayment = false;
  int initialValue = 0;

  int selectedTapIndex = 0;

  @override
  void initState() {
    // _tabController = TabController(
    //   length: 2,
    //   vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    // );

    _pageController = PageController(
      initialPage: selectedTapIndex,
    );

    super.initState();
  }

  @override
  void dispose() {
    // _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      selectedTapIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(productProvider);
    final state = ref.watch(productCategoryProvider);
    return DefaultLayout(
      body:  Expanded(
        child: Row(
          children: [
            state.when(
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => const Text('에러'),
                data: (categories) {
                  return Expanded(
                    child: Container(
                      color: PRIMARY_COLOR_02,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: PRIMARY_COLOR_04, width: 0.5
                                      ),
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TabBar(
                                        isScrollable: true,
                                        tabAlignment: TabAlignment.start,
                                        tabs: List.generate(categories.length, (index) {
                                          return Container(
                                            height: 45,
                                            alignment: Alignment.center,
                                            child: Text(
                                              categories[index].categoryNm,
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            )
                                          );
                                        }
                                      ),
                                        // tabs: [
                                        //   Container(height: 45, alignment: Alignment.center,child: const Text('즐겨찾는 메뉴', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                                        //   Container(height: 45, alignment: Alignment.center,child: const Text('기본', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                                        // ],
                                        indicator: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: PRIMARY_COLOR_05, width: 2
                                              ),
                                            )
                                        ),
                                        indicatorWeight: 4.0,
                                        dividerColor: Colors.transparent,
                                        indicatorSize: TabBarIndicatorSize.tab,
                                        labelColor: BODY_TEXT_COLOR_02,
                                        unselectedLabelColor: TEXT_COLOR_01,
                                        controller: TabController(length: categories.length, vsync: this, initialIndex: selectedTapIndex),
                                        onTap: _onTabTapped,
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            DialogUtil.basicLayout(context,
                                                content: const ProductCategoryEditView()
                                            );
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: COLOR_f3f4f6,
                                              borderRadius: BorderRadius.circular(7)
                                            ),
                                            child: const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 5,),
                                                child: Center(
                                                    child: Icon(Icons.add, size: 28, color: TEXT_COLOR_02,)
                                                )
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10,),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: COLOR_f3f4f6,
                                              borderRadius: BorderRadius.circular(7)
                                          ),
                                          child: const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 5,),
                                              child: Center(
                                                  child: Icon(Icons.search, size: 28, color: TEXT_COLOR_02,)
                                              )
                                          ),
                                        ),
                                        // SizedBox(width: 12,),
                                        // Container(
                                        //   height: 40,
                                        //   decoration: BoxDecoration(
                                        //       color: BODY_TEXT_COLOR_01,
                                        //       borderRadius: BorderRadius.circular(7)
                                        //   ),
                                        //   child: Padding(
                                        //     padding: EdgeInsets.symmetric(horizontal: 12,),
                                        //     child: Center(child: BodyText('전체완료', textSize: BodyTextSize.REGULAR)),
                                        //   ),
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: PageView(
                                controller: _pageController,
                                physics: const NeverScrollableScrollPhysics(), // 탭바에서 스크롤해도 옆으로 안넘어가는 설정
                                children: List.generate(categories.length, (index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Container(
                                        child: ProductGridView(productList: categories[index].productList)
                                    ),
                                  );
                                })
                              ),
                            ),

                            const SizedBox(height: 20,),

                            /// 상품 옵션 컴포넌트
                            _buildProductOptionView(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
            ),

            ///
            /// 주문 상품 컴포넌트
            ///
            _orderProductView()
          ],
        ),
      ),
    );
  }

  /// 주문 상품 컴포넌트
  Widget _orderProductView() {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(orderProvider);
        return Container(
          width: 320,
          color: PRIMARY_COLOR_04,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: Container(
                      child: Row(
                        children: [
                          CustomSlidingSegmentedControl<int>(
                            initialValue: initial,
                            height: 34,
                            innerPadding: EdgeInsets.all(3.0),
                            children: {
                              1: initial == 1 ? BodyText('포장', textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_01, fontWeight: FontWeight.w500,) : BodyText('포장', textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_02, fontWeight: FontWeight.w500,),
                              2: initial == 2 ? BodyText('배달', textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_01, fontWeight: FontWeight.w500,) : BodyText('배달', textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_02, fontWeight: FontWeight.w500,),
                              3: initial == 3 ? BodyText('대기', textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_01, fontWeight: FontWeight.w500,) : BodyText('대기', textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_02, fontWeight: FontWeight.w500,),
                            },
                            decoration: BoxDecoration(
                              color: SLIDER_BOX_COLOR_01,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            thumbDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 1.0,
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                ),
                              ],
                            ),
                            duration: Duration(milliseconds: 100),
                            curve: Curves.easeInToLinear,
                            onValueChanged: (v) {
                              setState(() {
                                initial = v;
                              });
                            },
                          ),
                          SizedBox(width: 8,),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.print, color: TEXT_COLOR_03, size: 26,)
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(orderProvider.notifier).clearItems();
                            },
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(Icons.delete, color: TEXT_COLOR_03, size: 26,)
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 8) ,child: Icon(Icons.bookmark, color: TEXT_COLOR_03, size: 26,)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: constraints.maxHeight //최소크기를 남은 크기로 지정
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                              children: state.orderProductList.length == 0
                                  ? List.empty()
                                  : List.generate(state.orderProductList.length, (index) {
                                final itemOptions = state.orderProductList[index].optionList;

                                final optionText = itemOptions
                                    .map((e) {
                                      final optionPrice = e.optionPrice != 0 ? '(${e.optionPrice})' : '';

                                      return '${e.optionNm}$optionPrice';
                                    })
                                    .join(' / ');

                                return MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      ref.read(orderProvider.notifier).selectProduct(state.orderProductList[index].productId);
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: state.orderProductList[index].isSelected ? COLOR_eaf3fe : PRIMARY_COLOR_04,
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: INPUT_TEXT_COLOR_01,
                                                        width: 0.2
                                                    )
                                                )
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                              child: Column(
                                                children: [
                                                  if(state.orderProductList[index].isSelected)
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 2, bottom: 12),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          NumberStepper(
                                                            counter: state.orderProductList[index].quantity,
                                                            onIncrement: () {
                                                              final updatedList = [...state.orderProductList];
                                                              final item = updatedList[index];
                                                              updatedList[index] = item.copyWith(quantity: item.quantity + 1);
                                                              ref.read(orderProvider.notifier).updateOrderList(updatedList);
                                                            },
                                                            onDecrement: () {
                                                              final updatedList = [...state.orderProductList];
                                                              final item = updatedList[index];
                                                              if(item.quantity > 1) {
                                                                updatedList[index] = item.copyWith(quantity: item.quantity - 1);
                                                                ref.read(orderProvider.notifier).updateOrderList(updatedList);
                                                              } else {
                                                                ref.read(orderProvider.notifier).removeItem(index);
                                                              }
                                                            },
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              ref.read(orderProvider.notifier).removeItem(index);
                                                            },
                                                            child: BasicButton('삭제', backgroundColor: PRIMARY_COLOR_04, textColor: TEXT_COLOR_05,),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      BodyText('${state.orderProductList[index].productNm} x${state.orderProductList[index].quantity}', textSize: BodyTextSize.REGULAR_HALF, fontWeight: FontWeight.w500, color: COLOR_505967,),
                                                      BodyText('${FormatUtil.numberFormatter(state.orderProductList[index].totalPrice)}', textSize: BodyTextSize.REGULAR_HALF, color: COLOR_505967,)
                                                    ],
                                                  ),
                                                  SizedBox(height: 6,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      BodyText(optionText, textSize: BodyTextSize.SMALL_HALF, fontWeight: FontWeight.w300, color: COLOR_6e7784,)
                                                    ]
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 180,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Container(
                          width: 140,
                          height: 52,
                          decoration: BoxDecoration(
                              color: COLOR_eaf3fe,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              child: Center(
                                child: BodyText('할인', textSize: BodyTextSize.LARGE, color: PRIMARY_COLOR_01,),
                              )
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 52,
                          decoration: BoxDecoration(
                              color: COLOR_f3f4f6,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              child: Center(
                                child: BodyText('분할결제', textSize: BodyTextSize.LARGE, color: COLOR_505967,),
                              )
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ref.read(orderProvider.notifier).order();
                          },
                          child: Container(
                            width: 140,
                            height: 100,
                            decoration: BoxDecoration(
                                color: PRIMARY_COLOR_01,
                                borderRadius: BorderRadius.circular(7)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BodyText('주문', textSize: BodyTextSize.HUGE, fontWeight: FontWeight.w500, color: PRIMARY_COLOR_04,),
                                SizedBox(width: 6,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: PRIMARY_COLOR_04,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                      child: Center(
                                        child: BodyText('8', textSize: BodyTextSize.REGULAR, fontWeight: FontWeight.w500, color: PRIMARY_COLOR_01,),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 100,
                          decoration: BoxDecoration(
                              color: COLOR_505967,
                              borderRadius: BorderRadius.circular(7)
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BodyText('결제', textSize: BodyTextSize.HUGE, fontWeight: FontWeight.w500, color: PRIMARY_COLOR_04,),
                                      SizedBox(width: 6,),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: PRIMARY_COLOR_04,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                            child: Center(
                                              child: BodyText('8', textSize: BodyTextSize.REGULAR, fontWeight: FontWeight.w500, color: COLOR_505967,),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                  BodyText('25,000원', textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w400, color: PRIMARY_COLOR_04,),
                                ],
                              )
                          ),
                        )
                      ],
                    )
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  /// 상품 옵션 컴포넌트
  Widget _buildProductOptionView() {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(orderProvider);
        final selectedOrderProduct = state.orderProductList.where((e) => e.isSelected).firstOrNull;

        final selectedProduct = selectedOrderProduct != null
            ? ref.read(productCategoryProvider.notifier).findSelectedProduct(selectedOrderProduct.productId)
            : null;

        if (selectedProduct == null) {
          return const SizedBox(
            height: 150,
          );
        }

        final allOptions = selectedProduct.optionGroupList!
            .expand((group) => group.optionList)
            .toList();

        return SizedBox(
          height: 150,
          child: Column(
            children: [
              Row(
                children: [
                  BodyText('옵션', textSize: BodyTextSize.REGULAR_HALF, fontWeight: FontWeight.w500,),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(allOptions.length, (index) {
                          final option = allOptions[index];
                          return InkWell(
                            onTap: () {
                              ref.read(orderProvider.notifier).addItemOption(selectedProduct.productId,
                                  option: OrderProductOption(
                                    optionId: option.productOptionId,
                                    optionNm: option.productOptionNm,
                                    optionPrice: option.optionPrice,
                                  )
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: BODY_TEXT_COLOR_01,
                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                  child: Center(
                                    child: BodyText('${option.productOptionNm} (${FormatUtil.numberFormatter(option.optionPrice)})', textSize: BodyTextSize.SMALL),
                                  )
                              ),
                            ),
                          );
                        })
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }
    );
  }
}
