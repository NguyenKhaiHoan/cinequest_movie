// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SecureStorage {
//   static late FlutterSecureStorage _storage;

//   Future<void> initializeStorage() async {
//     AndroidOptions _getAndroidOptions() => const AndroidOptions(
//         encryptedSharedPreferences: true,
//       );
//       _storage = const FlutterSecureStorage(aOptions: _getAndroidOptions());
//   }

//   FlutterSecureStorage get prefs => _storage;

//   Future<void> setSecureData(String key, String value) async {
//     await _storage.write(key: key, value: value);
//   }

//   Future<String?> getSecureData(String key) async {
//     return await _storage.read(key: key);
//   }

//   Future<void> remove(String key) async {
//     await _storage.delete(key: key);
//   }

//   Future<void> clear() async {
//     await _storage.deleteAll();
//   }
// }
