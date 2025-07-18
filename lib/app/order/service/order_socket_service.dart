import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class OrderSocketService {
  static final OrderSocketService _instance = OrderSocketService._internal();
  factory OrderSocketService() => _instance;
  OrderSocketService._internal();

  final String storeId = '123';
  late StompClient _stompClient;
  final _controller = StreamController<String>.broadcast();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  Stream<String> get messageStream => _controller.stream;

  void connect() {
    _stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/ws-stomp',
        onConnect: _onConnect,
        onWebSocketError: (error) => print('🔴 WebSocket error: $error'),
        onStompError: (frame) => print('🔴 STOMP error: ${frame.body}'),
        onDisconnect: (_) => print('🔌 Disconnected'),
        onDebugMessage: (msg) => print('🐛 DEBUG: $msg'),
        reconnectDelay: const Duration(seconds: 5),
      ),
    );
    _stompClient.activate();
  }

  void _onConnect(StompFrame frame) {
    print('✅ STOMP 연결 성공');

    _stompClient.subscribe(
      destination: '/sub/store/$storeId',
      callback: (frame) async {
        final message = frame.body;
        if (message != null) {
          print('💡 메시지 수신: $message');
          _controller.add(message);
          await _startSound();
        }
      },
    );
  }

  Future<void> _startSound() async {
    if (_isPlaying) return;
    _isPlaying = true;
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('sounds/order/order_alert.mp3'));
  }

  Future<void> stopSound() async {
    await _audioPlayer.stop();
    _isPlaying = false;
  }

  void disconnect() {
    _stompClient.deactivate();
  }

  void dispose() {
    _controller.close();
  }
}