sealed class NetworkResult<T> {
  const NetworkResult();

  R fold<R>(
    R Function(Object error) onFailure,
    R Function(T data) onSuccess,
  );

  T? get requireOrNull => this is NetworkSuccess<T> ? (this as NetworkSuccess<T>).data : null;
}

class NetworkSuccess<T> extends NetworkResult<T> {
  final T data;

  const NetworkSuccess(this.data);

  @override
  R fold<R>(
    R Function(Object error) onFailure,
    R Function(T data) onSuccess,
  ) =>
      onSuccess(data);
}

class NetworkFailure<T> extends NetworkResult<T> {
  final Object error;

  const NetworkFailure(this.error);

  @override
  R fold<R>(
    R Function(Object error) onFailure,
    R Function(T data) onSuccess,
  ) =>
      onFailure(error);
}
