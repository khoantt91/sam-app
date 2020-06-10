import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/repository/network/api/authenticate_api.dart';
import 'package:samapp/repository/network/api/deal_api.dart';
import 'package:samapp/repository/network/constant/network_config.dart';
import 'package:samapp/repository/network/model/network_error.dart';
import 'package:samapp/repository/network/model/network_result.dart';

import '../../model/user.dart';
import 'model/network_result_paging.dart';

class NetworkAPI implements NetworkImp {
  Dio _dio;
  AuthenticateAPI _authenticateAPI;
  DealApi _dealApi;

  NetworkAPI() {
    /* Config Dio */
    final options = BaseOptions(
      baseUrl: NetworkConfig.baseURL,
      connectTimeout: 60000,
      receiveTimeout: 60000,
    );

    _dio = Dio(options);

    /* Add log interceptor */

    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

    /* Init API */
    _authenticateAPI = AuthenticateAPI(_dio);
    _dealApi = DealApi(_dio);
  }

  @override
  Future<NetworkResult<User, NetworkError>> login(String userName, String password, String fbToken, String os) =>
      _authenticateAPI.login(userName, password, fbToken, os);

  @override
  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals(String token) => _dealApi.getDeals(token);
}

abstract class NetworkImp {
  //region Authenticate
  Future<NetworkResult<User, NetworkError>> login(String userName, String password, String fbToken, String os);

  //endregion

  //region Deal
  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals(String token);
  //endregion
}
