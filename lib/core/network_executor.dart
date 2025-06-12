import 'network_result.dart';

class NetworkExecutor {
  static Future<NetworkResult<T>> run<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return NetworkSuccess(result);
    } catch (e) {
      return NetworkFailure(e);
    }
  }
}
