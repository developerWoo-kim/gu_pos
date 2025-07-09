import 'package:flutter/material.dart';
import 'package:gu_pos/guide/order_status_screen.dart';
import 'package:gu_pos/guide/order_test_screen.dart';

import '../component/text/body_text.dart';
import '../const/colors.dart';

class DefaultLayout extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor ?? PRIMARY_COLOR_04,
      appBar: appBar,
      body: SizedBox.expand(
        child: Column(
          children: [
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
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const OrderTestScreen(),
                                  ),
                                );
                              },
                              child: BodyText('주문', textSize: BodyTextSize.LARGE, color: PRIMARY_COLOR_04)
                            ),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const OrderStatusScreen(),
                                  ),
                                );
                              },
                              child: BodyText('현황', textSize: BodyTextSize.LARGE, color: TEXT_COLOR_04),
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
            ),
            body
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
