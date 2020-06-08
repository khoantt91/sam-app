class NetworkResultPaging<T> {
  List<T> list;
  int totalItems;
  int totalPages;

  NetworkResultPaging(this.list, this.totalItems, this.totalPages);
}
