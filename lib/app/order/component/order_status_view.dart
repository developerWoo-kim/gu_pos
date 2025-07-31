import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/provider/order_status_provider.dart';
import 'package:gu_pos/common/component/button/basic_button.dart';
import 'package:gu_pos/common/component/text/body_text.dart';
import 'package:gu_pos/common/utils/format_util.dart';

import '../model/order_model.dart';
import '../../../common/const/colors.dart';

class OrderStatusView extends ConsumerStatefulWidget {
  final OrderModel order;

  const OrderStatusView({
    required this.order,
    super.key
  });

  @override
  ConsumerState<OrderStatusView> createState() => _OrderStatusViewState();
}

class _OrderStatusViewState extends ConsumerState<OrderStatusView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 55,
                    width: 60,
                    decoration: BoxDecoration(
                        color: TEXT_COLOR_03,
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
                      BodyText('메뉴 ${widget.order.orderProductList.length}개 총 ${FormatUtil.numberFormatter(widget.order.totalPrice)}원', color: PRIMARY_COLOR_05, textSize: BodyTextSize.HUGE, fontWeight: FontWeight.w500,),
                    ],
                  )
                ],
              ),
            ),
            if(widget.order.orderStatus == OrderStatus.PROGRESS)
              _buildCompleteButton(),
            if(widget.order.orderStatus == OrderStatus.COMPLETE)
              _buildCompleteCancelButton(),
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
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BodyText('주문 금액', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
                              BodyText('${FormatUtil.numberFormatter(widget.order.totalPrice)}원', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
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
                              BodyText('${FormatUtil.numberFormatter(widget.order.totalPrice)}원', color: TEXT_COLOR_01, textSize: BodyTextSize.REGULAR_HALF),
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
                              BodyText('', color: BODY_TEXT_COLOR_02, textSize: BodyTextSize.MEDIUM),
                            ],
                          ),
                          const Spacer(),
                          if(widget.order.orderStatus == OrderStatus.CANCEL)
                            BasicButton('결제내역',
                              backgroundColor: COLOR_f3f4f6,
                              textColor: TEXT_COLOR_01
                            ),
                          if(widget.order.orderStatus != OrderStatus.CANCEL)
                            Row(
                              children: [
                                Expanded(
                                  child: BasicButton('결제내역',
                                      backgroundColor: COLOR_f3f4f6,
                                      textColor: TEXT_COLOR_01
                                  ),
                                ),
                                SizedBox(width: 12,),
                                Expanded(
                                  child: BasicButton('결제 취소',
                                      backgroundColor: COLOR_fceeef,
                                      textColor: COLOR_d23e41
                                  ),
                                )
                              ],
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
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: List.generate(widget.order.orderProductList.length, (index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 18),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 6,
                                            child: BodyText(widget.order.orderProductList[index].productNm, color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BodyText('${widget.order.orderProductList[index].quantity}', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM),
                                                BodyText('${FormatUtil.numberFormatter(widget.order.orderProductList[index].totalPrice)}원', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12,),
                                      Column(
                                        children: List.generate(widget.order.orderProductList[index].optionList.length, (optionIndex) {
                                          final itemOption = widget.order.orderProductList[index].optionList[optionIndex];
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 4),
                                            child: Row(
                                              children: [
                                                Expanded(child: BodyText('ㄴ ${itemOption.optionNm} (+${itemOption.optionPrice})',textSize: BodyTextSize.REGULAR, color: TEXT_COLOR_03,))
                                              ],
                                            ),
                                          );
                                        })
                                      )
                                    ],
                                  ),
                                )
                              );
                            })
                          ),
                        ),
                        // const Spacer(),
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
                                  BodyText('${widget.order.totalQuantity}', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM),
                                  BodyText('${FormatUtil.numberFormatter(widget.order.totalPrice)}원', color: TEXT_COLOR_05, textSize: BodyTextSize.MEDIUM)
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

  Widget _buildCompleteButton() {
    return InkWell(
      onTap: () {
        ref.read(orderStatusProvider.notifier).complete(widget.order.orderId!);
      },
      child: BasicButton('완료',
          backgroundColor: PRIMARY_COLOR_03,
          textColor: PRIMARY_COLOR_04
      ),
    );
  }

  Widget _buildCompleteCancelButton() {
    return InkWell(
      onTap: () {
        ref.read(orderStatusProvider.notifier).cancelComplete(widget.order.orderId!);
      },
      child: BasicButton('완료 취소',
          backgroundColor: TEXT_COLOR_04,
          textColor: TEXT_COLOR_05,
      ),
    );
  }
}
