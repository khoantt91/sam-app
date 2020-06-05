import 'package:samapp/repository/network/network_api.dart';

class Repository implements RepositoryImp {
  NetworkImp _networkApi;

  Repository() {
    _networkApi = NetworkAPI();
  }

  @override
  Future<String> login(String userName, String password, String fbToken, String os) => _networkApi.login(userName, password, fbToken, os);

  @override
  Future<String> getDeals() => _networkApi.getDeals();
}

abstract class RepositoryImp {
  //region Authenticate
  Future<String> login(String userName, String password, String fbToken, String os);

  //endregion

  //region Deal
  Future<String> getDeals();
//endregion

}
