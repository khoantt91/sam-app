import 'package:samapp/model/deal.dart';
import 'package:samapp/repository/local/secure_storage/secure_storage_constant.dart';
import 'package:samapp/repository/local/secure_storage/secure_storage_manager.dart';
import 'package:samapp/repository/network/network_api.dart';
import 'package:samapp/utils/log/log.dart';

import '../model/user.dart';
import 'network/model/network_error.dart';
import 'network/model/network_result.dart';
import 'network/model/network_result_paging.dart';

class Repository implements RepositoryImp {
  NetworkImp _networkApi;
  SecureStorageManagerImp _secureStorageManager;
  String _token;

  Future<String> _getToken() async {
    return _token != null ? Future.value(_token) : _secureStorageManager.read(SecureStorageConstant.ACCESS_TOKEN);
  }

  Repository() {
    _networkApi = NetworkAPI();
    _secureStorageManager = SecureStorageManager();
  }

  @override
  Future<NetworkResult<User, NetworkError>> login(String userName, String password, String fbToken, String os) async {
    final result = await _networkApi.login(userName, password, fbToken, os);
    /* Store user token in SecureStorage when user sign in successfully */
    if (result.success != null) {
      final token = result.success.token;
      await _secureStorageManager.write(SecureStorageConstant.ACCESS_TOKEN, token);
      Log.i('Store access token successfully');
    }
    return Future.value(result);
  }

  @override
  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals() async {
    final token = await _getToken();
    return _networkApi.getDeals(token);
  }
}

abstract class RepositoryImp {
  //region Authenticate
  Future<NetworkResult<User, NetworkError>> login(String userName, String password, String fbToken, String os);

  //endregion

  //region Deal
  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals();
//endregion

}
