import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:tripStory/core/services/session_service.dart';

class CloudFrontHttpFileService extends HttpFileService {
  final SessionService _sessionService;

  CloudFrontHttpFileService(this._sessionService);

  @override
  Future<FileServiceResponse> get(String url, {Map<String, String>? headers}) async {
    final cookieHeader = await _sessionService.getCloudCookieHeader();

    final updatedHeaders = {
      HttpHeaders.cookieHeader: cookieHeader,
      if (headers != null) ...headers,
    };

    final request = http.Request("GET", Uri.parse(url));
    request.headers.addAll(updatedHeaders);

    final streamedResponse = await request.send();

    return HttpGetResponse(streamedResponse);
  }
}
