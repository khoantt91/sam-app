import 'package:dio/dio.dart';
import 'package:samapp/repository/network/model/network_error.dart';
import 'package:samapp/repository/network/model/network_reponse.dart';
import 'package:samapp/repository/network/model/network_result.dart';
import '../../../model/deal.dart';
import '../../../model/user.dart';

class AuthenticateAPI {
  final Dio _dio;

  AuthenticateAPI(this._dio);

  Future<NetworkResult<User, NetworkError>> login(String userName, String password, String fbToken, String os) async {
    try {
      final params = {
        "userName": userName,
        "password": password,
        "osName": os,
        "deviceToken": fbToken,
      };
      var result = await _dio.post('users/sign-in', data: params);
      final networkResponse = NetworkResponse.fromJson(result.data as Map<String, dynamic>);
      if (result.data['data'] is Map<String, dynamic>) networkResponse.data = result.data['data'];
      return handleSingleNetworkResponse<User>(networkResponse);
    } catch (ex) {
      throw ex;
    }
  }

  NetworkResult<S, NetworkError> handleSingleNetworkResponse<S>(NetworkResponse networkResponse) {
    /* Handle Error */
    if (networkResponse.code != '200') {
      return NetworkResult(null, NetworkError(code: networkResponse.code, message: networkResponse.message));
    }

    /* Handle Success */
    if (S is User) {
      return NetworkResult(User.fromJson(networkResponse.data) as S, null);
    } else if (S is Deal) {
      return NetworkResult(Deal.fromJson(networkResponse.data) as S, null);
    } else
      return NetworkResult(null, null);
  }

  NetworkResult<S, NetworkError> handleListNetworkResponse<S>(NetworkResponse networkResponse) {
    /* Handle Error */
    if (networkResponse.code != '200') {
      return NetworkResult(null, NetworkError(code: networkResponse.code, message: networkResponse.message));
    }

    /* Handle Success */
    if (S is User) {
      return NetworkResult(User.fromJson(networkResponse.data) as S, null);
    } else if (S is Deal) {
      return NetworkResult(Deal.fromJson(networkResponse.data) as S, null);
    } else
      return NetworkResult(null, null);
  }

  NetworkResult<Map<String, dynamic>, NetworkError> handleRawNetworkResponse(NetworkResponse networkResponse) {
    /* Handle Error */
    if (networkResponse.code != '200') {
      return NetworkResult(null, NetworkError(code: networkResponse.code, message: networkResponse.message));
    }

    /* Handle Success */
    return NetworkResult(networkResponse.data, null);
  }
}
