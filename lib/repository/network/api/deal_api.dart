import 'package:dio/dio.dart';

class DealApi {
  final Dio _dio;

  DealApi(this._dio);

  Future<String> getDeals() async {
    try {
      var result = await _dio.post(
        'http://45.117.162.60:8080/sam-dashboard/api/deals/1/20?access_token=6fe8ad3be0de51f989b5b8830a77dc24d98da24b926c2ced3fb3fcc4469de306',
      );
      return result.data;
    } catch (ex) {
      throw ex;
    }
  }
}
