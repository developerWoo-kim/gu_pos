import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:gu_pos/common/component/button/basic_button.dart';
import 'package:gu_pos/common/const/colors.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../common/layout/default_layout.dart';

class SocketTestScreen extends StatefulWidget {
  const SocketTestScreen({super.key});

  @override
  State<SocketTestScreen> createState() => _SocketTestScreenState();
}

class _SocketTestScreenState extends State<SocketTestScreen> {
  final String storeId = '123';
  late StompClient stompClient;
  String? receivedMessage;
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _connectStomp();
  }

  void _connectStomp() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/ws-stomp',
        onConnect: _onStompConnected,
        onWebSocketError: (dynamic error) => print('🔴 WebSocket error: $error'),
        onStompError: (frame) => print('🔴 STOMP error: ${frame.body}'),
        onDisconnect: (frame) => print('🔌 Disconnected'),
        onDebugMessage: (msg) => print('🐛 DEBUG: $msg'),
        reconnectDelay: const Duration(seconds: 5),
      ),
    );

    stompClient.activate();
  }

  void _onStompConnected(StompFrame frame) {
    print('✅ STOMP 연결 성공');

    stompClient.subscribe(
      destination: '/sub/store/$storeId',
      callback: (frame) async {
        if (frame.body != null) {
          print('💡 메시지 수신: ${frame.body}');
          setState(() {
            receivedMessage = frame.body;
          });
          await _startRepeatingSound();
        }
      },
    );
  }

  Future<void> _startRepeatingSound() async {
    if (isPlaying) return;
    isPlaying = true;

    await audioPlayer.setReleaseMode(ReleaseMode.loop); // 반복 재생
    await audioPlayer.play(AssetSource('sounds/order/order_alert.mp3')); // assets/sounds/alert.mp3
  }

  Future<void> _stopSound() async {
    await audioPlayer.stop();
    isPlaying = false;
  }


  @override
  void dispose() {
    stompClient.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Center(
        child: receivedMessage == null
          ? const Text('메시지를 기다리는 중...')
          : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '📦 수신한 메시지:\n$receivedMessage',
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 16,),
            InkWell(
              onTap: () {
                _stopSound();
              },
              child: BasicButton('접수', backgroundColor: PRIMARY_COLOR_01, textColor: PRIMARY_COLOR_04)
            )
          ],
        )
      ),
    );
  }
}
