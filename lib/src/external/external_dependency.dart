import 'package:cinequest/src/core/di/injection_container.dart';
import 'package:cinequest/src/core/network/dio_client.dart';
import 'package:cinequest/src/external/apis/themovidedb/tmdb_api.dart';
import 'package:cinequest/src/external/services/connectivity/connectivity_service.dart';
import 'package:cinequest/src/external/services/storage/local/get_storage_service.dart';
import 'package:cinequest/src/external/services/storage/local/secure_storage_service.dart';
import 'package:cinequest/src/external/services/storage/local/shared_preferences_service.dart';
import 'package:cinequest/src/external/services/storage/local/sqlite_service.dart';

class ExternalDependency {
  ExternalDependency._();

  static void init() {
    sl
      ..registerLazySingleton<DioClient>(DioClient.new)
      ..registerLazySingleton<TMDBApi>(() => TMDBApi(sl<DioClient>().dio))
      ..registerLazySingleton<ConnectivityService>(ConnectivityService.new)
      ..registerLazySingleton<GetStorageService>(GetStorageService.new)
      ..registerLazySingleton<SharedPreferencesService>(
        SharedPreferencesService.new,
      )
      ..registerLazySingleton<SqliteService>(
        SqliteService.new,
      )
      ..registerLazySingleton<SecureStorageService>(
        SecureStorageService.new,
      );
  }
}
