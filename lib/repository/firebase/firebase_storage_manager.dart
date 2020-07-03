import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:samapp/generated/i18n.dart';
import 'package:samapp/model/deal.dart';
import 'package:samapp/model/listing.dart';
import 'package:samapp/model/pair.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/repository/firebase/firebase_storage_constant.dart';

class FirebaseStorageManager implements FirebaseStorageManagerImp {
  DocumentReference firebaseDb = Firestore.instance.collection(FirebaseStorageConstant.DATABASE_NAME).document(FirebaseStorageConstant.DATABASE_DEV);

  @override
  Future<dynamic> insertOrUpdate(User user) async {
    final userCollection = firebaseDb.collection(FirebaseStorageConstant.COLLECTION_USER);
    Map<String, dynamic> jsonUser = user.toJson();
    jsonUser['updatedAt'] = DateTime.now().millisecondsSinceEpoch;
    return userCollection.document(user.userId.toString()).setData(jsonUser);
  }

  @override
  Future<Pair<List<User>, int>> getAllUser({User lastUser}) async {
    CollectionReference collectionReference = firebaseDb.collection(FirebaseStorageConstant.COLLECTION_USER);

    int totalDocuments = await _getTotalQuerySnapshot(collectionReference);

    Query userCollection = collectionReference.orderBy(FirebaseStorageConstant.FIELD_USER_ID);
    if (lastUser != null) {
      userCollection = userCollection.startAfter([lastUser.userId]);
    }
    userCollection = userCollection.limit(FirebaseStorageConstant.LIMIT_QUERY);
    final querySnapshot = await userCollection.getDocuments();
    List<User> userList = querySnapshot.documents.map((documentSnapshot) => parseDataSnapshot<User>(documentSnapshot.data));
    return Pair(userList, totalDocuments);
  }

  //region Private Support Methods
  S parseDataSnapshot<S>(Map<String, dynamic> json) {
    if (S == User) {
      return User.fromJson(json) as S;
    } else if (S == Deal) {
      return Deal.fromJson(json) as S;
    } else if (S == Listing) {
      return Listing.fromJson(json) as S;
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
      }
    });
    return listModel;
  }

  Future<int> _getTotalQuerySnapshot(CollectionReference collectionReference) async {
    QuerySnapshot totalQuerySnapShot = await collectionReference.getDocuments();
    return totalQuerySnapShot.documents.length;
  }
//endregion

}

abstract class FirebaseStorageManagerImp {
  Future<dynamic> insertOrUpdate(User user);

  /// *
  /// First: current item list
  /// Second: total item in FireStore
  Future<Pair<List<User>, int>> getAllUser({User lastUser});
}
