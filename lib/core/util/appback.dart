import 'dart:ui';

import 'package:flutter/material.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => const {...PointerDeviceKind.values};
}

class MyPageRoute<T> extends MaterialPageRoute<T> {
  MyPageRoute({required super.builder});

  @override
  RoutePopDisposition get popDisposition {
    if (willHandlePopInternally) {
      return RoutePopDisposition.pop;
    }

    return isFirst ? RoutePopDisposition.bubble : RoutePopDisposition.pop;
  }
}