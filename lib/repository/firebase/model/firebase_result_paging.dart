import 'package:samapp/repository/model/repository_result_paging.dart';

class FirebaseResultPaging<T> extends RepositoryResultPaging<T> {
  FirebaseResultPaging(List<T> list, int totalItems, int totalPages) : super(list, totalItems, totalPages);
}
