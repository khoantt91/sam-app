import 'package:samapp/model/constant.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/repository/firebase/firebase_storage_manager.dart';
import 'package:samapp/repository/local/common_storage/common_storage_manager.dart';
import 'package:samapp/repository/local/secure_storage/secure_storage_constant.dart';
import 'package:samapp/repository/local/secure_storage/secure_storage_manager.dart';
import 'package:samapp/repository/network/network_api.dart';
import 'package:samapp/utils/log/log.dart';
import '../model/user.dart';
import 'network/model/network_error.dart';
import 'network/model/network_result.dart';
import 'network/model/network_result_paging.dart';

class Repository implements RepositoryImp {
  NetworkImp _networkApi;
  FirebaseStorageManagerImp _firebaseStorageManager;
  SecureStorageManagerImp _secureStorageManager;
  CommonStorageManagerImp _commonStorageManager;

  String _token;
  String _fbToken;

  Future<String> _getToken() async {
    _token = _token == null ? await _secureStorageManager.read(SecureStorageConstant.ACCESS_TOKEN) : _token;
    return Future.value(_token);
  }

  Future<String> _getFirebaseToken() async {
    _fbToken = _fbToken == null ? await _secureStorageManager.read(SecureStorageConstant.FIREBASE_TOKEN) : _fbToken;
    return Future.value(_fbToken);
  }

  Repository() {
    _networkApi = NetworkAPI();
    _firebaseStorageManager = FirebaseStorageManager();
    _secureStorageManager = SecureStorageManager();
    _commonStorageManager = CommonStorageManager();
  }

  @override
  Future<String> checkToken() => _getToken();

  @override
  Future<NetworkResult<User, NetworkError>> login(String userName, String password, String fbToken, String os) async {
    final result = await _networkApi.login(userName, password, fbToken, os);
    /* 1. Store user token in SecureStorage
    *  2. Store user info in CommonStorage
    *  3. Store user info in FireStore
    *  when user sign in successfully
    * */
    if (result.success != null) {
      final token = result.success.token;
      await _secureStorageManager.write(SecureStorageConstant.ACCESS_TOKEN, token);
      await _commonStorageManager.storeCurrentUser(result.success);
      await _firebaseStorageManager.insertOrUpdate(result.success);
      Log.i('\n- Store user & access token successfully\n- Store user info into FireStore successfully\n- UserId=${result.success.userId}');
    }
    return Future.value(result);
  }

  @override
  Future<NetworkResult<Map<String, dynamic>, NetworkError>> logout(String os) async {
    final fbToken = await _getFirebaseToken();
    final token = await _getToken();
    final result = await _networkApi.logout(token, fbToken, os);

    /* Delete all local current user data */
    if (result.success != null) {
      _token = null;
      _fbToken = null;
      await _secureStorageManager.deleteAll();
    }

    return Future.value(result);
  }

  @override
  Future<NetworkResult<User, NetworkError>> getCurrentUser() async {
    try {
      final user = await _commonStorageManager.getCurrentUser();
      return NetworkResult(user, null);
    } on Exception catch (ex) {
      return NetworkResult(null, NetworkError(code: '-1', message: ex.toString()));
    }
  }

  @override
  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals({
    int fromDate,
    int toDate,
    List<ListingTypes> listingTypes,
    List<DealScorecardTypes> dealScorecardTypes,
    List<DealStatus> dealStatus,
    int page,
    int numberItem,
    String textSearch,
  }) async {
    final token = await _getToken();
    return _networkApi.getDeals(
        token: token,
        fromDate: fromDate,
        toDate: toDate,
        listingTypes: listingTypes,
        dealScorecardTypes: dealScorecardTypes,
        dealStatus: dealStatus,
        page: page,
        numberItem: numberItem,
        textSearch: textSearch);
  }

  @override
  Future<NetworkResult<NetworkResultPaging<Listing>, NetworkError>> getListings({
    int fromDate,
    int toDate,
    List<ListingScorecardTypes> listingScorecardTypes,
    int page,
    int numberItem,
    String textSearch,
  }) async {
    final token = await _getToken();
    return _networkApi.getListings(
      token: token,
      fromDate: fromDate,
      toDate: toDate,
      listingScorecardTypes: listingScorecardTypes,
      page: page,
      numberItem: numberItem,
      textSearch: textSearch,
    );
  }

  @override
  Future<NetworkResult<NetworkResultPaging<User>, NetworkError>> getUserChatList({User lastUser}) async {
    final userFirebaseResponse = await _firebaseStorageManager.getAllUser(lastUser: lastUser);
    return NetworkResult(NetworkResultPaging(userFirebaseResponse.first, userFirebaseResponse.last, null), null);
  }
}

abstract class RepositoryImp {
  //region Authenticate
  Future<String> checkToken();

  Future<NetworkResult<User, NetworkError>> login(String userName, String password, String fbToken, String os);

  Future<NetworkResult<Map<String, dynamic>, NetworkError>> logout(String os);

  //endregion

  //region User
  Future<NetworkResult<User, NetworkError>> getCurrentUser();

  Future<NetworkResult<NetworkResultPaging<User>, NetworkError>> getUserChatList({User lastUser});

  //endregion

  //region Deal
  Future<NetworkResult<NetworkResultPaging<Deal>, NetworkError>> getDeals({
    int fromDate,
    int toDate,
    List<ListingTypes> listingTypes,
    List<DealScorecardTypes> dealScorecardTypes,
    List<DealStatus> dealStatus,
    int page,
    int numberItem,
    String textSearch,
  });

  //endregion

  //region Listing
  Future<NetworkResult<NetworkResultPaging<Listing>, NetworkError>> getListings({
    int fromDate,
    int toDate,
    List<ListingScorecardTypes> listingScorecardTypes,
    int page,
    int numberItem,
    String textSearch,
  });
//endregion
}
