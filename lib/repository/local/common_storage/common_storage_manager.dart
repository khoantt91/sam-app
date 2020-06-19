import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samapp/model/user.dart';
import 'package:samapp/repository/local/common_storage/common_storage_constant.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart' as path;

class CommonStorageManager implements CommonStorageManagerImp {
  DatabaseFactory _dbFactory = databaseFactoryIo;
  Database _database;

  var mainStore = StoreRef.main();

  Future<Database> _getDatabase() async {
    /* Check database instance & open it */
    _database = _database == null ? await _openDatabase() : _database;
    return Future.value(_database);
  }

  Future<Database> _openDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var dbPath = path.join(dir.path, 'my_database.db');
    return await _dbFactory.openDatabase(dbPath);
  }

  Future<dynamic> _closeDatabase() async {
    return await _database.close();
  }

  @override
  Future<dynamic> storeCurrentUser(User user) async {
    final database = await _getDatabase();
    return await mainStore.record(CommonStorageConstant.KEY_CURRENT_USER).put(database, user.toJson());
  }

  @override
  Future<User> getCurrentUser() async {
    final database = await _getDatabase();
    final json = await mainStore.record(CommonStorageConstant.KEY_CURRENT_USER).get(database) as Map<String, dynamic>;
    return User.fromJson(json);
  }
}

abstract class CommonStorageManagerImp {
  Future<dynamic> storeCurrentUser(User user);

  Future<User> getCurrentUser();
}
