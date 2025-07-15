import 'package:flutter/material.dart';
import 'package:gu_pos/guide/login_screen.dart';
import 'package:gu_pos/app/order/view/order_status_screen.dart';
import 'package:gu_pos/guide/socket_test_screen.dart';

import 'app/order/view/order_screen.dart';

class StyleGuideScreen extends StatelessWidget {
  const StyleGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: ListView(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('로그인 화면',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500),),],),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text("로그인 화면"),
                ),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('주문',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500),),],),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const OrderScreen(),
                      ),
                    );
                  },
                  child: Text("주문 화면"),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const OrderStatusScreen(),
                      ),
                    );
                  },
                  child: Text("현황 화면"),
                ),
              )
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('소켓',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w500),),],),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SocketTestScreen(),
                      ),
                    );
                  },
                  child: Text("소켓 테스트 화면"),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
