import 'package:dio/dio.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/repository/network/api/base_api.dart';
import 'package:samapp/repository/network/model/network_error.dart';
import 'package:samapp/repository/network/model/network_result.dart';
import 'package:samapp/repository/network/model/network_result_paging.dart';

class DealApi {
  final Dio _dio;

  DealApi(this._dio);

  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals({
    String token,
    int fromDate,
    int toDate,
    List<ListingTypes> listingTypes,
    List<DealScorecardTypes> dealScorecardTypes,
    List<DealStatus> dealStatus,
    int page: 1,
    int numberItem: 20,
    String textSearch,
  }) async {
    try {
      final params = {
        "fromDate": fromDate,
        "listingTypes": listingTypes.map((e) => e.id).toList(),
        "scorecardTypes": dealScorecardTypes.map((e) => e.stringId).toList(),
        "toDate": toDate,
        "statusDeals": dealStatus.map((e) => e.id).toList(),
        "textSearch": textSearch
      };
      var result = await _dio.post(
        'deals/$page/$numberItem?access_token=$token',
        data: params,
      );
      return handleListResponse<Deal>(result);
    } on DioError catch (ex) {
      return handleException(ex);
    }
  }
}
