import 'package:dio/dio.dart';
import 'package:samapp/repository/network/api/base_api.dart';
import 'package:samapp/repository/network/model/network_error.dart';
import 'package:samapp/repository/network/model/network_result.dart';

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
      return handleSingleResponse<User>(result);
    } on DioError catch (ex) {
      return handleException(ex);
    }
  }

  Future<NetworkResult<Map<String, dynamic>, NetworkError>> logout(String os, String fbToken, String acToken) async {
    try {
      final params = {
        "osName": os,
        "deviceToken": 'HelloFbToken',
      };
      var result = await _dio.post('users/sign-out?access_token=$acToken', data: params);
      return handleRawResponse(result);
    } on DioError catch (ex) {
      return handleException(ex);
    }
  }
}
