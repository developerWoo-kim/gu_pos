import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gu_pos/app/order/model/order_model.dart';
import 'package:gu_pos/app/order/provider/order_status_provider.dart';
import 'package:gu_pos/app/order/view/order_status_screen.dart';
import 'package:gu_pos/app/order/view/order_screen.dart';
import 'package:gu_pos/common/component/button/basic_button_v2.dart';
import 'package:gu_pos/common/component/button/hover_button.dart';
import 'package:gu_pos/common/layout/side_menu.dart';

import '../../app/order/service/order_socket_service.dart';
import '../component/text/body_text.dart';
import '../const/colors.dart';

class DefaultLayout extends ConsumerStatefulWidget {
  final AppBar? appBar;
  final Widget body;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final int selectedTapIndex;

  const DefaultLayout({super.key,
      this.appBar,
      required this.body,
      this.backgroundColor,
      this.bottomNavigationBar,
      this.selectedTapIndex = 0,
    });

  @override
  ConsumerState<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends ConsumerState<DefaultLayout> {
  final OrderSocketService _orderSocketService = OrderSocketService();
  String? receivedMessage;
  late final Stream<String> _messageStream;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
      extendBody: true,
      backgroundColor: widget.backgroundColor ?? PRIMARY_COLOR_04,
      appBar: widget.appBar,
      drawer: Drawer(
        backgroundColor: PRIMARY_COLOR_04,
        width: 610,
        shape: const RoundedRectangleBorder(),
        child: _buildDrawerContent(),
      ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      child: InkWell(
                        onTap: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.menu_sharp, color: PRIMARY_COLOR_04, size: 34),
                        ),
                      ),
                    )
                  ],
                )
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
                    child: BodyText('주문',
                        textSize: BodyTextSize.MEDIUM,
                        color: widget.selectedTapIndex == 0 ? PRIMARY_COLOR_04 : TEXT_COLOR_04
                    ),
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
        final orderState = state.value ?? [];
        final inProgressCount = orderState.where((e) => e.orderStatus == OrderStatus.PROGRESS).toList().length;
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
                    color: widget.selectedTapIndex == 1 ? PRIMARY_COLOR_04 : TEXT_COLOR_04
                ),
                if(inProgressCount > 0)
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
                        child: BodyText('$inProgressCount', color: PRIMARY_COLOR_04, textSize: BodyTextSize.SMALL),
                      ),
                    ),
                  ),
              ],
            )
        );
      },
    );
  }
  
  Widget _buildDrawerContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.close_sharp, size: 26, color: COLOR_6e7784,),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    BodyText('아침이 맑은 카페', color: BODY_TEXT_COLOR_02, textSize: BodyTextSize.HUGE_HALF, fontWeight: FontWeight.w500,),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 16,)
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30,),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight
                    ),
                    child: const IntrinsicHeight(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: SideMenu()
                      ),
                    ),
                  ),
                );
              }
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                    child: BasicButtonV2(
                        text: BodyText('돈통 열기',
                          textSize: BodyTextSize.REGULAR_HALF,
                          color: TEXT_COLOR_05,
                        ),
                        backgroundColor: COLOR_f3f4f6
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
