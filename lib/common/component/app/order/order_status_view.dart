import 'package:flutter/material.dart';
import 'package:gu_pos/common/component/button/basic_button.dart';
import 'package:gu_pos/common/component/text/body_text.dart';

import '../../../const/colors.dart';

class OrderStatusView extends StatefulWidget {
  const OrderStatusView({super.key});

  @override
  State<OrderStatusView> createState() => _OrderStatusViewState();
}

class _OrderStatusViewState extends State<OrderStatusView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 55,
              width: 60,
              decoration: BoxDecoration(
                  color: TEXT_COLOR_02,
                  borderRadius: BorderRadius.circular(7)
              ),
              child: Center(
                child: BodyText('포스', color: PRIMARY_COLOR_04, textSize: BodyTextSize.LARGE_HALF, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyText('매장 001', color: TEXT_COLOR_01, textSize: BodyTextSize.MEDIUM_HALF, fontWeight: FontWeight.w500,),
                BodyText('메뉴 2개 총 8,500원', color: PRIMARY_COLOR_05, textSize: BodyTextSize.HUGE, fontWeight: FontWeight.w500,),
              ],
            )
          ],
        ),

        const SizedBox(height: 16,),

        Expanded(
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        color: PRIMARY_COLOR_04,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText('주문 금액', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                              BodyText('8,500원', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText('할인 금액', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                              BodyText('0원', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText('결제 금액', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                              BodyText('8,500원', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(color: PRIMARY_COLOR_02,),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText('결제시간', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                              BodyText('07.07(월) 17:01', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText('취소시간', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                              BodyText('07.07(월) 21:28', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText('결제수단', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                              BodyText('현금', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                            ],
                          ),
                          const SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText('승인상태', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                              BodyText('취소됨', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                            ],
                          ),
                          const Spacer(),
                          BasicButton('결제내역 보기',
                            backgroundColor: COLOR_f3f4f6,
                            textColor: TEXT_COLOR_01
                          )
                        ],
                      ),
                    ),
                  )
              ),
              const SizedBox(width: 16,),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                      color: PRIMARY_COLOR_04,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: BodyText('sample 청바지', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BodyText('1', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM),
                                        BodyText('4,500원', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: BodyText('sample 청바지', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BodyText('1', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM),
                                        BodyText('4,500원', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16,),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: PRIMARY_COLOR_02,),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 6,
                              child: BodyText('결제금액', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BodyText('2', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM),
                                  BodyText('8,500원', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM)
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            Expanded(
                              child: BasicButton('주문서 출력',
                                  backgroundColor: COLOR_eaf3fe,
                                  textColor: PRIMARY_COLOR_01
                              ),
                            ),
                            SizedBox(width: 12,),
                            Expanded(
                              child: BasicButton('영수증 출력',
                                  backgroundColor: COLOR_eaf3fe,
                                  textColor: PRIMARY_COLOR_01
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
