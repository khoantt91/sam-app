import 'package:samapp/repository/model/repository_result_paging.dart';

class NetworkResultPaging<T> extends RepositoryResultPaging<T> {
  NetworkResultPaging(List<T> list, int totalItems, int totalPages) : super(list, totalItems, totalPages);
}
