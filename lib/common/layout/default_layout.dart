import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/provider/order_status_provider.dart';
import 'package:gu_pos/app/order/view/order_status_screen.dart';
import 'package:gu_pos/app/order/view/order_screen.dart';

import '../component/text/body_text.dart';
import '../const/colors.dart';

class DefaultLayout extends ConsumerStatefulWidget {
  final AppBar? appBar;
  final Widget body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;

  const DefaultLayout({super.key,
      this.appBar,
      required this.body,
      this.backgroundColor,
      this.bottomNavigationBar
      });

  @override
  ConsumerState<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends ConsumerState<DefaultLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: widget.backgroundColor ?? PRIMARY_COLOR_04,
      appBar: widget.appBar,
      body: SizedBox.expand(
        child: Column(
          children: [
            _buildHeader(),
            widget.body
          ],
        ),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }

  Widget _buildHeader() {
    final state = ref.watch(orderStatusProvider);
    return Container(
      height: 60,
      color: PRIMARY_COLOR_03,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.dehaze_sharp, color: PRIMARY_COLOR_04, size: 38),
            Container(
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const OrderScreen(),
                            ),
                          );
                        },
                        child: BodyText('주문', textSize: BodyTextSize.LARGE, color: PRIMARY_COLOR_04)
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: VerticalDivider(
                        width: 10,            // Divider가 차지하는 공간의 전체 너비
                        thickness: 0.5,         // 선의 두께
                        color: TEXT_COLOR_04,   // 선 색상
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const OrderStatusScreen(),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BodyText('현황',
                              textSize: BodyTextSize.LARGE,
                              color: TEXT_COLOR_04
                          ),
                          if(state.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                color: PRIMARY_COLOR_01,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: BodyText('${state.length}', color: PRIMARY_COLOR_04, textSize: BodyTextSize.SMALL),
                              ),
                            ),
                          ),
                        ],
                      )
                    )
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
    );
  }
}
