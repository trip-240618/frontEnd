import 'dart:async';
import 'dart:ui';

class Throttle {
  final Duration delay;
  Timer? _timer;
  bool _canRun = true;

  Throttle({
    required this.delay,
  });

  void call(VoidCallback action) {
    if (!_canRun) return;

    _canRun = false;
    action();
    _timer = Timer(delay, () {
      _canRun = true;
    });
  }

  void cancel() {
    _timer?.cancel();
  }
}
