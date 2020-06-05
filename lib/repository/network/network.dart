import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/user.dart';

class NetworkAPI {
  static Dio _dio;

  static Dio get _dioInstance {
    if (_dio == null) _initDio();
    return _dio;
  }

  static void _initDio() {
    final options = new BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
    );

    _dio = Dio(options);
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  static Future<User> login(Map<String, dynamic> params) async {
    try {
      var response = await _dioInstance.post('http://45.117.162.60:8080/sam-dashboard/api/users/sign-in', data: params);
      return User.fromJson(response.data['data'] as Map<String, dynamic>);
    } catch (ex) {
      throw ex;
    }
  }

  static Future<List<Deal>> getDeals(Map<String, dynamic> params) async {
    try {
      var response = await _dioInstance.post(
        'http://45.117.162.60:8080/sam-dashboard/api/deals/${params['page']}/${params['item']}?access_token=6fe8ad3be0de51f989b5b8830a77dc24d98da24b926c2ced3fb3fcc4469de306',
        data: params,
      );
      final jsonList = response.data['data']['list'] as List;
      final dealList = jsonList.map((dealJson) => Deal.fromJson(dealJson as Map<String, dynamic>)).toList();
      return dealList;
    } catch (ex) {
      throw ex;
    }
  }
}
