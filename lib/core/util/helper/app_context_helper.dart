import 'package:flutter/material.dart';

class AppContext {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
}