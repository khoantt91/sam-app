class RepositoryResultPaging<T> {
  List<T> list;
  int totalItems;
  int totalPages;

  RepositoryResultPaging(this.list, this.totalItems, this.totalPages);
}