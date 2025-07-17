import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tripStory/core/constants/app_constants.dart';
import 'package:tripStory/core/services/session_service.dart';

class SocketService extends GetxService {
  final SessionService _sessionService;
  late StompClient _stompClient;
  bool _isConnected = false;

  final StreamController<Map<String, dynamic>> _messageStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  SocketService(this._sessionService);

  Stream<Map<String, dynamic>> get messageStream => _messageStreamController.stream;

  bool get isConnected => _isConnected;

  Future<void> connect({
    required int tripId,
  }) async {
    if (_isConnected) return;
    final tokens = await _sessionService.getTokens();
    final accessToken = tokens["accessToken"] ?? "";
    final refreshToken = tokens["refreshToken"] ?? "";

    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: AppConstants.socketUrl,
        reconnectDelay: Duration.zero,
        onConnect: (frame) {
          _isConnected = true;
          print("소켓 연결됨 ✅");
        },
        webSocketConnectHeaders: {
          HttpHeaders.cookieHeader: '$accessToken;$refreshToken',
        },
        onWebSocketError: (error) {
          print("error??111 ${error}");
          _stompClient.deactivate();
          _isConnected = false;
        },
        onDisconnect: (_) {
          print("error??222 ${_}");
          _isConnected = false;
        },
      ),
    );

    _stompClient.activate();
  }

  void disconnect() {
    _stompClient.deactivate();
    _isConnected = false;
    _messageStreamController.close();
  }

  void send(String destination, {String? body}) {
    if (_isConnected) {
      _stompClient.send(destination: destination, body: body);
    }
  }

  void subscribe(String destination) {
    _stompClient.subscribe(
      destination: destination,
      callback: (frame) {
        final data = json.decode(frame.body!);
        _messageStreamController.add(data);
      },
    );
  }

  @override
  void onClose() {
    _messageStreamController.close();
    super.onClose();
  }
}
