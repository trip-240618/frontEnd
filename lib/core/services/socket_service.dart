import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tripStory/core/services/session_service.dart';

class SocketService extends GetxService {
  final SessionService _sessionService;
  late StompClient _stompClient;
  bool _isConnected = false;

  SocketService(
    this._sessionService,
  );

  Future<void> connect({
    required int tripId,
  }) async {
    if (_isConnected) return;
    final tokens = await _sessionService.getTokens();
    final accessToken = tokens["accessToken"] ?? "";
    final refreshToken = tokens["refreshToken"] ?? "";

    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'https://tripstory.shop/ws',
        onConnect: (frame) {
          _isConnected = true;
          print("연결됨 ${accessToken}");
          print("연결됨 ${refreshToken}");
        },
        webSocketConnectHeaders: {
          HttpHeaders.cookieHeader: '$accessToken;$refreshToken',
        },
        onWebSocketError: (error) {
          print("연결됨 ${accessToken}");
          print("연결됨 ${refreshToken}");
          print('Socket error: $error');
          _stompClient.deactivate();
          _isConnected = false;
        },
        onDisconnect: (_) {
          print('Socket disconnected');
          _isConnected = false;
        },
      ),
    );

    _stompClient.activate();
  }

  void disconnect() {
    _stompClient.deactivate();
    _isConnected = false;
  }

  void send(String destination, {String? body}) {
    _stompClient.send(destination: destination, body: body);
  }

  void subscribe(String destination, void Function(Map<String, dynamic>) onData) {
    _stompClient.subscribe(
      destination: destination,
      callback: (frame) {
        final data = json.decode(frame.body!);
        onData(data);
      },
    );
  }

  bool get isConnected => _isConnected;
}
