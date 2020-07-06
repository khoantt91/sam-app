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
  Future<FirebaseResult<FirebaseResultPaging<Message>, FirebaseError>> getAllMessageInRoom(String chatRoomId, {Message lastMessage}) async {
    try {
      Query collectionReference =
          firebaseDb.collection(FirebaseStorageConstant.COLLECTION_MESSAGE).where(FirebaseStorageConstant.FIELD_CHAT_ROOM_ID, isEqualTo: chatRoomId);
      int totalDocuments = await _getTotalQuerySnapshot(collectionReference);

      Query messageCollection = collectionReference.orderBy(FirebaseStorageConstant.FIELD_CREATED_AT);
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
  Future<FirebaseResult<FirebaseResultPaging<User>, FirebaseError>> getAllUser({User lastUser}) async {
    try {
      CollectionReference collectionReference = firebaseDb.collection(FirebaseStorageConstant.COLLECTION_USER);

      int totalDocuments = await _getTotalQuerySnapshot(collectionReference);

      Query userCollection = collectionReference.orderBy(FirebaseStorageConstant.FIELD_USER_ID);
      if (lastUser != null) {
        userCollection = userCollection.startAfter([lastUser.userId]);
      }
      userCollection = userCollection.limit(FirebaseStorageConstant.LIMIT_QUERY);
      final querySnapshot = await userCollection.getDocuments();
      List<User> userList = querySnapshot.documents.map((documentSnapshot) => parseDataSnapshot<User>(documentSnapshot.data)).toList();

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

  Future<FirebaseResult<FirebaseResultPaging<User>, FirebaseError>> getAllUser({User lastUser});

  Future<FirebaseResult<String, FirebaseError>> getOrCreateChatRoomId(List<User> users);

  Future<FirebaseResult<dynamic, FirebaseError>> insertMessage(Message message);

  Future<FirebaseResult<FirebaseResultPaging<Message>, FirebaseError>> getAllMessageInRoom(String chatRoomId, {Message lastMessage});
}
