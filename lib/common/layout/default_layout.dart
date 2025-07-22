import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/provider/order_status_provider.dart';
import 'package:gu_pos/app/order/view/order_status_screen.dart';
import 'package:gu_pos/app/order/view/order_screen.dart';

import '../../app/order/service/order_socket_service.dart';
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
  final OrderSocketService _orderSocketService = OrderSocketService();
  String? receivedMessage;
  late final Stream<String> _messageStream;

  @override
  void initState() {
    _orderSocketService.connect();
    _messageStream = _orderSocketService.messageStream;
    _messageStream.listen((message) {
      ref.watch(orderStatusProvider.notifier).reload();
      setState(() {
        receivedMessage = message;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _orderSocketService.disconnect();
    super.dispose();
  }

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
    return Container(
      height: 60,
      color: PRIMARY_COLOR_03,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 왼쪽: 아이콘
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.dehaze_sharp, color: PRIMARY_COLOR_04, size: 38),
              ),
            ),

            // 가운데: 주문 | 현황
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const OrderScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: BodyText('주문', textSize: BodyTextSize.MEDIUM, color: PRIMARY_COLOR_04),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: VerticalDivider(
                      width: 10,
                      thickness: 0.5,
                      color: TEXT_COLOR_04,
                    ),
                  ),
                  _buildOrderStatus(),
                ],
              ),
            ),

            // 오른쪽: 날짜
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: BodyText('7.1(화) 오후 5:07', textSize: BodyTextSize.REGULAR, color: PRIMARY_COLOR_04, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatus() {
    final state = ref.watch(orderStatusProvider);
    return state.when(
      loading: () => const CircularProgressIndicator(),
      error: (e, _) => const Text('에러'),
      data: (orders) {
        return InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const OrderStatusScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BodyText('현황',
                    textSize: BodyTextSize.MEDIUM,
                    color: TEXT_COLOR_04
                ),
                if(state.value!.isNotEmpty)
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
                        child: BodyText('${state.value!.length}', color: PRIMARY_COLOR_04, textSize: BodyTextSize.SMALL),
                      ),
                    ),
                  ),
              ],
            )
        );
      },
    );
  }
}
