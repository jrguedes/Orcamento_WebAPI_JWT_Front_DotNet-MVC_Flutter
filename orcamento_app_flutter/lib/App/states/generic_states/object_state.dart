abstract class ObjectState<T> {}

class InitialObjectState<T> implements ObjectState<T> {
  final T value;
  InitialObjectState(this.value);
}

class SuccessObjectState<T> implements ObjectState<T> {
  final T value;
  SuccessObjectState(this.value);
}

class LoadingObjectState<T> implements ObjectState<T> {}

class ErrorObjectState<T> implements ObjectState<T> {
  final String message;
  ErrorObjectState(this.message);
}

class UnauthorizedObjectState<T> implements ObjectState<T> {
  final String message;
  UnauthorizedObjectState(this.message);
}
