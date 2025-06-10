class OneTimeEvent<T> {
  final T _value;
  bool _hasBeenConsumed = false;

  OneTimeEvent(this._value);

  T? consume() {
    if (_hasBeenConsumed) return null;
    _hasBeenConsumed = true;
    return _value;
  }

  bool get isConsumed => _hasBeenConsumed;
}
