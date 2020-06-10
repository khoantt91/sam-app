import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager implements SecureStorageManagerImp {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  Future<void> write(String key, String value) => storage.write(key: key, value: value);

  @override
  Future<String> read(String key) => storage.read(key: key);

  @override
  Future<void> delete(String key) => storage.delete(key: key);

  @override
  Future<void> deleteAll() => storage.deleteAll();
}

abstract class SecureStorageManagerImp {
  Future<void> write(String key, String value);

  Future<String> read(String key);

  Future<void> delete(String key);

  Future<void> deleteAll();
}
