import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tripStory/constants/country.dart';

class CountryFlagCacheManager {
  static final Set<String> _cachedUrls = {};

  /// 모든 국가 국기 이미지를 캐싱
  static Future<void> precacheAll(BuildContext context) async {
    for (final region in countryRegions) {
      await precacheRegion(
        region,
        context,
      );
    }
  }

  /// 특정 대륙만 캐싱
  static Future<void> precacheRegion(
    CountryRegion region,
    BuildContext context,
  ) async {
    for (final country in region.countries) {
      await _cacheImage(
        country.image,
        context,
      );
    }
  }

  /// 단일 이미지 캐싱 (중복 제거)
  static Future<void> _cacheImage(
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
