class NetworkResult<S, E> {
  S success;
  E error;

  NetworkResult(this.success, this.error);
}
