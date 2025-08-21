import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripStory/core/util/extension/bit_description_extension.dart';

/// 지도 마커 아이콘을 생성/캐시하는 서비스.
/// - 에셋 아이콘 로드 + 캐시
/// - 위젯을 오프스크린 렌더하여 BitmapDescriptor 생성 + 캐시
/// - 캐시는 LRU 방식으로 용량 제한 및 TTL 만료 지원
class _CacheEntry {
  _CacheEntry(this.icon) : lastUsed = DateTime.now();
  final BitmapDescriptor icon;
  final DateTime lastUsed;
}

class MarkerIconService {
  MarkerIconService({
    this.maxEntries = 64,
    this.timeToLive = const Duration(minutes: 30),
  });

  final int maxEntries;
  final Duration timeToLive;
  final _cache = <String, _CacheEntry>{};

  final _inFutureCache = <String, Future<BitmapDescriptor>>{};

  /// 만료된 이미지 제거하고 새로운 이미지로 교체
  BitmapDescriptor? _getFresh(String key) {
    final entry = _cache[key];
    if (entry == null) return null;

    final expired = DateTime.now().difference(entry.lastUsed) > timeToLive;
    if (expired) {
      _cache.remove(key);
      return null;
    }
    _cache.remove(key);
    _cache[key] = _CacheEntry(entry.icon);
    return entry.icon;
  }

  /// cached 된 이미지 저장
  BitmapDescriptor _save(String key, BitmapDescriptor icon) {
    if (_cache.length >= maxEntries && _cache.isNotEmpty) {
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = _CacheEntry(icon);
    return icon;
  }

  void removeCache(String key) {
    _cache.remove(key);
    _inFutureCache.remove(key);
  }

  Future<BitmapDescriptor> renderIconWithBuilder({
    required String cacheKey,
    required Widget Function() widget,
  }) async {
    final cached = _getFresh(cacheKey);
    if (cached != null) return cached;

    final icon = _inFutureCache.putIfAbsent(cacheKey, () async {
      final icon = await widget().toBitmapDescriptor(
        logicalSize: const Size(150, 150),
        imageSize: const Size(300, 300),
      );
      return _save(cacheKey, icon);
    });

    try {
      return await icon;
    } finally {
      _inFutureCache.remove(cacheKey);
    }
  }
}
