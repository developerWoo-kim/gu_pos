import 'package:flutter/material.dart';
import 'package:gu_pos/common/component/app/order/order_status_view.dart';

import '../common/component/text/body_text.dart';
import '../common/const/colors.dart';
import '../common/layout/default_layout.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
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
                                  Container(
                                      height: 45,
                                      alignment: Alignment.center,
                                      child: BodyText('전체', color: _tabController.index == 0 ? BODY_TEXT_COLOR_02 : TEXT_COLOR_01, textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w500,)
                                  ),
                                  Container(
                                      height: 45,
                                      alignment: Alignment.center,
                                      child: BodyText('진행', color: _tabController.index == 1 ? BODY_TEXT_COLOR_02 : TEXT_COLOR_01, textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w500,)
                                  ),
                                  Container(
                                      height: 45,
                                      alignment: Alignment.center,
                                      child: BodyText('완료', color: _tabController.index == 1 ? BODY_TEXT_COLOR_02 : TEXT_COLOR_01, textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w500,)
                                  ),
                                  Container(
                                      height: 45,
                                      alignment: Alignment.center,
                                      child: BodyText('취소', color: _tabController.index == 1 ? BODY_TEXT_COLOR_02 : TEXT_COLOR_01, textSize: BodyTextSize.LARGE, fontWeight: FontWeight.w500,)
                                  ),
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


                    Expanded(
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
                                    child: OrderStatusView(),
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
                                      children: List.generate(50, (index) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Expanded(child: BodyText('결제금액', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM)),
                                                      Expanded(child: BodyText('결제금액', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM))
                                                    ],
                                                  )
                                                ],
                                              )
                                            )
                                          ],
                                        );
                                      })
                                    ),
                                  ),
                                ),
                              ],
                            )
                          )

                        ],
                      ),
                    )

                  ],
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}
