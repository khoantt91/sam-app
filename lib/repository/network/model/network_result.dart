import 'package:samapp/repository/model/repository_result.dart';

class NetworkResult<S, E> extends RepositoryResult<S, E> {
  NetworkResult(S success, E error) : super(success, error);
}
