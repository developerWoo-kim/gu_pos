import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gu_pos/common/component/text/body_text.dart';

import '../common/const/colors.dart';
import '../common/layout/default_layout.dart';

class OrderTestScreen extends StatefulWidget {
  const OrderTestScreen({super.key});

  @override
  State<OrderTestScreen> createState() => _OrderTestScreenState();
}

enum SegmentType { news, map, paper }
enum TestType { segmentation, max, news }

class _OrderTestScreenState extends State<OrderTestScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  TestType initialTestType = TestType.max;
  int initial = 1;
  bool isPayment = false;
  int initialValue = 0;

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
      body: SizedBox.expand( // 여기서 화면 전체를 채움
        child: Column(
          children: [
            // 예: 상단 고정 영역
            Container(
              height: 60,
              color: PRIMARY_COLOR_03,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.dehaze_sharp, color: PRIMARY_COLOR_04, size: 38),
                    Container(
                      child: Row(
                        children: [
                          BodyText('주문', textSize: BodyTextSize.LARGE, color: PRIMARY_COLOR_04),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
                          BodyText('현황', textSize: BodyTextSize.LARGE, color: TEXT_COLOR_04),
                        ],
                      )
                    ),
                    Container(
                      child: Row(
                        children: [
                          BodyText('7.1(화) 오후 5:07', textSize: BodyTextSize.REGULAR, color: PRIMARY_COLOR_04, fontWeight: FontWeight.w300,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: PRIMARY_COLOR_02,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Text('dsds'),
                                        )
                                      ],
                                    )
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 320,
                    color: PRIMARY_COLOR_04,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
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
                        Row(
                          children: [],
                        ),
                        Row(
                          children: [],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
