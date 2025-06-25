import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tripStory/util/models/country.dart';

class CountryFlagHelper {
  static final Set<String> _cachedUrls = {};

  /// 국가 이름 → 이미지 URL 맵
  static late final Map<String, String> _countryImageMap = {
    for (final region in countryRegions)
      for (final country in region.countries) country.name: country.image,
  };

  /// 국가 이름으로 이미지 URL 반환
  static String? getImageUrlByName(String name) => _countryImageMap[name];

  static Future<void> precacheAllRegions(BuildContext context) async {
    for (final region in countryRegions) {
      await precacheRegion(region, context);
    }
  }

  /// 특정 대륙의 국가 이미지 캐싱
  static Future<void> precacheRegion(
    CountryRegion region,
    BuildContext context,
  ) async {
    for (final country in region.countries) {
      await cacheImage(country.image, context);
    }
  }

  /// 단일 이미지 캐싱 (중복 제거)
  static Future<void> cacheImage(
    String url,
    BuildContext context,
  ) async {
    if (_cachedUrls.contains(url)) return;

    try {
      await precacheImage(CachedNetworkImageProvider(url), context);
      _cachedUrls.add(url);
    } catch (e) {
      debugPrint("Failed to precache $url: $e");
    }
  }
}
