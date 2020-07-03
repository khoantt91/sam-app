import 'package:samapp/repository/model/repository_result.dart';

class FirebaseResult<S, E> extends RepositoryResult<S, E> {
  FirebaseResult(S success, E error) : super(success, error);
}
