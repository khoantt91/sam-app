import 'package:dio/dio.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/repository/network/api/base_api.dart';
import 'package:samapp/repository/network/model/network_error.dart';
import 'package:samapp/repository/network/model/network_result.dart';
import 'package:samapp/repository/network/model/network_result_paging.dart';

class DealApi {
  final Dio _dio;

  DealApi(this._dio);

  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals() async {
    try {
      final params = {
        "fromDate": 1588923522589,
        "listingTypes": [1, 2],
        "scorecardTypes": ["H2", "H1", "M2", "M1", "L1", "L0"],
        "toDate": 1591601922589,
        "statusDeals": [24, 25, 26, 29, 27, 28]
      };
      var result = await _dio.post(
        'deals/1/20?access_token=6fe8ad3be0de51f989b5b8830a77dc24d98da24b926c2ced3fb3fcc4469de306',
        data: params,
      );
      return handleListResponse<Deal>(result);
    } catch (ex) {
      throw ex;
    }
  }
}
