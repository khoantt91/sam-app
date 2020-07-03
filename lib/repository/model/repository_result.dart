class RepositoryResult<S, E> {
  S success;
  E error;

  RepositoryResult(this.success, this.error);
}
