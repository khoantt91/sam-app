import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/model/message.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/repository/firebase/firebase_storage_constant.dart';
import 'package:samapp/repository/firebase/model/firebase_error.dart';
import 'package:samapp/repository/firebase/model/firebase_result.dart';
import 'package:samapp/repository/firebase/model/firebase_result_paging.dart';
import 'package:samapp/utils/log/log.dart';

class FirebaseStorageManager implements FirebaseStorageManagerImp {
  DocumentReference firebaseDb = Firestore.instance.collection(FirebaseStorageConstant.DATABASE_NAME).document(FirebaseStorageConstant.DATABASE_DEV);

  @override
  Future<FirebaseResult<dynamic, FirebaseError>> insertOrUpdateUser(User user) async {
    try {
      final userCollection = firebaseDb.collection(FirebaseStorageConstant.COLLECTION_USER);
      Map<String, dynamic> jsonUser = user.toJson();
      jsonUser['updatedAt'] = DateTime.now().millisecondsSinceEpoch;
      await userCollection.document(user.userId.toString()).setData(jsonUser, merge: true);
      return FirebaseResult(true, null);
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Future<FirebaseResult<dynamic, FirebaseError>> updateUserStatus(User user, String firebaseToken, bool isOnline) async {
    try {
      final firebaseTokenModel = firebaseDb
          .collection(FirebaseStorageConstant.COLLECTION_USER)
          .document(user.userId.toString())
          .collection(FirebaseStorageConstant.FIELD_FIREBASE_TOKENS)
          .document(firebaseToken);

      final documentRef = await firebaseTokenModel.get();
      if (documentRef != null && documentRef.data["isOnline"] == isOnline) return FirebaseResult(true, null);
      await firebaseTokenModel.setData({
        'isOnline': isOnline,
      }, merge: true);

      final userStatus = await getUserStatus(user);
      user.isOnline = userStatus.success;
      await insertOrUpdateUser(user);

      return FirebaseResult(true, null);
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Future<FirebaseResult<bool, FirebaseError>> getUserStatus(User user) async {
    try {
      final firebaseTokenModel = firebaseDb
          .collection(FirebaseStorageConstant.COLLECTION_USER)
          .document(user.userId.toString())
          .collection(FirebaseStorageConstant.FIELD_FIREBASE_TOKENS)
          .where('isOnline', isEqualTo: true);

      int totalDocuments = await _getTotalQuerySnapshot(firebaseTokenModel);
      return totalDocuments == 0 ? FirebaseResult(false, null) : FirebaseResult(true, null);
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Future<FirebaseResult<FirebaseResultPaging<String>, FirebaseError>> getUserFirebaseTokens(User user) async {
    try {
      final userCollection = firebaseDb
          .collection(FirebaseStorageConstant.COLLECTION_USER)
          .document(user.userId.toString())
          .collection(FirebaseStorageConstant.FIELD_FIREBASE_TOKENS);
      final querySnapshot = await userCollection.getDocuments();
      List<String> firebaseTokens = querySnapshot.documents.map((document) => document.documentID.toString()).toList();
      return FirebaseResult(FirebaseResultPaging<String>(firebaseTokens, null, null), null);
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Future<FirebaseResult<dynamic, FirebaseError>> insertUserFirebaseToken(User user, String firebaseToken) async {
    try {
      final userCollection = firebaseDb
          .collection(FirebaseStorageConstant.COLLECTION_USER)
          .document(user.userId.toString())
          .collection(FirebaseStorageConstant.FIELD_FIREBASE_TOKENS);
      await userCollection.document(firebaseToken).setData({'status': true});
      return FirebaseResult(true, null);
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Future<FirebaseResult<dynamic, FirebaseError>> deleteUserFirebaseToken(User user, String firebaseToken) async {
    try {
      final userCollection =
          firebaseDb.collection(FirebaseStorageConstant.COLLECTION_USER).document(user.userId.toString()).collection('firebaseTokens');
      await userCollection.document(firebaseToken).delete();
      return FirebaseResult(true, null);
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Future<FirebaseResult<FirebaseResultPaging<Message>, FirebaseError>> getAllMessageInRoom(String chatRoomId, {Message lastMessage}) async {
    try {
      Query collectionReference =
          firebaseDb.collection(FirebaseStorageConstant.COLLECTION_MESSAGE).where(FirebaseStorageConstant.FIELD_CHAT_ROOM_ID, isEqualTo: chatRoomId);
      int totalDocuments = await _getTotalQuerySnapshot(collectionReference);

      Query messageCollection = collectionReference.orderBy(FirebaseStorageConstant.FIELD_CREATED_AT, descending: true);
      if (lastMessage != null) {
        messageCollection = messageCollection.startAfter([lastMessage.createdAt]);
      }
      messageCollection = messageCollection.limit(FirebaseStorageConstant.LIMIT_QUERY);
      final querySnapshot = await messageCollection.getDocuments();
      List<Message> messageList = querySnapshot.documents.map((documentSnapshot) => parseDataSnapshot<Message>(documentSnapshot.data)).toList();

      return FirebaseResult(FirebaseResultPaging<Message>(messageList, totalDocuments, null), null);
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Future<FirebaseResult<FirebaseResultPaging<User>, FirebaseError>> getAllUser(User currentUser, {User lastUser}) async {
    try {
      CollectionReference collectionReference = firebaseDb.collection(FirebaseStorageConstant.COLLECTION_USER);

      int totalDocuments = await _getTotalQuerySnapshot(collectionReference);

      Query userCollection = collectionReference.orderBy(FirebaseStorageConstant.FIELD_USER_ID);
      if (lastUser != null) {
        userCollection = userCollection.startAfter([lastUser.userId]);
      }
      userCollection = userCollection.limit(FirebaseStorageConstant.LIMIT_QUERY);
      final querySnapshot = await userCollection.getDocuments();
      List<User> userList = querySnapshot.documents
          .where((element) => element.documentID.toString() != currentUser.userId.toString())
          .map((documentSnapshot) => parseDataSnapshot<User>(documentSnapshot.data))
          .toList();

      return FirebaseResult(FirebaseResultPaging<User>(userList, totalDocuments, null), null);
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Future<FirebaseResult<String, FirebaseError>> getOrCreateChatRoomId(List<User> users) async {
    try {
      final chatRoomCollection = firebaseDb.collection(FirebaseStorageConstant.COLLECTION_CHAT_ROOM);
      final query = chatRoomCollection.where(users[0].userId.toString(), isEqualTo: true).where(users[1].userId.toString(), isEqualTo: true);
      final snapshots = await query.getDocuments();

      if (snapshots.documents.length == 0) {
        final document = chatRoomCollection.document();
        await document.setData({users[0].userId.toString(): true, users[1].userId.toString(): true});
        return FirebaseResult(document.documentID, null);
      } else {
        return FirebaseResult(snapshots.documents[0].documentID, null);
      }
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Future<FirebaseResult<dynamic, FirebaseError>> insertMessage(Message message) async {
    try {
      final messageCollection = firebaseDb.collection(FirebaseStorageConstant.COLLECTION_MESSAGE);
      Map<String, dynamic> jsonMessage = message.toJson();
      final docRef = messageCollection.document();
      jsonMessage['messageId'] = docRef.documentID.toString();
      await docRef.setData(jsonMessage);
      return FirebaseResult(true, null);
    } on Exception catch (ex) {
      return FirebaseResult(null, FirebaseError(message: ex.toString()));
    }
  }

  @override
  Stream<FirebaseResult<User, FirebaseError>> observerUserList() {
    final userCollection = firebaseDb.collection(FirebaseStorageConstant.COLLECTION_USER);
    return userCollection.snapshots(includeMetadataChanges: true).where((querySnapshot) {
      if (querySnapshot.documentChanges.length != 1) return false;

      final documentChanged = querySnapshot.documentChanges[0];
      if (documentChanged.type == DocumentChangeType.modified) {
        return true;
      } else {
        return false;
      }
    }).map((querySnapshot) {
      Log.w('Changed=${querySnapshot.documentChanges[0].document.data}');
      final userModified = parseDataSnapshot<User>(querySnapshot.documentChanges[0].document.data);
      return FirebaseResult(userModified, null);
    });
  }

  @override
  Stream<FirebaseResult<Message, FirebaseError>> observerNewMessage(String chatRoomId) {
    final messageCollection =
        firebaseDb.collection(FirebaseStorageConstant.COLLECTION_MESSAGE).where(FirebaseStorageConstant.FIELD_CHAT_ROOM_ID, isEqualTo: chatRoomId);
    return messageCollection.snapshots().where((querySnapshot) {
      if (querySnapshot.documentChanges.length != 1) return false;

      final documentChanged = querySnapshot.documentChanges[0];
      if (documentChanged.type == DocumentChangeType.added) {
        return true;
      } else {
        return false;
      }
    }).map((querySnapshot) {
      final message = parseDataSnapshot<Message>(querySnapshot.documentChanges[0].document.data);
      return FirebaseResult(message, null);
    });
  }

  //region Private Support Methods
  S parseDataSnapshot<S>(Map<String, dynamic> json) {
    if (S == User) {
      return User.fromJson(json) as S;
    } else if (S == Deal) {
      return Deal.fromJson(json) as S;
    } else if (S == Listing) {
      return Listing.fromJson(json) as S;
    } else if (S == Message) {
      return Message.fromJson(json) as S;
    }
    return null;
  }

  List<S> parseDataSnapshotList<S>(Iterable<Map<String, dynamic>> jsonList) {
    final listModel = List<S>();
    jsonList.forEach((element) {
      if (S == User) {
        listModel.add(User.fromJson(element) as S);
      } else if (S == Deal) {
        listModel.add(Deal.fromJson(element) as S);
      } else if (S == Listing) {
        listModel.add(Listing.fromJson(element) as S);
      } else if (S == Message) {
        listModel.add(Message.fromJson(element) as S);
      }
    });
    return listModel;
  }

  Future<int> _getTotalQuerySnapshot(Query collectionReference) async {
    QuerySnapshot totalQuerySnapShot = await collectionReference.getDocuments();
    return totalQuerySnapShot.documents.length;
  }

//endregion

}

abstract class FirebaseStorageManagerImp {
  Future<FirebaseResult<dynamic, FirebaseError>> insertOrUpdateUser(User user);

  Future<FirebaseResult<dynamic, FirebaseError>> updateUserStatus(User user, String firebaseToken, bool isOnline);

  Stream<FirebaseResult<User, FirebaseError>> observerUserList();

  Future<FirebaseResult<bool, FirebaseError>> getUserStatus(User user);

  Future<FirebaseResult<FirebaseResultPaging<String>, FirebaseError>> getUserFirebaseTokens(User user);

  Future<FirebaseResult<dynamic, FirebaseError>> insertUserFirebaseToken(User user, String firebaseToken);

  Future<FirebaseResult<dynamic, FirebaseError>> deleteUserFirebaseToken(User user, String firebaseToken);

  Future<FirebaseResult<FirebaseResultPaging<User>, FirebaseError>> getAllUser(User currentUser, {User lastUser});

  Future<FirebaseResult<String, FirebaseError>> getOrCreateChatRoomId(List<User> users);

  Future<FirebaseResult<dynamic, FirebaseError>> insertMessage(Message message);

  Future<FirebaseResult<FirebaseResultPaging<Message>, FirebaseError>> getAllMessageInRoom(String chatRoomId, {Message lastMessage});

  Stream<FirebaseResult<Message, FirebaseError>> observerNewMessage(String chatRoomId);
}
