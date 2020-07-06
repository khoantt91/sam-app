import 'package:samapp/model/app_error.dart';
import 'package:samapp/model/constant.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/repository/firebase/firebase_storage_manager.dart';
import 'package:samapp/repository/local/common_storage/common_storage_manager.dart';
import 'package:samapp/repository/local/secure_storage/secure_storage_constant.dart';
import 'package:samapp/repository/local/secure_storage/secure_storage_manager.dart';
import 'package:samapp/repository/model/repository_result.dart';
import 'package:samapp/repository/model/repository_result_paging.dart';
import 'package:samapp/repository/network/network_api.dart';
import 'package:samapp/utils/log/log.dart';
import '../model/user.dart';

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
  Future<RepositoryResult<User, AppError>> login(String userName, String password, String fbToken, String os) async {
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
      await _firebaseStorageManager.insertOrUpdateUser(result.success);
      Log.i('\n- Store user & access token successfully\n- Store user info into FireStore successfully\n- UserId=${result.success.userId}');
    }
    return Future.value(result);
  }

  @override
  Future<RepositoryResult<Map<String, dynamic>, AppError>> logout(String os) async {
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
  Future<RepositoryResult<User, AppError>> getCurrentUser() async {
    try {
      final user = await _commonStorageManager.getCurrentUser();
      return RepositoryResult(user, null);
    } on Exception catch (ex) {
      return RepositoryResult(null, AppError(code: '-1', message: ex.toString()));
    }
  }

  @override
  Future<RepositoryResult<RepositoryResultPaging<Deal>, AppError>> getDeals({
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
  Future<RepositoryResult<RepositoryResultPaging<Listing>, AppError>> getListings({
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
  Future<RepositoryResult<RepositoryResultPaging<User>, AppError>> getUserChatList({User lastUser}) async {
    return _firebaseStorageManager.getAllUser(lastUser: lastUser);
  }

  @override
  Future<RepositoryResult<String, AppError>> getOrCreateChatRoomId(List<User> users) async {
    return _firebaseStorageManager.getOrCreateChatRoomId(users);
  }

  @override
  Future<RepositoryResult<dynamic, AppError>> insertMessage(Message message) async {
    return _firebaseStorageManager.insertMessage(message);
  }

  @override
  Future<RepositoryResult<RepositoryResultPaging<Message>, AppError>> getAllMessageInRoom(String chatRoomId, {Message lastMessage}) async {
    return _firebaseStorageManager.getAllMessageInRoom(chatRoomId, lastMessage: lastMessage);
  }
}

abstract class RepositoryImp {
  //region Authenticate
  Future<String> checkToken();

  Future<RepositoryResult<User, AppError>> login(String userName, String password, String fbToken, String os);

  Future<RepositoryResult<Map<String, dynamic>, AppError>> logout(String os);

  //endregion

  //region User
  Future<RepositoryResult<User, AppError>> getCurrentUser();

  Future<RepositoryResult<RepositoryResultPaging<User>, AppError>> getUserChatList({User lastUser});

  //endregion

  //region Chat
  Future<RepositoryResult<String, AppError>> getOrCreateChatRoomId(List<User> users);

  Future<RepositoryResult<dynamic, AppError>> insertMessage(Message message);

  Future<RepositoryResult<RepositoryResultPaging<Message>, AppError>> getAllMessageInRoom(String chatRoomId, {Message lastMessage});

  //endregion

  //region Deal
  Future<RepositoryResult<RepositoryResultPaging<Deal>, AppError>> getDeals({
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
  Future<RepositoryResult<RepositoryResultPaging<Listing>, AppError>> getListings({
    int fromDate,
    int toDate,
    List<ListingScorecardTypes> listingScorecardTypes,
    int page,
    int numberItem,
    String textSearch,
  });
//endregion
}
