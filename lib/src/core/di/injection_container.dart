part of 'injection_container.import.dart';

/// Khởi tạo App
Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  await initDependencies();
}

/// Khởi tạo Firebase
Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

/// Khởi tạo phụ thuộc
Future<void> initDependencies() async {
  sl
      // Dio: registerLazySingleton
      .registerLazySingleton<DioClient>(DioClient.new);

  // Common
  CommonDependency.init();

  // External Dependencies: registerLazySingleton
  sl
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
  AuthDependency.init();

  // Data Sources: registerLazySingleton
  // ..registerLazySingleton<MovieApiNetworkDataSource>(
  //   () => MovieApiNetworkDataSourceImpl(tmdbApi: sl<TMDBApi>()),
  // )
  // ..registerLazySingleton<MovieLocalDataSource>(
  //   () => MovieSqliteServiceDataSourceImpl(
  //     sqliteService: sl<SqliteService>(),
  //   ),
  // )

  // Repositories: registerLazySingleton
  sl.registerLazySingleton<UserRepository>(UserRepositoryImpl.new);
  // ..registerLazySingleton<MovieRepository>(
  //   () => MovieRepositoryImpl(
  //     movieApiNetworkDataSource: sl<MovieApiNetworkDataSource>(),
  //     movieLocalDataSource: sl<MovieLocalDataSource>(),
  //   ),
  // )

  // Use Cases: registerLazySingleton
  // ..registerLazySingleton<GetNowPlayingMoviesUseCase>(
  //   () => GetNowPlayingMoviesUseCase(sl<MovieRepository>()),
  // )
  // ..registerLazySingleton<GetPopularMoviesUseCase>(
  //   () => GetPopularMoviesUseCase(sl<MovieRepository>()),
  // )
  // ..registerLazySingleton<GetProfileUserUseCase>(
  //   () => GetProfileUserUseCase(sl<AuthRepository>()),
  // )
  // ..registerLazySingleton<SaveProfileUserUseCase>(
  //   () => SaveProfileUserUseCase(sl<AuthRepository>()),
  // )
  // ..registerLazySingleton<SaveMovieLocalUseCase>(
  //   () => SaveMovieLocalUseCase(sl<MovieRepository>()),
  // )
  // ..registerLazySingleton<DeleteMovieLocalUseCase>(
  //   () => DeleteMovieLocalUseCase(sl<MovieRepository>()),
  // )
  // ..registerLazySingleton<GetMovieLocalUseCase>(
  //   () => GetMovieLocalUseCase(sl<MovieRepository>()),
  // )

  // App Logic: registerFactory
}
