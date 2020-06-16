import 'package:dio/dio.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/repository/network/model/network_error.dart';
import 'package:samapp/repository/network/model/network_reponse.dart';
import 'package:samapp/repository/network/model/network_result.dart';
import 'package:samapp/repository/network/model/network_result_paging.dart';

Type typeOf<T>() => T;

/// Handle single object from response
NetworkResult<T, NetworkError> handleSingleResponse<T>(Response<dynamic> result) {
  final networkResponse = NetworkResponse.fromJson(result.data as Map<String, dynamic>);

  /* Get data model from response */
  if (!_parseDataModelResponse(networkResponse, result)) {
    return NetworkResult(
        null,
        NetworkError(
          code: NetworkError.ERROR_CODE_UNKNOWN,
          message: 'Unknown type of data = ${result.data['data'].toString()}',
        ));
  }

  /* Handle Error */
  if (networkResponse.code != '200') {
    return NetworkResult(null, NetworkError(code: networkResponse.code, message: networkResponse.message));
  }

  /* Handle Success */
  if (T == User) {
    return NetworkResult(User.fromJson(networkResponse.data) as T, null);
  } else if (T == Deal) {
    return NetworkResult(Deal.fromJson(networkResponse.data) as T, null);
  } else if (T == Listing) {
    return NetworkResult(Listing.fromJson(networkResponse.data) as T, null);
  } else
    return NetworkResult(null, NetworkError(code: NetworkError.ERROR_CODE_PARSING, message: 'Unknown this model ????'));
}

/// Handle list object from response
NetworkResult<NetworkResultPaging<S>, NetworkError> handleListResponse<S>(Response<dynamic> result) {
  final networkResponse = NetworkResponse.fromJson(result.data as Map<String, dynamic>);

  /* Get data model from response */
  if (!_parseDataModelResponse(networkResponse, result)) {
    return NetworkResult(
        null,
        NetworkError(
          code: NetworkError.ERROR_CODE_UNKNOWN,
          message: 'Unknown type of data = ${result.data['data'].toString()}',
        ));
  }

  /* Handle Error */
  if (networkResponse.code != '200') {
    return NetworkResult(null, NetworkError(code: networkResponse.code, message: networkResponse.message));
  }

  /* Handle Success */
  final totalItem = networkResponse.data['totalItems'];
  final totalPage = networkResponse.data['totalPages'];

  final listModel = List<S>();
  (networkResponse.data['list'] as List).forEach((element) {
    if (S == User) {
      listModel.add(User.fromJson(element) as S);
    } else if (S == Deal) {
      listModel.add(Deal.fromJson(element) as S);
    } else if (S == Listing) {
      listModel.add(Listing.fromJson(element) as S);
    }
  });

  final networkResultPaging = NetworkResultPaging<S>(listModel, totalItem, totalPage);
  return NetworkResult(networkResultPaging, null);
}

/// Handle raw response
NetworkResult<Map<String, dynamic>, NetworkError> handleRawResponse(Response<dynamic> result) {
  final networkResponse = NetworkResponse.fromJson(result.data as Map<String, dynamic>);

  /* Get data model from response */
  if (!_parseDataModelResponse(networkResponse, result)) {
    return NetworkResult(
        null,
        NetworkError(
          code: NetworkError.ERROR_CODE_UNKNOWN,
          message: 'Unknown type of data = ${result.data['data'].toString()}',
        ));
  }

  /* Handle Error */
  if (networkResponse.code != '200') {
    return NetworkResult(null, NetworkError(code: networkResponse.code, message: networkResponse.message));
  }

  /* Handle Success */
  return NetworkResult(networkResponse.toJson(), null);
}

/// Handle exception
NetworkResult<T, NetworkError> handleException<T>(DioError ex) {
  return NetworkResult(null, NetworkError(code: ex.response?.statusCode?.toString() ?? '500', message: ex.message.toString()));
}

//region Private Support Methods
bool _parseDataModelResponse(NetworkResponse networkResponse, Response<dynamic> result) {
  if (result.data['data'] is Map<String, dynamic>) {
    networkResponse.data = result.data['data'];
    return true;
  } else if (result.data['data'] is List) {
    networkResponse.dataArr = result.data['data'];
    return true;
  } else {
    return false;
  }
}
//endregion
