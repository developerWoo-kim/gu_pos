import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/provider/order_status_provider.dart';
import 'package:gu_pos/app/order/component/order_status_view.dart';
import 'package:gu_pos/common/utils/format_util.dart';


import '../../../common/component/text/body_text.dart';
import '../../../common/const/colors.dart';
import '../../../common/layout/default_layout.dart';
import '../model/order_model.dart';
import '../provider/order_provider.dart';

class OrderStatusScreen extends ConsumerStatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  ConsumerState<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends ConsumerState<OrderStatusScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  int selectedIndex = 0;
  int selectedTapIndex = 0;
  @override
  void initState() {
    final state = ref.read(orderStatusProvider);

    if(state.isNotEmpty) {
      OrderModel? progressOrder = state.where((order) => order.orderStatus == OrderStatus.PROGRESS).firstOrNull;
      OrderModel? completeOrder = state.where((order) => order.orderStatus == OrderStatus.COMPLETE).firstOrNull;
      OrderModel? cancelOrder = state.where((order) => order.orderStatus == OrderStatus.CANCEL).firstOrNull;

      if(cancelOrder != null) {
        selectedIndex = cancelOrder.orderIndex!;
      }
      if(completeOrder != null) {
        selectedIndex = completeOrder.orderIndex!;
      }
      if(progressOrder != null) {
        selectedIndex = progressOrder.orderIndex!;
      }
    }

    _tabController = TabController(
      length: 4,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );

    _tabController.addListener(() {
      print("선택된 탭 인덱스: ${_tabController.index}");
      setState(() {
        selectedTapIndex = _tabController.index;
      });
    });

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
      body: Expanded(
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: PRIMARY_COLOR_02,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                      child: Container(
                        decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                      color: PRIMARY_COLOR_04, width: 0.5
                                  ),
                                )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 350,
                              child: TabBar(
                                tabs: [
                                  Container(height: 45, alignment: Alignment.center,child: const Text('전체', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                                  Container(height: 45, alignment: Alignment.center,child: const Text('진행', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                                  Container(height: 45,alignment: Alignment.center, child: const Text('완료', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                                  Container(height: 45,alignment: Alignment.center, child: const Text('취소', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
                                ],
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
                                controller: _tabController,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: BODY_TEXT_COLOR_01,
                                      borderRadius: BorderRadius.circular(7)
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5,),
                                      child: Center(
                                          child: Icon(Icons.refresh_sharp, size: 28,)
                                      )
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: BODY_TEXT_COLOR_01,
                                      borderRadius: BorderRadius.circular(7)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12,),
                                    child: Center(child: BodyText('전체완료', textSize: BodyTextSize.REGULAR)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),


                    /// 주문 화면
                    _buildOrderStatusView()

                  ],
                )
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildOrderStatusView() {
    final state = ref.read(orderStatusProvider);
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(), // 탭바에서 스크롤해도 옆으로 안넘어가는 설정
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
                        child: state.isNotEmpty
                          ? OrderStatusView(order: state.where((order) => order.orderIndex == selectedIndex).first)
                          : const Center(child: Text('표시할 주문이 없어요'),)
                    )
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Tab1 View',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Tab1 View',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Tab1 View',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              width: 340,
              color: PRIMARY_COLOR_04,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                      children: [
                                        if(selectedTapIndex == 0)
                                        _buildAll(),
                                        if(selectedTapIndex == 1)
                                        _buildProgress(),
                                        if(selectedTapIndex == 2)
                                        _buildComplete(),
                                        if(selectedTapIndex == 3)
                                        _buildCancel()
                                        // InkWell(
                                        //   onTap: () {
                                        //     setState(() {
                                        //
                                        //     });
                                        //   },
                                        //   child: Container(
                                        //     decoration: BoxDecoration(
                                        //         color: PRIMARY_COLOR_04,
                                        //         border: Border(
                                        //             bottom: BorderSide(
                                        //                 color: COLOR_505967,
                                        //                 width: 0.1
                                        //             )
                                        //         )
                                        //     ),
                                        //     child: Row(
                                        //       children: [
                                        //         Expanded(
                                        //           child: Padding(
                                        //             padding: const EdgeInsets.only(top: 16, bottom: 20, left: 12, right: 12),
                                        //             child: Column(
                                        //               children: [
                                        //                 Row(
                                        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //                   children: [
                                        //                     BodyText('매장 002', color: TEXT_COLOR_01, fontWeight: FontWeight.w500, textSize: BodyTextSize.REGULAR_HALF),
                                        //                     BodyText('09:26', color: TEXT_COLOR_03, textSize: BodyTextSize.SMALL_HALF),
                                        //                   ],
                                        //                 ),
                                        //                 SizedBox(height: 16,),
                                        //                 Row(
                                        //                   children: [
                                        //                     Container(
                                        //                       height: 30,
                                        //                       width: 30,
                                        //                       decoration: BoxDecoration(
                                        //                         color: TEXT_COLOR_02,
                                        //                         shape: BoxShape.circle,
                                        //                       ),
                                        //                       child: Center(
                                        //                         child: BodyText('포스', color: PRIMARY_COLOR_04, textSize: BodyTextSize.SMALL, fontWeight: FontWeight.w500),
                                        //                       ),
                                        //                     ),
                                        //                     SizedBox(width: 10,),
                                        //                     Column(
                                        //                       crossAxisAlignment: CrossAxisAlignment.start,
                                        //                       mainAxisAlignment: MainAxisAlignment.center,
                                        //                       children: [
                                        //                         BodyText('sample 티셔츠 1', color: COLOR_6e7784, textSize: BodyTextSize.SMALL, fontWeight: FontWeight.w500),
                                        //                         BodyText('4,000원', color: PRIMARY_COLOR_03, textSize: BodyTextSize.REGULAR_HALF, fontWeight: FontWeight.w500)
                                        //                       ],
                                        //                     )
                                        //                   ],
                                        //                 )
                                        //               ],
                                        //             ),
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),

                                      ],
                                    )
                                )
                              ],
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              )
          )
        ],
      ),
    );
  }

  Widget _buildAll() {
    return Column(
      children: [
        _buildProgress(),
        _buildComplete(),
        _buildCancel()
      ],
    );
  }

  Widget _buildProgress() {
    final state = ref.read(orderStatusProvider);
    List<OrderModel> orderList = state.where((order) => order.orderStatus == OrderStatus.PROGRESS).toList();
    orderList.sort((a, b) => a.orderIndex!.compareTo(b.orderIndex!));
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: COLOR_f3f4f6,
              border: Border(
                  bottom: BorderSide(
                      color: COLOR_505967,
                      width: 0.2
                  )
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BodyText('진행', color: TEXT_COLOR_01, fontWeight: FontWeight.w500, textSize: BodyTextSize.SMALL_HALF),
                BodyText('최신순', color: TEXT_COLOR_01, textSize: BodyTextSize.SMALL)
              ],
            ),
          ),
        ),
        if(orderList.isNotEmpty)
        Column(
          children: List.generate(orderList.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = orderList[index].orderIndex!;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: selectedIndex == orderList[index].orderIndex ? COLOR_eaf3fe : PRIMARY_COLOR_04,
                    border: Border(
                        bottom: BorderSide(
                            color: COLOR_505967,
                            width: 0.1
                        )
                    )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 20, left: 12, right: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BodyText('매장 002', color: TEXT_COLOR_01, fontWeight: FontWeight.w500, textSize: BodyTextSize.REGULAR_HALF),
                                BodyText('09:26', color: TEXT_COLOR_03, textSize: BodyTextSize.SMALL_HALF),
                              ],
                            ),
                            SizedBox(height: 16,),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: TEXT_COLOR_02,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: BodyText('포스', color: PRIMARY_COLOR_04, textSize: BodyTextSize.SMALL, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      BodyText(orderList[index].totalOrderItemNm, color: COLOR_6e7784, textSize: BodyTextSize.SMALL, fontWeight: FontWeight.w500),
                                      BodyText(FormatUtil.numberFormatter(orderList[index].totalPrice), color: PRIMARY_COLOR_03, textSize: BodyTextSize.REGULAR_HALF, fontWeight: FontWeight.w500)
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          })
        ),
        if(orderList.isEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: BodyText('진행중인 주문이 없어요', color: TEXT_COLOR_02, textSize: BodyTextSize.REGULAR),
            )
          ],
        )
      ],
    );
  }

  Widget _buildComplete() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: COLOR_f3f4f6,
              border: Border(
                  bottom: BorderSide(
                      color: COLOR_505967,
                      width: 0.2
                  )
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BodyText('완료 1', color: TEXT_COLOR_01, fontWeight: FontWeight.w500, textSize: BodyTextSize.SMALL_HALF),
                BodyText('최신순', color: TEXT_COLOR_01, textSize: BodyTextSize.SMALL)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCancel() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: COLOR_f3f4f6,
              border: Border(
                  bottom: BorderSide(
                      color: COLOR_505967,
                      width: 0.2
                  )
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BodyText('취소 1', color: TEXT_COLOR_01, fontWeight: FontWeight.w500, textSize: BodyTextSize.SMALL_HALF),
                BodyText('최신순', color: TEXT_COLOR_01, textSize: BodyTextSize.SMALL)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
