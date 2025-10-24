import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelper {
  /// [routeName]은 값을 전달하고 싶은 대상 화면의 라우트 이름입니다.
  ///
  /// 예: A → B → C 구조에서,
  /// C에서 A로 돌아가며 A의 then 콜백에 값을 전달하고 싶을 때 사용합니다.
  ///
  /// ```dart
  /// RouteHelper.goBackToWithResult(Routes.a, someValue);
  /// ```
  /// 이 경우, A에서 `Get.toNamed(...).then(...)`을 통해 값을 받을 수 있습니다.
  static void goBackToWithResult(String routeName, dynamic result) {
    Get.until((route) => Get.currentRoute == routeName);
    Future.microtask(() => Get.back(result: result));
  }

  /// 모든 팝업(다이얼로그/바텀시트/스낵바 등) 닫기
  ///
  /// showGeneralDialog, Get.dialog 섞여 있어도 동작.
  static void closeAllOverlays() {
    final navigator = Get.key.currentState;
    if (navigator == null) return;
    navigator.popUntil((route) => route is! PopupRoute);
  }

  /// 모든 오버레이 닫고 지정 라우트로 push
  static Future<T?> closeOverlaysAndToNamed<T>(
    String routeName, {
    dynamic arguments,
    bool preventDuplicates = true,
  }) async {
    closeAllOverlays();
    await Future.microtask(() {});
    return Get.toNamed<T>(
      routeName,
      arguments: arguments,
      preventDuplicates: preventDuplicates,
    );
  }

  /// 모든 오버레이 닫고 뒤로 pop
  static void closeOverlaysAndPop<T>({T? result}) {
    closeAllOverlays();
    Future.microtask(() => Get.back(result: result));
  }

  /// 특정 라우트까지 뒤로 간 다음 새로운 페이지로 이동
  ///
  /// 예: A → B → C 구조에서,
  /// C에서 A까지 뒤로 간 다음 D로 이동하고 싶을 때 사용합니다.
  ///
  /// ```dart
  /// RouteHelper.popUntilAndToNamed(Routes.a, Routes.d, arguments: idList);
  /// ```
  ///
  static Future<T?> popAllUntilAndToNamed<T>(
    String keepRoute,
    String toRoute, {
    dynamic arguments,
  }) async {
    return Get.offNamedUntil<T>(
      toRoute,
      (route) => route.settings.name == keepRoute,
      arguments: arguments,
    );
  }

  static Future<T?> popAllUntilAndToNamed2<T>(
    String keepRoute,
    String toRoute, {
    dynamic arguments,
    VoidCallback? onReturn,
  }) async {
    final result = await Get.offNamedUntil<T>(
      toRoute,
      (route) => route.settings.name == keepRoute,
      arguments: arguments,
    );

    // D에서 돌아왔을 때 콜백 실행
    if (onReturn != null) {
      onReturn();
    }

    return result;
  }
}
