abstract class ListState<T> {}

class InitialListState<T> implements ListState<T> {}

class SuccessListState<T> implements ListState<T> {
  final List<T> list;
  SuccessListState(this.list);
}

class LoadingListState<T> implements ListState<T> {}

class ErrorListState<T> implements ListState<T> {
  final String message;
  ErrorListState(this.message);
}
