import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/common/component/text/body_text.dart';
import 'package:gu_pos/guide/model/item_option_model.dart';
import 'package:gu_pos/guide/model/order_item_model.dart';
import 'package:gu_pos/guide/provider/order_provider.dart';

import '../common/component/button/basic_button.dart';
import '../common/component/button/number_stepper.dart';
import '../common/const/colors.dart';
import '../common/layout/default_layout.dart';

class OrderTestScreen extends ConsumerStatefulWidget {
  const OrderTestScreen({super.key});

  @override
  ConsumerState<OrderTestScreen> createState() => _OrderTestScreenState();
}

enum SegmentType { news, map, paper }
enum TestType { segmentation, max, news }

class _OrderTestScreenState extends ConsumerState<OrderTestScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  TestType initialTestType = TestType.max;
  int initial = 1;
  bool isPayment = false;
  int initialValue = 0;

  int selectedOrderItemIndex = 0;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body:  Expanded(
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: PRIMARY_COLOR_02,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Container(
                              height: 45,
                              alignment: Alignment.center,
                              child: BodyText('즐겨찾는 메뉴', color: _tabController.index == 0 ? BODY_TEXT_COLOR_02 : TEXT_COLOR_01, textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w500,)
                          ),
                          Container(
                              height: 45,
                              alignment: Alignment.center,
                              child: BodyText('기본', color: _tabController.index == 1 ? BODY_TEXT_COLOR_02 : TEXT_COLOR_01, textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w500,)
                          ),
                        ],
                        indicator: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: PRIMARY_COLOR_05, width: 2
                              ),
                            )
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        controller: _tabController,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: NeverScrollableScrollPhysics(), // 탭바에서 스크롤해도 옆으로 안넘어가는 설정
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                              spacing: 10,
                                              runSpacing: 10,
                                              children: List.generate(10, (index) {
                                                return InkWell(
                                                  onTap: () {
                                                    ref.read(orderProvider.notifier).addItem(
                                                        OrderItemModel(
                                                            orderItemId: '아메리카노_$index',
                                                            orderItemNm: '아메리카노_$index',
                                                            price: 4500,
                                                            quantity: 1
                                                        )
                                                    );
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.115,
                                                    height: MediaQuery.of(context).size.height * 0.145,
                                                    decoration: BoxDecoration(
                                                        color: PRIMARY_COLOR_01,
                                                        borderRadius: BorderRadius.circular(7)
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              BodyText('아메리카노_$index', textSize: BodyTextSize.REGULAR,  color: PRIMARY_COLOR_04,)
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          Row(
                                                            children: [
                                                              BodyText('4,000', textSize: BodyTextSize.SMALL, color: PRIMARY_COLOR_04,)
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                          ),
                                        )
                                      ]
                                  )
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Tab2 View',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        height: 200,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit_note, color: TEXT_COLOR_01, size: 24,),
                                      SizedBox(width: 2,),
                                      BodyText('편집모드', textSize: BodyTextSize.SMALL_HALF, fontWeight: FontWeight.w300, color: PRIMARY_COLOR_03,)
                                    ],
                                  ),
                                ),
                                SizedBox(width: 18,),
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.add_circle, color: TEXT_COLOR_01, size: 20,),
                                      SizedBox(width: 2,),
                                      BodyText('상품추가', textSize: BodyTextSize.SMALL_HALF, fontWeight: FontWeight.w300, color: PRIMARY_COLOR_03,)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 30,),
                            Row(
                              children: [
                                BodyText('옵션', textSize: BodyTextSize.REGULAR_HALF, fontWeight: FontWeight.w500,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: List.generate(3, (index) {
                                        return InkWell(
                                          onTap: () {
                                            ref.read(orderProvider.notifier).addItemOption(selectedOrderItemIndex,
                                                item: ItemOptionModel(
                                                  optionId: index,
                                                  optionNm: '옵션_$index',
                                                  optionPrice: 500,
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
                                                  child: BodyText('옵션_$index', textSize: BodyTextSize.SMALL),
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
                      ),

                    ],
                  ),
                ),
              ),
            ),

            ///
            /// 주문 컴포넌트
            ///
            _orderItemView()
          ],
        ),
      ),
    );
  }

  Widget _orderItemView() {
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
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8) ,child: Icon(Icons.print, color: TEXT_COLOR_03, size: 26,)),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 8) ,child: Icon(Icons.delete, color: TEXT_COLOR_03, size: 26,)),
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
                          children: state.orderItemList.length == 0
                              ? List.empty()
                              : List.generate(state.orderItemList.length, (index) {
                            final itemOptions = state.orderItemList[index].itemOptionList;
                            final optionText = itemOptions
                                .map((e) => '${e.optionNm} x${e.quantity}')
                                .join(' / ');

                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedOrderItemIndex = index;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: selectedOrderItemIndex == index ? COLOR_eaf3fe : PRIMARY_COLOR_04,
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
                                              if(selectedOrderItemIndex == index)
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 2, bottom: 12),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      NumberStepper(
                                                        counter: state.orderItemList[index].quantity,
                                                        onIncrement: () {
                                                          final updatedList = [...state.orderItemList];
                                                          final item = updatedList[index];
                                                          updatedList[index] = item.copyWith(quantity: item.quantity + 1);
                                                          ref.read(orderProvider.notifier).updateOrderList(updatedList);
                                                        },
                                                        onDecrement: () {
                                                          final updatedList = [...state.orderItemList];
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
                                                  BodyText('${state.orderItemList[index].orderItemNm} x${state.orderItemList[index].quantity}', textSize: BodyTextSize.REGULAR_HALF, fontWeight: FontWeight.w500, color: COLOR_505967,),
                                                  BodyText('4,500', textSize: BodyTextSize.REGULAR_HALF, color: COLOR_505967,)
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
                    Container(
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
}
