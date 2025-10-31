import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:retrofit/retrofit.dart';
import 'package:tripStory/core/constants/app_constants.dart';
import 'package:tripStory/data/models/response/version_response.dart';

part 'version_data_source.g.dart';

@RestApi(baseUrl: "/version")
abstract class VersionDataSource {
  factory VersionDataSource(Dio dio, {String baseUrl}) = _VersionDataSource;

  @GET("/last")
  Future<VersionResponse> fetchVersionLast();
}

abstract class VersionStoreDataSource {
  Future<String?> fetchStoreVersion();
}

class IOSVersionDataSource implements VersionStoreDataSource {
  @override
  Future<String?> fetchStoreVersion() async {
    try {
      final url = Uri.https(
        "itunes.apple.com",
        "/lookup",
        {
          "id": "6529530493",
          "country": "KR",
        },
      );

      final res = await http.get(url);

      final json = jsonDecode(res.body);
      final results = json["results"] as List?;
      if (results == null || results.isEmpty) return null;
      final version = results.first["version"] as String?;
      return version;
    } catch (e) {
      return null;
    }
  }
}

class AndroidVersionDataSource implements VersionStoreDataSource {
  @override
  Future<String?> fetchStoreVersion() async {
    try {
      final uri = Uri.https(
        "play.google.com",
        "/store/apps/details",
        {
          "id": AppConstants.bundleId,
          "hl": "en",
        },
      );

      final res = await http.get(uri);

      final document = parse(res.body);

      /// 구형 구조 (hAyfc)
      final legacyVersion = _parseLegacyVersion(document);
      if (legacyVersion != null) {
        return legacyVersion;
      }

      /// 신형 구조 (AF_initDataCallback)
      final newVersion = _parseNewVersion(document);
      if (newVersion != null) {
        return newVersion;
      }

      final regexVersion = RegExp(r'Current Version.*?>([\d.]+)<', dotAll: true).firstMatch(res.body)?.group(1);

      return regexVersion;
    } catch (e) {
      return null;
    }
  }

  // 구형 Play Store 구조
  String? _parseLegacyVersion(Document document) {
    try {
      final elements = document.getElementsByClassName('hAyfc');
      final versionElement = elements.firstWhere(
        (elm) => elm.querySelector('.BgcNfc')?.text == 'Current Version',
      );
      final version = versionElement.querySelector('.htlgb')?.text;
      return version?.trim();
    } catch (_) {
      return null;
    }
  }

  // 신형 Play Store 구조
  String? _parseNewVersion(Document document) {
    try {
      const patternVersion = ',[[["';
      const patternCallback = 'AF_initDataCallback';
      const patternEnd = '"';

      final scripts = document.getElementsByTagName("script");
      final script = scripts.firstWhere(
        (s) => s.text.contains(patternCallback) && s.text.contains(patternVersion),
        orElse: () => Element.tag('script'),
      );

      if (script.text.isEmpty) return null;

      final startIndex = script.text.lastIndexOf(patternVersion) + patternVersion.length;
      final endIndex = startIndex + script.text.substring(startIndex).indexOf(patternEnd);

      if (startIndex < 0 || endIndex <= startIndex) return null;

      final version = script.text.substring(startIndex, endIndex);
      return version.trim();
    } catch (_) {
      return null;
    }
  }
}
