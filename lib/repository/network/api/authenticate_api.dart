import 'package:dio/dio.dart';
import 'package:samapp/utils/log/log.dart';

class AuthenticateAPI {
  final Dio _dio;

  AuthenticateAPI(this._dio);

  Future<String> login(String userName, String password, String fbToken, String os) async {
    try {
      final params = {
        "userName": userName,
        "password": password,
        "osName": os,
        "deviceToken": fbToken,
      };
      var result = await _dio.post('http://45.117.162.60:8080/sam-dashboard/api/users/sign-in', data: params);
      return result.data;
    } catch (ex) {
      throw ex;
    }
  }
}
