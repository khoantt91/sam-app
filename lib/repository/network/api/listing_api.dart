import 'package:dio/dio.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/repository/network/api/base_api.dart';
import 'package:samapp/repository/network/model/network_error.dart';
import 'package:samapp/repository/network/model/network_result.dart';
import 'package:samapp/repository/network/model/network_result_paging.dart';
import 'package:samapp/utils/log/log.dart';

class ListingApi {
  final Dio _dio;

  ListingApi(this._dio);

  Future<NetworkResult<NetworkResultPaging<Listing>, NetworkError>> getListings({
    String token,
    int fromDate,
    int toDate,
    List<ListingScorecardTypes> listingScorecardTypes,
    int page: 1,
    int numberItem: 20,
    String textSearch,
  }) async {
    try {
      final params = {
        "fromDate": fromDate,
        "scorecardTypes": listingScorecardTypes.map((e) => e.id).toList(),
        "toDate": toDate,
        "textSearch": textSearch,
        "minPrice": 100000000,
        "minSize": 5,
      };
      var result = await _dio.post(
        'seller/listings/$page/$numberItem?access_token=$token',
        data: params,
      );
      return handleListResponse<Listing>(result);
    } on DioError catch (ex) {
      return handleException(ex);
    }
  }
}
