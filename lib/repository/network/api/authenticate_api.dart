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
    } catch (ex) {
      throw ex;
    }
  }
}
