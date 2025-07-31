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
  late PageController _pageController;

  int selectedIndex = 0;
  int selectedTapIndex = 0;
  @override
  void initState() {
    final state = ref.read(orderStatusProvider);

    if(state.value!.isNotEmpty) {
      OrderModel? progressOrder = state.value!.where((order) => order.orderStatus == OrderStatus.PROGRESS).firstOrNull;
      OrderModel? completeOrder = state.value!.where((order) => order.orderStatus == OrderStatus.COMPLETE).firstOrNull;
      OrderModel? cancelOrder = state.value!.where((order) => order.orderStatus == OrderStatus.CANCEL).firstOrNull;

      if(cancelOrder != null) {
        selectedIndex = cancelOrder.orderId!;
      }
      if(completeOrder != null) {
        selectedIndex = completeOrder.orderId!;
      }
      if(progressOrder != null) {
        selectedIndex = progressOrder.orderId!;
      }
    }

    _tabController = TabController(
      length: 4,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
      initialIndex: selectedTapIndex
    );

    _pageController = PageController(
      initialPage: selectedTapIndex,
    );

    _tabController.addListener(() {
      setState(() {
        selectedTapIndex = _tabController.index;
        final state = ref.read(orderStatusProvider).value;

        if(selectedTapIndex == 0 || selectedTapIndex == 1) {
          OrderModel? progressOrder = state!.where((order) => order.orderStatus == OrderStatus.PROGRESS).firstOrNull;
          if(progressOrder != null) {
            selectedIndex = progressOrder.orderId!;
          }
        }
        if(selectedTapIndex == 2) {
          OrderModel? completeOrder = state!.where((order) => order.orderStatus == OrderStatus.COMPLETE).firstOrNull;
          if(completeOrder != null) {
            selectedIndex = completeOrder.orderId!;
          }
        }
        if(selectedTapIndex == 3) {
          OrderModel? cancelOrder = state!.where((order) => order.orderStatus == OrderStatus.CANCEL).firstOrNull;
          if(cancelOrder != null) {
            selectedIndex = cancelOrder.orderId!;
          }
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
    return DefaultLayout(
      selectedTapIndex: 1,
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
                              width: 340,
                              child: TabBar(
                                tabs: [
                                  Container(height: 45, alignment: Alignment.center,child: const Text('전체', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
                                  Container(height: 45, alignment: Alignment.center,child: const Text('진행', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
                                  Container(height: 45,alignment: Alignment.center, child: const Text('완료', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
                                  Container(height: 45,alignment: Alignment.center, child: const Text('취소', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),)),
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
                                onTap: _onTabTapped,
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
    final state = ref.watch(orderStatusProvider);

    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(), // 탭바에서 스크롤해도 옆으로 안넘어가는 설정
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
                        child: state.when(
                            data: (orders) {
                              if(orders.isNotEmpty) {
                                return OrderStatusView(order: orders.where((order) => order.orderId == selectedIndex).first);
                              }
                              return const Text('표시할 주문이 없어요');
                            },
                            error: (e, _) => const Text('에러'),
                            loading: () => const CircularProgressIndicator()
                        ),
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
                        // child: state.where((order) => order.orderStatus == OrderStatus.PROGRESS).firstOrNull != null
                        //     ? OrderStatusView(order: state.where((order) => order.orderStatus == OrderStatus.PROGRESS).first)
                        //     : const Center(child: Text('표시할 주문이 없어요'),)
                        child: state.when(
                            data: (orders) {
                              if(orders.where((order) => order.orderStatus == OrderStatus.PROGRESS).firstOrNull != null) {
                                return OrderStatusView(order: orders.where((order) => order.orderId == selectedIndex).first);
                              }
                              return const Text('표시할 주문이 없어요');
                            },
                            error: (e, _) => const Text('에러'),
                            loading: () => const CircularProgressIndicator()
                        ),
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
                        // child: state.where((order) => order.orderStatus == OrderStatus.COMPLETE).firstOrNull != null
                        //     ? OrderStatusView(order: state.where((order) => order.orderStatus == OrderStatus.COMPLETE).first)
                        //     : const Center(child: Text('표시할 주문이 없어요'),)
                        child: state.when(
                            data: (orders) {
                              if(orders.where((order) => order.orderStatus == OrderStatus.COMPLETE).firstOrNull != null) {
                                return OrderStatusView(order: orders.where((order) => order.orderId == selectedIndex).first);
                              }
                              return const Text('표시할 주문이 없어요');
                            },
                            error: (e, _) => const Text('에러'),
                            loading: () => const CircularProgressIndicator()
                        ),
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
                        // child: state.where((order) => order.orderStatus == OrderStatus.CANCEL).firstOrNull != null
                        //     ? OrderStatusView(order: state.where((order) => order.orderStatus == OrderStatus.CANCEL).first)
                        //     : const Center(child: Text('표시할 주문이 없어요'),)
                        child: state.when(
                            data: (orders) {
                              if(orders.where((order) => order.orderStatus == OrderStatus.CANCEL).firstOrNull != null) {
                                return OrderStatusView(order: orders.where((order) => order.orderId == selectedIndex).first);
                              }
                              return const Text('표시할 주문이 없어요');
                            },
                            error: (e, _) => const Text('에러'),
                            loading: () => const CircularProgressIndicator()
                        ),
                    )
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
                                        _buildComplete(necessary: true),
                                        if(selectedTapIndex == 3)
                                        _buildCancel(necessary: true),
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
        _buildCancel(),
      ],
    );
  }

  Widget _buildProgress() {
    final state = ref.watch(orderStatusProvider);
    List<OrderModel> orderList = state.value!.where((order) => order.orderStatus == OrderStatus.PROGRESS).toList();
    orderList.sort((a, b) => a.orderId!.compareTo(b.orderId!));
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
                BodyText('진행 ${orderList.isNotEmpty ? orderList.length : ''}', color: TEXT_COLOR_01, fontWeight: FontWeight.w500, textSize: BodyTextSize.SMALL_HALF),
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
                  selectedIndex = orderList[index].orderId!;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: selectedIndex == orderList[index].orderId ? COLOR_eaf3fe : PRIMARY_COLOR_04,
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
                        padding: const EdgeInsets.only(top: 12, bottom: 20, left: 12, right: 12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BodyText('매장 002', color: TEXT_COLOR_01, fontWeight: FontWeight.w500, textSize: BodyTextSize.REGULAR_HALF),
                                BodyText('09:26', color: TEXT_COLOR_02, textSize: BodyTextSize.SMALL_HALF),
                              ],
                            ),
                            SizedBox(height: 14,),
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: TEXT_COLOR_03,
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
                                      BodyText('${FormatUtil.numberFormatter(orderList[index].totalPrice)}원', color: PRIMARY_COLOR_03, textSize: BodyTextSize.REGULAR_HALF, fontWeight: FontWeight.w500)
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
        _buildEmptyOrder()
      ],
    );
  }

  Widget _buildComplete({
    bool necessary = false
}) {
    final state = ref.watch(orderStatusProvider);
    List<OrderModel> orderList = state.value!.where((order) => order.orderStatus == OrderStatus.COMPLETE).toList();
    orderList.sort((a, b) => a.orderId!.compareTo(b.orderId!));

    if(!necessary && orderList.isEmpty) {
      return Container();
    }

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BodyText('완료 ${orderList.isNotEmpty ? orderList.length : ''}', color: TEXT_COLOR_01, fontWeight: FontWeight.w500, textSize: BodyTextSize.SMALL_HALF),
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
                      selectedIndex = orderList[index].orderId!;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex == orderList[index].orderId ? COLOR_eaf3fe : PRIMARY_COLOR_04,
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
                                    BodyText('09:26', color: TEXT_COLOR_02, textSize: BodyTextSize.SMALL_HALF),
                                  ],
                                ),
                                SizedBox(height: 16,),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: TEXT_COLOR_03,
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
                                          BodyText('${FormatUtil.numberFormatter(orderList[index].totalPrice)}원', color: PRIMARY_COLOR_03, textSize: BodyTextSize.REGULAR_HALF, fontWeight: FontWeight.w500)
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
          _buildEmptyOrder()
      ],
    );
  }

  Widget _buildCancel({
    bool necessary = false
}) {
    final state = ref.watch(orderStatusProvider);
    List<OrderModel> orderList = state.value!.where((order) => order.orderStatus == OrderStatus.CANCEL).toList();
    orderList.sort((a, b) => a.orderId!.compareTo(b.orderId!));

    if(!necessary && orderList.isEmpty) {
      return Container();
    }

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BodyText('취소 ${orderList.isNotEmpty ? orderList.length : ''}', color: TEXT_COLOR_01, fontWeight: FontWeight.w500, textSize: BodyTextSize.SMALL_HALF),
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
                      selectedIndex = orderList[index].orderId!;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex == orderList[index].orderId ? COLOR_eaf3fe : PRIMARY_COLOR_04,
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
                                    BodyText('09:26', color: TEXT_COLOR_02, textSize: BodyTextSize.SMALL_HALF),
                                  ],
                                ),
                                SizedBox(height: 16,),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: TEXT_COLOR_03,
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
                                          BodyText('${FormatUtil.numberFormatter(orderList[index].totalPrice)}원', color: PRIMARY_COLOR_03, textSize: BodyTextSize.REGULAR_HALF, fontWeight: FontWeight.w500)
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
          _buildEmptyOrder()
      ],
    );
  }

  Widget _buildEmptyOrder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: BodyText('진행중인 주문이 없어요', color: TEXT_COLOR_03, textSize: BodyTextSize.REGULAR),
        )
      ],
    );
  }
}
