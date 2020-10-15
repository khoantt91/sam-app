import 'package:samapp/main.dart';
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
  User _currentUser;

  Future<String> _getToken() async {
    _token = _token == null ? await _secureStorageManager.read(SecureStorageConstant.ACCESS_TOKEN) : _token;
    return Future.value(_token);
  }

  Future<String> _getFirebaseToken() async {
    _fbToken = _fbToken == null ? await _secureStorageManager.read(SecureStorageConstant.FIREBASE_TOKEN) : _fbToken;
    return Future.value(_fbToken);
  }

  Future<User> _getCurrentUser() async {
    if (_currentUser == null) {
      final result = await getCurrentUser();
      _currentUser = result.success;
    }
    return Future.value(_currentUser);
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
    *  4. Store firebase token into user info
    *  when user sign in successfully
    * */
    if (result.success != null) {
      final token = result.success.token;
      final firebaseToken = await firebaseMessaging.getToken();
      await _secureStorageManager.write(SecureStorageConstant.ACCESS_TOKEN, token);
      await _secureStorageManager.write(SecureStorageConstant.FIREBASE_TOKEN, firebaseToken);
      await _commonStorageManager.storeCurrentUser(result.success);
      await _firebaseStorageManager.insertOrUpdateUser(result.success);
      await _firebaseStorageManager.insertUserFirebaseToken(result.success, firebaseToken);

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
      final currentUserResult = await getCurrentUser();
      await _firebaseStorageManager.deleteUserFirebaseToken(currentUserResult.success, await firebaseMessaging.getToken());

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
  Future<RepositoryResult<RepositoryResultPaging<User>, AppError>> getUserChatList(User user, {User lastUser}) async {
    return _firebaseStorageManager.getAllUser(user, lastUser: lastUser);
  }

  @override
  Future<RepositoryResult<RepositoryResultPaging<User>, AppError>> getRecentlyUserChatList(User currentUser, int limit, {User lastUser}) async {
    return _firebaseStorageManager.getRecentlyUser(currentUser, limit);
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

  @override
  Stream<RepositoryResult<Message, AppError>> observerNewMessage(String chatRoomId) {
    return _firebaseStorageManager.observerNewMessage(chatRoomId);
  }

  @override
  Future<RepositoryResult<RepositoryResultPaging<String>, AppError>> getUserFirebaseTokens(User user) async {
    return _firebaseStorageManager.getUserFirebaseTokens(user);
  }

  @override
  Future<RepositoryResult<dynamic, AppError>> updateCurrentUserStatus(bool isOnline) async {
    final currentUser = await _getCurrentUser();
    final firebaseToken = await _getFirebaseToken();
    return _firebaseStorageManager.updateUserStatus(currentUser, firebaseToken, isOnline);
  }

  @override
  Stream<RepositoryResult<User, AppError>> observerUserList() {
    return _firebaseStorageManager.observerUserList();
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

  Future<RepositoryResult<dynamic, AppError>> updateCurrentUserStatus(bool isOnline);

  Future<RepositoryResult<RepositoryResultPaging<User>, AppError>> getUserChatList(User user, {User lastUser});

  Future<RepositoryResult<RepositoryResultPaging<User>, AppError>> getRecentlyUserChatList(User currentUser, int limit, {User lastUser});

  Future<RepositoryResult<RepositoryResultPaging<String>, AppError>> getUserFirebaseTokens(User user);

  Stream<RepositoryResult<User, AppError>> observerUserList();

  //endregion

  //region Chat
  Future<RepositoryResult<String, AppError>> getOrCreateChatRoomId(List<User> users);

  Future<RepositoryResult<dynamic, AppError>> insertMessage(Message message);

  Future<RepositoryResult<RepositoryResultPaging<Message>, AppError>> getAllMessageInRoom(String chatRoomId, {Message lastMessage});

  Stream<RepositoryResult<Message, AppError>> observerNewMessage(String chatRoomId);

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
