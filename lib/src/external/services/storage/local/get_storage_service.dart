import 'package:get_storage/get_storage.dart';

class GetStorageService {
  static late GetStorage _storage;

  static Future<void> initializeStorage(String id) async {
    await GetStorage.init(id);
    _storage = GetStorage(id);
  }

  GetStorage get storage => _storage;

  Future<void> saveData<T>(String key, T value) async =>
      await _storage.write(key, value);

  T? getData<T>(String key) => _storage.read<T>(key);

  Future<void> remove(String key) async => await _storage.remove(key);

  bool contains(String key) => _storage.hasData(key);

  Future<void> clear() async => await _storage.erase();
}
