import 'package:samapp/model/deal.dart';
import 'package:samapp/repository/network/network_api.dart';

import '../model/user.dart';
import 'network/model/network_error.dart';
import 'network/model/network_result.dart';
import 'network/model/network_result_paging.dart';

class Repository implements RepositoryImp {
  NetworkImp _networkApi;

  Repository() {
    _networkApi = NetworkAPI();
  }

  @override
  Future<NetworkResult<User, NetworkError>> login(String userName, String password, String fbToken, String os) =>
      _networkApi.login(userName, password, fbToken, os);

  @override
  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals() => _networkApi.getDeals();
}

abstract class RepositoryImp {
  //region Authenticate
  Future<NetworkResult<User, NetworkError>> login(String userName, String password, String fbToken, String os);

  //endregion

  //region Deal
  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals();
//endregion

}
